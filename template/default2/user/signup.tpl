<section class="content mt-5">
    <div class="container">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/">Главная</a></li>
                <li class="breadcrumb-item active" aria-current="page">Регистрация</li>
            </ol>
        </nav>


        <form id="signupForm" method="post">

            <div class="row">
                <div class="col-md-5">

                    <div class="mb-3">
                        <label for="firstname">Имя</label>
                        <input type="text" name="firstname" id="firstname" class="form-control form-control-sm" id="inputFirstname" required="">
                    </div>

                    <div class="mb-3">
                        <label for="lastname">Фамилия</label>
                        <input type="text" name="lastname" class="form-control form-control-sm" id="lastname" required="">
                    </div>

                    <div class="mb-3">
                        <label for="password">Пароль</label>
                        <input type="password" name="password" class="form-control form-control-sm" id="password" required="">
                    </div>

                    <div class="mb-3">
                        <label for="password2">Повторите пароль</label>
                        <input type="password" name="password2" class="form-control form-control-sm" id="password2" required="">
                    </div>

                    <div class="mb-3">
                        <label for="email">Электронная почта</label>
                        <input type="email" name="email" class="form-control form-control-sm" id="email" required="">
                    </div>

                    <div class="mb-3">
                        <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;">
                            <img src="/captcha" src="Каптча"/>
                        </a>
                    </div>

                    <div class="mb-3">
                        <label for="captcha">Цифры с картинки</label>
                        <input type="text" name="captcha" class="form-control form-control-sm" id="captcha" required=""/>
                        <small class="form-text text-muted">Если цифры не видны, то обновите картинку, кликнев на него.</small>
                    </div>

                    <div class="mb-3">
                        <input type="submit" class="btn btn-outline-success" value="Продолжить"/>
                    </div>

                </div>


            </div>
        </form>

    </div>
</section>





<script>
            $('#signupForm').ajaxForm({
                dataType: "json",
                success: function (data) {
                    switch (data.status) {
                        case "error":
                            ShowModal(data.error, 'answer', 'error');
                            break;

                        case "success":
                            ShowModal(data.success, 'answer', 'success');
                            break;


                    }
                },
            });
</script>