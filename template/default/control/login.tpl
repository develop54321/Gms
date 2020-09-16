<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="assets/images/favicon_1.ico">
		<title><?=$title;?></title>

		<link href="/public/control/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/core.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/components.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/icons.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/pages.css" rel="stylesheet" type="text/css" />
        <link href="/public/control/css/responsive.css" rel="stylesheet" type="text/css" />

        <!-- HTML5 Shiv and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
        <![endif]-->
        <script src="/public/js/jquery.min.js"></script>
        <script src="/public/js/jquery.form.js"></script>
        <script src="/public/control/js/modernizr.min.js"></script>

	</head>
	<body>

		<div class="account-pages"></div>
		<div class="clearfix"></div>
		
		<div class="wrapper-page">
			<div class="card-box">
				<div class="panel-heading">
					<h3 class="text-center">Авторизация</h3>
				</div>

				<div class="panel-body">
					<form class="form-horizontal m-t-20" id="authForm" method="post">

						<div class="form-group ">
							<div class="col-xs-12">
								<input class="form-control" type="text" name="email" required="" placeholder="E-mail">
							</div>
						</div>

						<div class="form-group">
							<div class="col-xs-12">
								<input class="form-control" type="password" name="password" required="" placeholder="Пароль">
							</div>
						</div>

						<div class="form-group ">
							<div class="col-xs-12">
								<div class="checkbox checkbox-primary">
									<input id="checkbox-signup" type="checkbox">
									<label for="checkbox-signup"> Запомнить меня </label>
								</div>

							</div>
						</div>

						<div class="form-group text-center m-t-40">
							<div class="col-xs-12">
								<button class="btn btn-primary btn-block text-uppercase waves-effect waves-light" type="submit">
									Войти
								</button>
							</div>
						</div>

					
					</form>

				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 text-center">
					 Powered by <a href="http://art-gaisin.ru" target="_blank">GMS</a>
				</div>
			</div>

		</div>
        
        <script>
$('#authForm').ajaxForm({
   dataType: 'json',
   success: function(data) {
     switch(data.status){
        case "error":
        ShowModal(data.error, 'answer', 'error');
        break;
        
        case "success":
        ShowModal(data.success, 'answer', 'success');
        setTimeout("location.reload('')", 1500);
        break;
     }
   },                          
}); 
</script>

		<script>
			var resizefunc = [];
		</script>

        <script src="/public/control/js/bootstrap.min.js"></script>
        <script src="/public/control/js/detect.js"></script>
        <script src="/public/control/js/fastclick.js"></script>
        <script src="/public/control/js/jquery.slimscroll.js"></script>
        <script src="/public/control/js/jquery.blockUI.js"></script>
        <script src="/public/control/js/waves.js"></script>
        <script src="/public/control/js/wow.min.js"></script>
        <script src="/public/control/js/jquery.nicescroll.js"></script>
        <script src="/public/control/js/jquery.scrollTo.min.js"></script>


        <script src="/public/control/js/jquery.core.js"></script>
        <script src="/public/control/js/jquery.app.js"></script>
   <script src="/public/js/main.js"></script>
	</body>
</html>