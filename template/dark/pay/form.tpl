<?php if ($type == 'top'): ?>
    <hr/>
    <?php if ($serverInfo['top_enabled'] === null): ?>
        <p>Выберите место в топе</p>
        <div class="top-place">
            <div class="d-flex gap-3 flex-wrap">
                <?php foreach ($top as $row): ?>
                    <?php if ($row['status'] == '0'): ?>
                        <input type="radio" id="<?php echo $row['id']; ?>" name="place" class="radio-tile" value="<?php echo $row['id']; ?>">
                        <label for="<?php echo $row['id']; ?>" class="radio-tile-label">
                            Место №<?php echo $row['id']; ?> свободно
                        </label>
                    <?php else:?>
                        <input type="radio" id="<?php echo $row['id']; ?>" name="place" class="radio-tile" value="<?php echo $row['id']; ?>">
                        <label for="<?php echo $row['id']; ?>" class="radio-tile-label">
                            Место №<?php echo $row['id']; ?> занято
                        </label>
                    <?php endif;?>
                <?php endforeach; ?>
            </div>
        </div>
        <?php else:?>
        Услуга будет продлена. <br/>
        Текущий срок действия оплачен до: <?php echo date("d.m.Y [H:i]", $serverInfo['top_expired_date']); ?>
    <?php endif; ?>

    <?php elseif ($type == 'vip'): ?>
        <?php if ($serverInfo['vip_enabled'] !== null): ?>
            <hr/>
            Услуга будет продлена. <br/>
            Текущий срок действия оплачен до: <?php echo date("d.m.Y [H:i]", $serverInfo['vip_expired_date']); ?>
        <?php endif;?>

    <?php elseif ($type == 'color'): ?>
        <hr/>
        <?php if ($serverInfo['color_enabled'] === null): ?>
        <p>Выберите цвет</p>
        <div class="colors">
            <div class="d-flex gap-3 flex-wrap">
                <?php foreach ($CodeColors as $row): ?>
                    <input type="radio" id="<?php echo $row['id']; ?>" name="color" class="radio-tile" value="<?php echo $row['code']; ?>">
                    <label for="<?php echo $row['id']; ?>" class="radio-tile-label" style="background: <?php echo $row['code']; ?>;">
                        <?php echo $row['name']; ?>
                    </label>
                <?php endforeach; ?>
            </div>
        </div>
            <?php else:?>
            Услуга будет продлена. <br/>
            Текущий срок действия оплачен до: <?php echo date("d.m.Y [H:i]", $serverInfo['color_expired_date']); ?>
        <?php endif;?>

    <?php elseif ($type == 'razz'): ?>
            <?php if ($serverInfo['ban'] == "0"): ?>
                <div class="alert alert-danger">
                    Вы не можете купить эту услугу, так как сервер не находится в бане.
                </div>
                <?php exit();?>
            <?php endif; ?>
    <?php elseif ($type == 'votes'): ?>
        <hr>
        Текущее количество голосов: <?php echo $serverInfo['rating']; ?>
    <?php elseif ($type == 'boost'): ?>
        <?php if ($serverInfo['boost'] !== null):?>
        <hr>
        Текущее количество кругов: <?php echo $serverInfo['boost']; ?>
        <?php endif; ?>
    <?php endif; ?>


    <?php if (isset($type)): ?>
    <div class="pay-methods">
        <hr/>
        <p class="text-muted mb-3">Выберите способ оплаты</p>
        <div class="service-grid compact mb-3">
            <?php foreach ($PayMethods as $pm): ?>
                <a href="#" class="service-tile" onclick="selectPaymentMethod('<?php echo $pm['id']; ?>', this); return false;">
                    <div class="card service-card">
                        <div class="card-body">
                            <h5 class="card-title"><?php echo $pm['name']; ?></h5>
                            <p class="card-text">
                                <?php echo $pm['text']; ?>
                            </p>
                        </div>
                    </div>
                </a>
            <?php endforeach; ?>

            <?php if ($user):?>
                <a href="#" class="service-tile" onclick="selectPaymentMethod('user_balance', this); return false;">
                    <div class="card service-card">
                        <div class="card-body">
                            <h5 class="card-title">Лицевой счет</h5>
                            <p class="card-text">
                                Баланс: <?php echo \widgets\money\Money::run($user['balance']); ?>
                            </p>
                        </div>
                    </div>
                </a>
            <?php endif;?>
        </div>

        <div class="price-summary">
            <span class="label">Стоимость</span>
            <span class="amount"><?php echo \widgets\money\Money::run($infoServices['price']); ?></span>
        </div>

        <div class="mt-3">
            <p class="text-muted">Нажимая оплатить вы соглашаетесь с условиями договора.</p>
            <div id="pay-button"></div>
        </div>
    </div>

    <?php endif; ?>

<script>
    $(document).ready(function () {

        <?php if ($type === 'top' or $type === "color"): ?>
        // $(".pay-methods").hide();

        <?php endif; ?>

        $('.colors .radio-tile').change(function() {
            if ($(".colors .radio-tile:checked").length > 0) {
                $('.pay-methods').fadeIn(300);
            } else {
                $('.pay-methods').fadeOut(300);
            }
        });

        $('.top-place .radio-tile').change(function() {
            if ($(".top-place .radio-tile:checked").length > 0) {
                $('.pay-methods').fadeIn(300);
            } else {
                $('.pay-methods').fadeOut(300);
            }
        });

    });


    function payUserBalance() {
        toggleButtonLoader($("#pay-button"), true);

        $.ajax({
            url: '/pay/<?php echo $serverInfo['id']; ?>/ajax',
            method: 'POST',
            dataType: 'json',
            data:  {
                id_services: <?php echo $idServices; ?>,
                place: document.querySelector(".top-place .radio-tile:checked")?.value || null,
                color: document.querySelector(".colors .radio-tile:checked")?.value || null
            },
            success: function(data) {
                switch (data.status) {
                    case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;

                    case "success":

                        ShowModal(data.success, 'answer', 'success');

                        if (data.redirect_href) {
                            setTimeout(function() {
                                window.location.href = data.redirect_href;
                            }, 3000);
                        }
                        break;
                }
                toggleButtonLoader($("#pay-button"), false);
            },
            error: function(xhr, status, error) {
                alert('Ошибка при запросе на сервер.');
                toggleButtonLoader($("#pay-button"), false);
            }
        });
    }

    function selectPaymentMethod(method, el) {
        toggleActivePayMethod(el);

        if (method === "user_balance") {
            $("#pay-button").replaceWith('<button id="pay-button" onclick="payUserBalance(); return false;" type="submit" class="btn btn-primary btn-sm">Оплатить</button>');
        } else {
            $("#pay-button").replaceWith('<button id="pay-button" type="submit" class="btn btn-primary btn-sm">Перейти к оплате</button>');

            fetch('/pay/<?php echo $serverInfo['id'];?>/get-pay-form', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(
                    {
                        id_services: <?php echo $idServices; ?>,
                        payment_method: method,
                        place: document.querySelector(".top-place .radio-tile:checked")?.value || null,
                        color: document.querySelector(".colors .radio-tile:checked")?.value || null
                    }
                )
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === "success") {
                        if (data.payment_url) {
                            document.getElementById('pay-button').onclick = function () {
                                window.location.href = data.payment_url;
                            };
                        } else if (data.payment_form) {
                            document.getElementById('pay-button').onclick = function () {
                                document.body.innerHTML += data.payment_form;
                                document.getElementById("paymentForm").submit();
                            };
                        }
                    }else if (data.status === "error") {
                        ShowModal(data.error, 'answer', 'error');
                    } else {
                        alert('Ошибка при получении данных для оплаты.');
                    }
                })
                .catch(error => {
                    console.error('Ошибка:', error);
                    alert('Ошибка при запросе на сервер.');
                });
        }
    }

    function toggleActive(element) {
        document.querySelectorAll('.card').forEach(card => {
            card.classList.remove('active');
        });

        element.querySelector('.card').classList.add('active');
    }

    function toggleActivePayMethod(element) {
        document.querySelectorAll('.pay-methods .card').forEach(card => {
            card.classList.remove('active');
        });

        element.querySelector('.card').classList.add('active');
    }




</script>
