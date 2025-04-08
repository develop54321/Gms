<?php if ($type == 'top'): ?>
    <hr/>
    <p>Выберите место в топе</p>

    <?php if ($serverInfo['top_enabled'] == '0'): ?>

        <div class="top-place">
            <div class="d-flex gap-3">
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
        <?php endif; ?>


    <?php elseif ($type == 'color'): ?>
    <hr/>
    <p>Выберите цвет</p>
    <div class="colors">
        <div class="d-flex gap-3">
            <?php foreach ($CodeColors as $row): ?>
                <input type="radio" id="<?php echo $row['id']; ?>" name="color" class="radio-tile" value="<?php echo $row['code']; ?>">
                <label for="<?php echo $row['id']; ?>" class="radio-tile-label" style="background: <?php echo $row['code']; ?>;">
                    <?php echo $row['name']; ?>
                </label>
            <?php endforeach; ?>
        </div>
    </div>


    <?php elseif ($type == 'razz'): ?>
        <?php if ($serverInfo['ban'] == "0"): ?>
            <div class="alert alert-danger">
                Вы не можете купить эту услугу, так как сервер не находится в бане.
            </div>
            <?php exit();?>
        <?php endif; ?>

    <?php endif; ?>

    <?php if (isset($type)): ?>
    <div class="pay-methods">
        <hr/>
        <p>Выберите способ оплаты</p>
        <div class="row">
            <?php foreach ($PayMethods as $pm): ?>
                <div class="col-sm-2 mb-3">
                    <a href="#" onclick="selectPaymentMethod('<?php echo $pm['id']; ?>', this); return false;">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title"><?php echo $pm['name']; ?></h5>
                                <p class="card-text">
                                    <?php echo $pm['text']; ?>
                                </p>
                            </div>
                        </div>
                    </a>
                </div>
            <?php endforeach; ?>

            <?php if ($user):?>
                <div class="col-sm-2 mb-3">
                    <a href="#" onclick="selectPaymentMethod('user_balance', this); return false;">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Личный счет</h5>
                                <p class="card-text">
                                    Баланс: <?php echo \widgets\money\Money::run($user['balance']); ?><br/>
                                </p>
                            </div>
                        </div>
                    </a>
                </div>
            <?php endif;?>
        </div>


        <div class="form-row mt-3">
            <div class="col-md-5">
                <h4>Стоимость: <?php echo \widgets\money\Money::run($infoServices['price']); ?></h4>
            </div>
        </div>


        <div class="form-row mt-3">
            <div class="col-md-5">
                <p>Нажимая оплатить вы соглашаетесь с условиями договора</p>
                <div id="pay-button"></div>
            </div>
        </div>
    </div>

    <?php endif; ?>

<script>
    $(document).ready(function () {

        <?php if ($type === 'top' or $type === "color"): ?>
        $(".pay-methods").hide();

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
            data: { 'id_services': <?php echo $infoServices['id']; ?> },
            success: function(data) {
                switch (data.status) {
                    case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;

                    case "success":
                        ShowModal(data.success, 'answer', 'success');
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
        toggleActive(el);

        if (method === "user_balance") {
            $("#pay-button").replaceWith('<button id="pay-button" onclick="payUserBalance(); return false;" type="submit" class="btn btn-primary btn-sm">Оплатить</button>');
        } else {
            $("#pay-button").replaceWith('<button id="pay-button" type="submit" class="btn btn-primary btn-sm">Перейти к оплате</button>');

            fetch('/pay/<?php echo $serverInfo['id'];?>/get-pay-form', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({payment_method: method})
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

    function toggleButtonLoader(button, isLoading) {
        if (isLoading) {
            $(button).prop('disabled', true).addClass('btn-loader').append('<span class="loader"></span>');
        } else {
            $(button).prop('disabled', false).removeClass('btn-loader').find('.loader').remove();
        }
    }

</script>
