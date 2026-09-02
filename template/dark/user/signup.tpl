 <section class="page add-server">
            <div class="container">
                <h1 class="content-title">
                    Регистрация
                </h1>
                <hr/>

        <form id="signupForm" method="post">

            <div class="form-card wide">
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
                            <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;"></a>
                            <input type="text" name="captcha" class="form-control mt-2" id="captcha" required="" placeholder="Цифры с картинки"/>
                            <small class="form-text text-muted">Если цифры не видны, обновите изображение, нажав на него.</small>
                        </div>
                    </div>
                </div>

                <div class="mb-3">
                    <input type="submit" class="btn btn-primary" value="Отправить"/>
                </div>
            </div>
        </form>

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