<section class="page user-refill">
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

            <div class="col-md-10">
                <?php echo widgets\flash\Flash::run(); ?>

                <div class="card p-4">

                        <!-- Выбор способа оплаты -->
                        <div class="mb-4">
                            <h5 class="mb-3">Выберите способ оплаты</h5>

                            <?php if (empty($pay_methods)):?>
                                <p class="text-center text-muted mb-0">К сожалению, в данный момент нет доступных способов оплаты.</p>
                            <?php else: ?>
                            <div class="service-grid compact">
                                <?php foreach ($pay_methods as $pm): ?>
                                    <div class="card service-card payment-method-card"
                                         onclick="selectPaymentMethod('<?php echo $pm['id']; ?>', this);"
                                         data-payment-id="<?php echo $pm['id']; ?>">
                                        <div class="card-body">
                                            <img src="<?php echo $pm['icon_path'] ?? 'not found'; ?>"
                                                 alt="<?php echo $pm['name']; ?>"
                                                 class="img-fluid">
                                            <h6 class="card-title"><?php echo $pm['name']; ?></h6>
                                            <small class="text-muted"><?php echo $pm['text']; ?></small>
                                        </div>
                                    </div>
                                <?php endforeach; ?>
                            </div>
                            <?php endif; ?>
                        </div>

                        <!-- Ввод суммы -->
                        <div class="mb-4">
                            <label for="amount" class="form-label">Введите сумму</label>

                            <div class="amount-box">
                                <input type="number"
                                       name="amount"
                                       id="amount"
                                       class="form-control border-0"
                                       required
                                       placeholder="0"
                                       min="0"
                                       step="1">
                                <span class="currency">₽</span>
                            </div>
                            <div class="invalid-feedback">
                                Пожалуйста, введите корректную сумму
                            </div>

                            <div class="quick-amounts">
                                <button type="button" class="btn btn-outline-primary quick-amount" data-amount="100">100 ₽</button>
                                <button type="button" class="btn btn-outline-primary quick-amount" data-amount="500">500 ₽</button>
                                <button type="button" class="btn btn-outline-primary quick-amount" data-amount="1000">1 000 ₽</button>
                            </div>

                            <div class="d-flex justify-content-between mt-2">
                                <small class="text-muted">Минимальная сумма: 10 ₽</small>
                                <small class="text-muted">Максимальная сумма: 50 000 ₽</small>
                            </div>
                        </div>

                        <input type="hidden" id="paymentId">


                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary" id="submit-btn" onclick="submit()" disabled>
                                <i class="fa fa-credit-card me-2"></i> Перейти к оплате
                            </button>
                        </div>


                        <!-- Соглашение -->
                        <div class="mt-3 text-center">
                            <small class="text-muted">
                                Нажимая "Перейти к оплате", вы соглашаетесь с
                                <a href="/page/3" target="_blank">условиями договора</a>
                            </small>
                        </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const amountInput = document.getElementById('amount');
        const quickAmountButtons = document.querySelectorAll('.quick-amount');
        const submitBtn = document.getElementById('submit-btn');
        let selectedPaymentId = null;

        quickAmountButtons.forEach(button => {
            button.addEventListener('click', function() {
                const amount = this.getAttribute('data-amount');
                amountInput.value = amount;

                quickAmountButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');

                validateForm();
            });
        });


        amountInput.addEventListener('input', function() {
            quickAmountButtons.forEach(btn => btn.classList.remove('active'));
            validateForm();
        });


        window.selectPaymentMethod = function(paymentId, element) {
            document.querySelectorAll('.payment-method-card').forEach(card => {
                card.classList.remove('border-primary', 'bg-primary-light');
            });
            element.closest('.payment-method-card').classList.add('border-primary', 'bg-primary-light');

            selectedPaymentId = paymentId;
            $("#paymentId").val(paymentId);

            validateForm();
        }

        function validateForm() {
            const amount = parseFloat(amountInput.value);
            const minAmount = 10;
            const maxAmount = 50000;

            const isAmountValid = !isNaN(amount) && amount >= minAmount && amount <= maxAmount;
            if (!isAmountValid) {
                amountInput.classList.add('is-invalid');
            } else {
                amountInput.classList.remove('is-invalid');
            }

            submitBtn.disabled = !(isAmountValid && selectedPaymentId);
        }

        // Функция отправки формы
        window.submit = function() {
            toggleButtonLoader($("#submit-btn"), true);

            fetch('/user/pay', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify({
                    typePayment: $("#paymentId").val(),
                    amount:  $("#amount").val(),
                })
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === "success") {
                        if (data.payment_url) {
                            window.location.href = data.payment_url;
                        } else if (data.payment_form) {
                            $('#paymentForm').remove();
                            $('body').append(data.payment_form);
                            $('#paymentForm').submit();
                            setTimeout(function () {
                                toggleButtonLoader($("#submit-btn"), false);
                            }, 1000);
                        }
                    } else if (data.status === "error") {
                        ShowModal(data.error, 'answer', 'error');
                        toggleButtonLoader($("#submit-btn"), false);
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
    });



</script>