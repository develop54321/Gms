 <section class="page add-server">
            <div class="container">
                <h1 class="content-title">
                    Регистрация
                </h1>
                <hr/>

        <form id="signupForm" method="post">

            <div class="row">
                <div class="col-md-5">

                    <div class="mb-3">
                        <label for="password">Имя</label>
                        <input type="text" name="firstname" class="form-control" id="firstname" required="">
                    </div>

                    <div class="mb-3">
                        <label for="password">Фамилия</label>
                        <input type="text" name="lastname" class="form-control" id="lastname" required="">
                    </div>

                    <div class="mb-3">
                        <label for="password">Пароль</label>
                        <input type="password" name="password" class="form-control" id="password" required="">
                    </div>

                    <div class="mb-3">
                        <label for="password">Повторите пароль</label>
                        <input type="password" name="password2" class="form-control" id="password2" required="">
                    </div>

                    <div class="mb-3">
                        <label for="password">Электронная почта</label>
                        <input type="email" name="email" class="form-control" id="email" required="">
                    </div>

                    <div class="mb-3">
                        <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;">
                            <img src="/captcha" src="Капча"/>
                        </a>
                    </div>

                    <div class="mb-3">
                        <input type="text" name="captcha" class="form-control" id="captcha" required="" placeholder="Цифры с картинки"/>
                        <small class="form-text text-muted">Если цифры не видны, то обновите картинку, кликнев на него.</small>
                    </div>

                    <div class="mb-3">
                        <input type="submit" class="btn btn-primary" value="Отправить"/>
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