<html lang="ru">
<head>
    <meta charset="utf-8">
    <title>Gms - веб движок :: Установка</title>
    <meta name="description" content="GMS - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов"/>
    <link rel="stylesheet" href="style.css"/>
    <link rel="stylesheet" href="/public/css/bootstrap.css"/>
    <link rel="stylesheet" href="/public/css/font-awesome.min.css"/>
    <script src="/public/js/jquery.min.js"></script>
    <meta name="robots" content="noindex">
</head>
<body>

<div class="wrapper">
<div class="container">
<div class="row">
<div class="col-md-9 pr-1">
<div class="content bg-white">

<h1>Настройки доступа</h1>
<hr>
<span class="badge badge-primary mb-2">Версия скрипта: <?php echo version;?></span>
<?php if(isset($error)) echo $error;?>
<form method="post">

  <div class="form-group row">
    <label for="email" class="col-sm-2 col-form-label">Email</label>
    <div class="col-sm-10">
      <input type="email" name="email" class="form-control" id="email" required>
    </div>
  </div>

  <div class="form-group row">
    <label for="password" class="col-sm-2 col-form-label">Пароль</label>
    <div class="col-sm-10">
      <input type="password" name="password" class="form-control" id="password" required>
    </div>
  </div>


<button type="submit" class="btn btn-primary btn-sm">Установить</button>
</form>

</div>

</div>


<div class="col-md-3 pl-1">
<div class="column-right bg-white">
<ul class="nav flex-column">
<li><span>1. Системные требование</span></li>
<li><span>2. Конфигурация Mysql</span></li>
<li>3. <span style="padding: 1px 3px 1px 0;color: #649c0a;font-weight: bold;">Настройки доступа</span></li>
<li><span>4. Завершение установки</span></li>
</ul>
</div>
</div>

</div>
</div>

</div>
