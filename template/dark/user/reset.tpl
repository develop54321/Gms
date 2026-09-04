<?php if (isset($password)): ?>

    <section>
        <div class="container">
            <div class="status-card">
                <div class="status-icon success"><i class="fa fa-key"></i></div>
                <h1 style="font-size:22px;">Пароль восстановлен</h1>
                <p>Сохраните новый пароль в надёжном месте — он понадобится для входа в аккаунт.</p>

                <div class="verify-code" style="justify-content:center;">
                    <code id="reset-password" class="me-2"><?php echo $password; ?></code>
                    <button class="btn btn-sm btn-outline-secondary ms-auto" id="copy-password">Скопировать</button>
                </div>

                <a href="/user/login" class="btn btn-primary mt-3">Войти в аккаунт</a>
            </div>
        </div>
    </section>

    <script>
        $('#copy-password').on('click', function () {
            const text = $('#reset-password').text().trim();
            navigator.clipboard.writeText(text).then(() => {
                $(this).text('Скопировано ✓').prop('disabled', true);
            });
        });
    </script>

<?php else: ?>

    <section class="auth-shell">
        <div class="auth-aside">
            <a href="/" class="auth-logo">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="6" rx="1.5"/><rect x="3" y="14" width="18" height="6" rx="1.5"/><circle cx="7" cy="7" r="1" fill="currentColor" stroke="none"/><circle cx="7" cy="17" r="1" fill="currentColor" stroke="none"/></svg>
                <span>GMS</span>
            </a>

            <h1>Восстановление доступа</h1>
            <p class="auth-lead">Укажите email, указанный при регистрации — мы сразу сгенерируем новый пароль для входа.</p>

            <ul class="auth-points">
                <li><i class="fa fa-envelope"></i> Проверка по email</li>
                <li><i class="fa fa-bolt"></i> Новый пароль мгновенно</li>
                <li><i class="fa fa-shield"></i> Аккаунт остаётся защищён</li>
            </ul>
        </div>

        <div class="auth-panel">
            <div class="auth-panel-inner">
                <span class="eyebrow">Аккаунт</span>
                <h2>Восстановление пароля</h2>
                <p class="auth-panel-sub">Введите почту, привязанную к аккаунту</p>

                <form id="resetForm" method="post" class="auth-form">
                    <div class="mb-3">
                        <label for="email">Электронная почта</label>
                        <input type="email" name="email" class="form-control" id="email">
                    </div>

                    <div class="mb-3">
                        <label for="captcha">Цифры с картинки</label>
                        <a href="#" id="captchaImg" class="captcha-box" onclick="updateCaptcha(); return false;"></a>
                        <input type="text" name="captcha" class="form-control mt-2" id="captcha" required="" placeholder="Цифры с картинки"/>
                        <div class="captcha-hint"><i class="fa fa-refresh"></i> Не видно цифр? Нажмите на картинку.</div>
                    </div>

                    <input type="submit" class="btn btn-primary" value="Отправить"/>
                </form>

                <div class="auth-switch">
                    <a href="/user/login">Вспомнили пароль? Войти</a>
                </div>
            </div>
        </div>
    </section>

    <script>
        function updateCaptcha() {
            $("#captchaImg").html('<img src="/captcha?form=reset" src="Капча"/>');
        }
        updateCaptcha()


        $(document).ready(function () {
            $('#resetForm').ajaxForm({
                dataType: "json",
                success: function (data) {
                    switch (data.status) {
                        case "error":
                            updateCaptcha()
                            ShowModal(data.error, 'answer', 'error');
                            break;

                        case "success":
                            ShowModal(data.success, 'answer', 'success');
                            break;


                    }
                },
            });
        });
    </script>

<?php endif; ?>
