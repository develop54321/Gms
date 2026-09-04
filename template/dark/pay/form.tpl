<?php
$typeUnits = [
    'top' => 'дней', 'vip' => 'дней', 'color' => 'дней', 'gamemenu' => 'дней',
    'votes' => 'голосов', 'boost' => 'кругов',
];
$typeColors = [
    'top' => ['--accent-strong', '--accent-soft'],
    'vip' => ['--vip', '--vip-soft'],
    'color' => ['--violet', '--violet-soft'],
    'gamemenu' => ['--mint', '--mint-soft'],
    'votes' => ['--cyan', '--cyan-soft'],
    'boost' => ['--warn', '--warn-soft'],
    'razz' => ['--danger', '--danger-soft'],
];
$unit = $typeUnits[$type] ?? 'дней';
$hasPeriods = !empty($periods);
$svcColor = $typeColors[$type] ?? ['--accent-strong', '--accent-soft'];
?>
<?php if ($type == 'top'): ?>
    <hr/>
    <?php if ($serverInfo['top_enabled'] === null): ?>
        <div class="pay-substep-title"><i class="fa fa-map-marker"></i> Выберите место в топе</div>
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
        <div class="alert alert-info mb-0">Услуга будет продлена. Текущий срок действия оплачен до: <b><?php echo date("d.m.Y [H:i]", $serverInfo['top_expired_date']); ?></b></div>
    <?php endif; ?>

    <?php elseif ($type == 'vip'): ?>
        <?php if ($serverInfo['vip_enabled'] !== null): ?>
            <hr/>
            <div class="alert alert-info mb-0">Услуга будет продлена. Текущий срок действия оплачен до: <b><?php echo date("d.m.Y [H:i]", $serverInfo['vip_expired_date']); ?></b></div>
        <?php endif;?>

    <?php elseif ($type == 'color'): ?>
        <hr/>
        <?php if ($serverInfo['color_enabled'] === null): ?>
        <div class="pay-substep-title"><i class="fa fa-paint-brush"></i> Выберите цвет</div>
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
            <div class="alert alert-info mb-0">Услуга будет продлена. Текущий срок действия оплачен до: <b><?php echo date("d.m.Y [H:i]", $serverInfo['color_expired_date']); ?></b></div>
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
        <div class="alert alert-info mb-0">Текущее количество голосов: <b><?php echo $serverInfo['rating']; ?></b></div>
    <?php elseif ($type == 'boost'): ?>
        <?php if ($serverInfo['boost'] !== null):?>
        <hr>
        <div class="alert alert-info mb-0">Текущее количество кругов: <b><?php echo $serverInfo['boost']; ?></b></div>
        <?php endif; ?>
    <?php endif; ?>


    <?php if (isset($type)): ?>

    <?php if ($hasPeriods): ?>
        <hr/>
        <div class="pay-substep-title"><i class="fa fa-clock-o"></i> Выберите срок</div>
        <div class="tier-grid mb-3" style="--svc-color: var(<?php echo $svcColor[0]; ?>); --svc-soft: var(<?php echo $svcColor[1]; ?>);">
            <?php foreach ($periods as $p): ?>
                <input type="radio" id="tier_<?php echo $p['id']; ?>" name="period" class="tier-radio"
                       value="<?php echo $p['id']; ?>" data-price="<?php echo $p['price']; ?>">
                <label for="tier_<?php echo $p['id']; ?>" class="tier-card">
                    <span class="tier-period"><?php echo (int)$p['period']; ?> <?php echo $unit; ?></span>
                    <span class="tier-price"><?php echo \widgets\money\Money::run($p['price']); ?></span>
                </label>
            <?php endforeach; ?>
        </div>
    <?php endif; ?>

    <div class="pay-methods">
        <hr/>
        <div class="pay-substep-title"><i class="fa fa-credit-card"></i> Выберите способ оплаты</div>
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
            <span class="amount"><?php echo $hasPeriods ? 'Выберите срок' : \widgets\money\Money::run($infoServices['price']); ?></span>
        </div>

        <div class="mt-3">
            <p class="text-muted">Нажимая оплатить вы соглашаетесь с условиями договора.</p>
            <div id="pay-button"></div>
        </div>
    </div>

    <?php endif; ?>

<script>
    $(document).ready(function () {

        function payReady() {
            var ready = true;

            if ($('.top-place .radio-tile').length) {
                ready = ready && $('.top-place .radio-tile:checked').length > 0;
            }
            if ($('.colors .radio-tile').length) {
                ready = ready && $('.colors .radio-tile:checked').length > 0;
            }
            if ($('.tier-radio').length) {
                ready = ready && $('.tier-radio:checked').length > 0;
            }

            return ready;
        }

        function refreshPayMethods() {
            if (payReady()) {
                $('.pay-methods').fadeIn(200);
            } else {
                $('.pay-methods').hide();
            }
        }

        $(document).on('change', '.colors .radio-tile, .top-place .radio-tile, .tier-radio', refreshPayMethods);

        $('.tier-radio').on('change', function () {
            $('.price-summary .amount').text(formatMoney($(this).data('price')));
        });

        refreshPayMethods();
    });

    function formatMoney(value) {
        var parts = Number(value).toFixed(2).split('.');
        parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
        return parts.join('.') + ' руб.';
    }

    function selectedPeriodId() {
        var checked = document.querySelector('.tier-radio:checked');
        return checked ? checked.value : null;
    }

    function payUserBalance() {
        toggleButtonLoader($("#pay-button"), true);

        $.ajax({
            url: '/pay/<?php echo $serverInfo['id']; ?>/ajax',
            method: 'POST',
            dataType: 'json',
            data:  {
                id_services: <?php echo $idServices; ?>,
                id_period: selectedPeriodId(),
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
                        id_period: selectedPeriodId(),
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

    function toggleActivePayMethod(element) {
        document.querySelectorAll('.pay-methods .card').forEach(card => {
            card.classList.remove('active');
        });

        element.querySelector('.card').classList.add('active');
    }
</script>
