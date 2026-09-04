<section class="auth-shell">
    <div class="auth-aside">
        <a href="/" class="auth-logo">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8"><rect x="3" y="4" width="18" height="6" rx="1.5"/><rect x="3" y="14" width="18" height="6" rx="1.5"/><circle cx="7" cy="7" r="1" fill="currentColor" stroke="none"/><circle cx="7" cy="17" r="1" fill="currentColor" stroke="none"/></svg>
            <span>GMS</span>
        </a>

        <h1>С возвращением, командир</h1>
        <p class="auth-lead">Войдите в аккаунт, чтобы управлять своими серверами, следить за статистикой и оформлять услуги.</p>

        <ul class="auth-points">
            <li><i class="fa fa-server"></i> Мониторинг серверов 24/7</li>
            <li><i class="fa fa-bolt"></i> Мгновенное обновление статусов</li>
            <li><i class="fa fa-shield"></i> Безопасный личный кабинет</li>
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
            <h2>Авторизация</h2>
            <p class="auth-panel-sub">Введите email и пароль, чтобы продолжить</p>

            <form id="loginForm" method="post" class="auth-form">
                <div class="mb-3">
                    <label for="email">Электронная почта</label>
                    <input type="email" name="email" class="form-control" id="email" placeholder="you@example.com">
                </div>
                <div class="mb-3">
                    <label for="password">Пароль</label>
                    <input type="password" name="password" class="form-control" id="password" placeholder="Пароль">
                </div>

                <input type="submit" class="btn btn-primary" value="Войти"/>
            </form>

            <div class="auth-switch">
                <a href="/user/reset">Забыли пароль?</a>
                <span>·</span>
                <a href="/user/signup">Создать аккаунт</a>
            </div>
        </div>
    </div>
</section>

<script>
    $(document).ready(function () {
        $('#loginForm').ajaxForm({
            dataType: "json",
            success: function (data) {
                switch (data.status) {
                    case "error":
                        ShowModal(data.error, 'answer', 'error');
                        break;

                    case "success":
                        ShowModal(data.success, 'answer', 'success');
                        setTimeout('location.replace("/user")', 2000);
                        break;


                }
            },
        });
    });
</script>
