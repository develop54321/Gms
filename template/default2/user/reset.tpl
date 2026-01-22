<section class="page pay">
    <div class="container">
        <h1 class="content-title">
            Восстановления пароля
        </h1>
        <hr/>

        <?php if (isset($password)): ?>

            <div class="col-md-4">

                <div class="mb-3">
                    <label for="password">Ваш новый пароль</label>
                    <input type="text" class="form-control" value="<?php echo $password; ?>">
                </div>

            </div>


        <?php else: ?>
        <form id="resetForm" method="post">
            <div class="row">
                <div class="col-md-4">
                <div class="mb-3">
                        <label for="email">Электронная почта</label>
                        <input type="email" name="email" class="form-control" id="email">
                    </div>



                <div class="mb-3">
                    <a href="#" id="captchaImg" onclick="updateCaptcha(); return false;"></a>
                </div>


                <div class="mb-3">
                    <input type="text" name="captcha" class="form-control" id="captcha" required="" placeholder="Цифры с картинки"/>
                    <small class="form-text text-muted">Если цифры не видны, обновите изображение, нажав на него.</small>
                </div>
                </div>
            </div>
            <div class="mb-3">
                <input type="submit" class="btn btn-primary" value="Отправить"/>
            </div>



        </form>
    </div>

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

</section>
