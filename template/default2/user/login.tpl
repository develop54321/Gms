
        <section class="page add-server">
            <div class="container">
                <h1 class="content-title">
                    Авторизация
                </h1>
                <hr/>

        <form id="loginForm" method="post">
            <div class="row">
                <div class="col-md-5">


                    <div class="mb-3">
                        <input type="email" name="email" class="form-control" id="email"
                               placeholder="Электронная почта">
                    </div>
                    <div class="mb-3">
                        <input type="password" name="password" class="form-control" id="password" placeholder="Пароль">
                    </div>

                    <div class="mb-3">
                        <input type="submit" class="btn btn-success" value="Войти"/>
                        <a href="/user/signup" class="btn btn-primary">Регистрация</a>
                        <a href="/user/reset" class="btn btn-primary">Забыли пароль?</a>
                    </div>

        </form>
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