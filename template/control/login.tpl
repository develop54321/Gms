<!DOCTYPE html>
<html lang="ru" dir="ltr">
<head>
    <meta charset="UTF-8">
    <meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
    <title><?php echo $title;?></title>

    <link id="style" href="/public/control/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <link href="/public/control/css/style.css" rel="stylesheet" />
    <link href="/public/control/css/skin-modes.css" rel="stylesheet" />
    <link href="/public/control/css/icons.css" rel="stylesheet" />
    <script src="/public/control/js/jquery.min.js"></script>
    <script src="/public/js/jquery.form.js"></script>
</head>

<body class="ltr">

    <div class="page">
        <div>
            <div class="container-login100">
                <div class="wrap-login100 p-0">
                    <div class="card-body">
                        <form class="login100-form validate-form" id="loginForm" method="post">
									<span class="login100-form-title">
										Войдите в систему
									</span>
                            <div class="form-message"></div>
                            <div class="wrap-input100 validate-input" data-bs-validate = "Valid email is required: ex@abc.xyz">
                                <input class="input100" type="text" name="email" placeholder="Email">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
											<i class="zmdi zmdi-email" aria-hidden="true"></i>
										</span>
                            </div>
                            <div class="wrap-input100 validate-input" data-bs-validate = "Password is required">
                                <input class="input100" type="password" name="password" placeholder="Пароль">
                                <span class="focus-input100"></span>
                                <span class="symbol-input100">
											<i class="zmdi zmdi-lock" aria-hidden="true"></i>
										</span>
                            </div>
                            <div class="container-login100-form-btn">
                                <button type="submit" class="login100-form-btn btn-primary">
                                    Войти
                                </button>
                            </div>
                        </form>
                    </div>

                    <div class="card-footer">
                        <p>
                            Powered by <a href="https://game-ms.ru" target="_blank">GMS <?php echo VERSION;?></a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>




    <!-- BOOTSTRAP JS -->
    <script src="/public/control/plugins/bootstrap/js/popper.min.js"></script>
    <script src="/public/control/plugins/bootstrap/js/bootstrap.min.js"></script>

    <!-- STICKY JS -->
    <script src="/public/control/js/sticky.js"></script>

    <!-- COLOR THEME JS -->
    <script src="/public/control/js/themeColors.js"></script>

    <!-- CUSTOM JS -->
    <script src="/public/control/js/custom.js"></script>
    <script src="/public/control/js/main.js"></script>
    <script>
        $(document).ready(function () {
            $("#loginForm").on("submit", function (e) {
                e.preventDefault();

                let form = $(this);
                let url = form.attr("action");
                let method = form.attr("method") || "POST";
                let formData = new FormData(this);

                $.ajax({
                    url: url,
                    type: method,
                    data: formData,
                    dataType: "json",
                    processData: false,
                    contentType: false,
                    success: function (response) {
                        switch(response.status){
                            case "error":
                                ShowModal(response.error, 'answer', 'error');
                                break;

                            case "success":
                                ShowModal(response.success, 'answer', 'success');
                                setTimeout(function(){
                                    location.reload('/control')
                                }, 2000);
                                break;
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Ошибка отправки:", error);
                        ShowModal("Ошибка при отправке формы.", 'answer', 'error');
                    }
                });
            });
        });

</script>



	</body>
</html>