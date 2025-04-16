<section class="page">
    <div class="container">
        <h1 class="content-title">
            Пополнение счета
        </h1>
        <hr/>


        <div class="row">

            <div class="col-md-2">
                <?php $url = "pay";
                include("UserMenu.tpl"); ?>

            </div>

            <div class="col-md-10 mx-auto">
                <?php echo widgets\flash\Flash::run(); ?>

                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <h3 class="card-title mb-4">Пополнение баланса</h3>

                        <!-- Выбор способа оплаты -->
                        <div class="mb-4">
                            <h5 class="mb-3">Выберите способ оплаты</h5>
                            <div class="row g-3">
                                <?php foreach ($pay_methods as $pm): ?>
                                    <div class="col-sm-4 col-md-3 mb-3">
                                        <div class="payment-method-card card h-100 border-2"
                                             onclick="selectPaymentMethod('<?php echo $pm['id']; ?>', this);"
                                             data-payment-id="<?php echo $pm['id']; ?>">
                                            <div class="card-body text-center">
<!--                                                <div class="mb-2">-->
<!--                                                    <img src="--><?php //echo $pm['icon'] ?? 'https://via.placeholder.com/50'; ?><!--"-->
<!--                                                         alt="--><?php //echo $pm['name']; ?><!--"-->
<!--                                                         class="img-fluid" style="max-height: 50px;">-->
<!--                                                </div>-->
                                                <h6 class="card-title mb-1"><?php echo $pm['name']; ?></h6>
                                                <small class="text-muted"><?php echo $pm['text']; ?></small>
                                            </div>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                        </div>

                        <!-- Ввод суммы -->
                        <div class="mb-4">
                            <label for="amount" class="form-label">Введите сумму</label>
                            <div class="input-group has-validation">
                                <input type="number"
                                       name="amount"
                                       id="amount"
                                       class="form-control"
                                       required
                                       placeholder="0"
                                       min="1"
                                       step="1">
                                <span class="input-group-text">₽</span>
                                <div class="invalid-feedback">
                                    Пожалуйста, введите корректную сумму
                                </div>
                            </div>
                            <div class="d-flex justify-content-between mt-2">
                                <small class="text-muted">Минимальная сумма: 10 ₽</small>
                                <small class="text-muted">Максимальная сумма: 50 000 ₽</small>
                            </div>
                        </div>

                        <!-- Кнопка оплаты -->
                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary btn-sm" id="submit-btn" onclick="submit()" disabled>
                                <i class="bi bi-credit-card me-2"></i> Перейти к оплате
                            </button>
                        </div>

                        <!-- Соглашение -->
                        <div class="mt-3 text-center">
                            <small class="text-muted">
                                Нажимая "Перейти к оплате", вы соглашаетесь с
                                <a href="/terms" target="_blank">условиями договора</a>
                            </small>
                        </div>
                    </div>
                </div>
            </div>
                    </div>
            </div>

</section>
<script>
    // Выбор способа оплаты
    function selectPaymentMethod(paymentId, element) {
        // Удаляем активный класс у всех карточек
        document.querySelectorAll('.payment-method-card').forEach(card => {
            card.classList.remove('border-primary', 'bg-primary-light');
        });

        // Добавляем активный класс выбранной карточке
        element.closest('.payment-method-card').classList.add('border-primary', 'bg-primary-light');

        // Активируем кнопку оплаты
        document.getElementById('submit-btn').disabled = false;

        // Здесь можно добавить логику для выбранного метода оплаты
        console.log('Выбран метод оплаты:', paymentId);
    }

    // Валидация суммы
    document.getElementById('amount').addEventListener('input', function() {
        const amount = parseFloat(this.value);
        const minAmount = 10;
        const maxAmount = 50000;

        if (amount < minAmount || amount > maxAmount) {
            this.classList.add('is-invalid');
        } else {
            this.classList.remove('is-invalid');
        }
    });
</script>

<style>
    .card{
        color: #000;
    }
    .payment-method-card {
        cursor: pointer;
        transition: all 0.2s ease;
    }

    .payment-method-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
    }

    .payment-method-card.border-primary {
        border-color: #0d6efd !important;
    }

    .bg-primary-light {
        background-color: rgba(13, 110, 253, 0.05);
    }

    #submit-btn:disabled {
        opacity: 0.65;
        cursor: not-allowed;
    }
</style>
<script>
    function submit() {
        toggleButtonLoader($("#submit-btn"), true);




            fetch('/user/pay', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(
                    {
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
                    } else {
                        toggleButtonLoader($("#submit-btn"), false);
                        alert('Ошибка при получении данных для оплаты.');
                    }
                })
                .catch(error => {
                    toggleButtonLoader($("#submit-btn"), false);
                    console.error('Ошибка:', error);
                    alert('Ошибка при запросе на сервер.');
                });

    }


    function toggleButtonLoader(button, isLoading) {
        if (isLoading) {
            $(button).prop('disabled', true).addClass('btn-loader').append('<span class="loader"></span>');
        } else {
            $(button).prop('disabled', false).removeClass('btn-loader').find('.loader').remove();
        }
    }


</script>