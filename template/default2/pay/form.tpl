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
                    <a href="#" onclick="selectPaymentMethod('<?php echo $pm['id']; ?>'); return false;">
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
                    <a href="#" onclick="selectPaymentMethod('user_balance'); return false;">
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
                <button id="pay-button" type="submit" class="btn btn-primary btn-sm disabled">Перейти к оплате</button>
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

    //logic pay user_balance

    function selectPaymentMethod(method) {

        fetch('/pay/<?php echo $serverInfo['id'];?>/get-pay-form', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ payment_method: method }) // Отправляем выбранный способ
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // Если успешный ответ, активируем кнопку и добавляем форму или ссылку для оплаты
                    document.getElementById('pay-button').classList.remove('disabled');

                    // Здесь можно динамически добавить форму или ссылку для оплаты
                    // Пример:
                    if (data.payment_url) {
                        // Если пришла ссылка для оплаты
                        document.getElementById('pay-button').onclick = function() {
                            window.location.href = data.payment_url;
                        };
                    } else if (data.payment_form) {
                        // Если пришла форма для оплаты
                        document.getElementById('pay-button').onclick = function() {
                            document.body.innerHTML += data.payment_form; // Добавляем форму на страницу
                        };
                    }
                } else {
                    // Обработка ошибки, если что-то пошло не так
                    alert('Ошибка при получении данных для оплаты.');
                }
            })
            .catch(error => {
                console.error('Ошибка:', error);
                alert('Ошибка при запросе на сервер.');
            });
    }
</script>
