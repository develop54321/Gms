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


    #submit-btn:disabled {
        opacity: 0.65;
        cursor: not-allowed;
    }

    .invalid-feedback {
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        z-index: 1;
    }
</style>
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
                                                <div class="mb-2">
                                                    <img src="<?php echo $pm['icon_path'] ?? 'not found'; ?>"
                                                         alt="<?php echo $pm['name']; ?>"
                                                         class="img-fluid" style="max-height: 50px;">
                                                </div>
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
                                       min="0"
                                       step="1">
                                <span class="input-group-text">₽</span>
                                <div class="invalid-feedback">
                                    Пожалуйста, введите корректную сумму
                                </div>
                            </div>

                            <div class="d-flex flex-wrap gap-2 mb-3 mt-4">
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
                        <input type="hidden" id="amount">


                        <div class="d-grid gap-2 mt-4">
                            <button type="submit" class="btn btn-primary btn-sm" id="submit-btn" onclick="submit()" disabled>
                                <i class="bi bi-credit-card me-2"></i> Перейти к оплате
                            </button>
                        </div>


                        <!-- Соглашение -->
                        <div class="mt-3 text-center">
                            <small class="text-muted">
                                Нажимая "Перейти к оплате", вы соглашаетесь с
                                <a href="#" target="_blank">условиями договора</a>
                            </small>
                        </div>
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

        quickAmountButtons.forEach(button => {
            button.addEventListener('click', function() {
                const amount = this.getAttribute('data-amount');
                amountInput.value = amount;

                quickAmountButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
            });
        });

        amountInput.addEventListener('input', function() {
            quickAmountButtons.forEach(btn => btn.classList.remove('active'));
        });
    });


    // Выбор способа оплаты
    function selectPaymentMethod(paymentId, element) {
        document.querySelectorAll('.payment-method-card').forEach(card => {
            card.classList.remove('border-primary', 'bg-primary-light');
        });
        element.closest('.payment-method-card').classList.add('border-primary', 'bg-primary-light');
        document.getElementById('submit-btn').disabled = false;
        $("#paymentId").val(paymentId)
    }

    // Валидация суммы
    document.getElementById('amount').addEventListener('input', function() {
        const amount = parseFloat(this.value);
        const minAmount = 10;
        const maxAmount = 50000;

        if (amount < minAmount || amount > maxAmount) {
            this.classList.add('is-invalid');
            document.getElementById('submit-btn').disabled = true;
        } else {
            this.classList.remove('is-invalid');
            document.getElementById('submit-btn').disabled = false;
        }
    });


    function submit() {
        toggleButtonLoader($("#submit-btn"), true);
            fetch('/user/pay', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'X-Requested-With': 'XMLHttpRequest'
                },
                body: JSON.stringify(
                    {
                        typePayment: $("#paymentId").val(),
                        amount:  $("#amount").val(),
                    }
                )
            })
                .then(response => response.json())
                .then(data => {
                    if (data.status === "success") {
                        if (data.payment_url) {
                            window.location.href = data.payment_url;
                        } else if (data.payment_form) {
                            document.body.innerHTML += data.payment_form;
                            document.getElementById("paymentForm").submit();
                            setTimeout(function () {
                                toggleButtonLoader($("#submit-btn"), false);
                            }, 1000)
                        }
                    }else if (data.status === "error") {
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


</script>