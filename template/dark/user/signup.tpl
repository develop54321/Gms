<section class="auth-shell wide-form">
    <div class="auth-aside">
        <a href="/" class="auth-logo">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="6" rx="1.5"/><rect x="3" y="14" width="18" height="6" rx="1.5"/><circle cx="7" cy="7" r="1" fill="currentColor" stroke="none"/><circle cx="7" cy="17" r="1" fill="currentColor" stroke="none"/></svg>
            <span>GMS</span>
        </a>

        <h1>Присоединяйтесь к сообществу</h1>
        <p class="auth-lead">Создайте аккаунт, чтобы добавлять сервера, следить за рейтингом и получать доступ к платным услугам продвижения.</p>

        <ul class="auth-points">
            <li><i class="fa fa-plus"></i> Добавляйте сервера бесплатно</li>
            <li><i class="fa fa-line-chart"></i> Продвигайте их в топе и VIP</li>
            <li><i class="fa fa-credit-card"></i> Гибкая система оплаты услуг</li>
        </ul>

        <div class="auth-stats">
            <div class="stat"><b>24/7</b><span>Мониторинг</span></div>
            <div class="stat"><b>1000+</b><span>Серверов</span></div>
            <div class="stat"><b>&lt;1 мин</b><span>Обновление</span></div>
        </div>
    </div>

    <div class="auth-panel">
        <div class="auth-panel-inner">
            <span class="eyebrow">Аккаунт</span>
            <h2>Регистрация</h2>
            <p class="auth-panel-sub">Заполните данные, это займёт меньше минуты</p>

            <form id="signupForm" method="post" class="auth-form">
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="firstname">Имя</label>
                            <input type="text" name="firstname" class="form-control" id="firstname" required="">
                        </div>

                        <div class="mb-3">
                            <label for="lastname">Фамилия</label>
                            <input type="text" name="lastname" class="form-control" id="lastname" required="">
                        </div>

                        <div class="mb-3">
                            <label for="email">Электронная почта</label>
                            <input type="email" name="email" class="form-control" id="email" required="">
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="password">Пароль</label>
                            <input type="password" name="password" class="form-control" id="password" required="">
                        </div>

                        <div class="mb-3">
                            <label for="password2">Повторите пароль</label>
                            <input type="password" name="password2" class="form-control" id="password2" required="">
                        </div>

                        <div class="mb-3">
                            <label for="captcha">Цифры с картинки</label>
                            <a href="#" id="captchaImg" class="captcha-box" onclick="updateCaptcha(); return false;"></a>
                            <input type="text" name="captcha" class="form-control mt-2" id="captcha" required="" placeholder="Цифры с картинки"/>
                            <div class="captcha-hint"><i class="fa fa-refresh"></i> Не видно цифр? Нажмите на картинку.</div>
                        </div>
                    </div>
                </div>

                <input type="submit" class="btn btn-primary" value="Отправить"/>
            </form>

            <div class="auth-switch">
                <span>Уже есть аккаунт?</span>
                <a href="/user/login">Войти</a>
            </div>
        </div>
    </div>
</section>

<script>
    function updateCaptcha() {
        $("#captchaImg").html('<img src="/captcha?form=signup" src="Капча"/>');
    }
    updateCaptcha()

            $('#signupForm').ajaxForm({
                dataType: "json",
                success: function (data) {
                    switch (data.status) {
                        case "error":
                            updateCaptcha()
                            ShowModal(data.error, 'answer', 'error');
                            break;

                        case "success":
                            ShowModal(data.success, 'answer', 'success');
                            setTimeout(function(){
                                location.reload('/user')
                            }, 2000);
                            break;


                    }
                },
            });
</script>
