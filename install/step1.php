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

<h1>Добро пожаловать в установщик скрипта <b>GMS</b></h1>
<hr>
<span class="badge badge-primary mb-2">Версия скрипта: <?php echo version;?></span>
<?php echo getSystemDemand(); ?>
</div>

</div>


<div class="col-md-3 pl-1">
<div class="column-right bg-white">
<ul class="nav flex-column">
<li>1. <span style="padding: 1px 3px 1px 0;color: #649c0a;font-weight: bold;">Системные требование</span></li>
<li><span>2. Конфигурация Mysql</span></li>
<li><span>3. Настройки доступа</span></li>
<li><span>4. Завершение установки</span></li>
</ul>
</div>
</div>

</div>
</div>

</div>



<?php


function getSystemDemand(){
$table = '<table class="table table-bordered">';
$statusButton = "";
if (version_compare(PHP_VERSION, '5.6') >= 0) {
    $table .= '<tr><td>Версия PHP(не ниже 5.6)</td>  <td style="text-align: center;"><i class="fa fa-check-square text-success" aria-hidden="true"></i> </td></tr>';
    }else{
    $statusButton = "disabled";   
    $table .= '<tr><td>Версия PHP(не ниже 5.6)</td>  <td style="text-align: center;"><i class="fa fa-warning text-danger" title="Ваша текущая версия PHP ниже рекомендуемого" aria-hidden="true"></i></td></tr>';
}




    if(extension_loaded('curl')){
        $table .= '<tr><td>Поддержка curl</td>  <td style="text-align: center;"><i class="fa fa-check-square text-success" aria-hidden="true"></i> </td></tr>';
    }else{
        $statusButton = "disabled";
        $table .= '<tr><td>Поддержка curl</td>  <td style="text-align: center;"><i class="fa fa-warning text-danger" aria-hidden="true"></i> </td></tr>';
    }






$table .= '</table>';

$table .= '<hr>
<a href="?step=2" class="btn btn-primary btn-sm '.$statusButton.'">Дальше</a>';

return $table;
}
?>