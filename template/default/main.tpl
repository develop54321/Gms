<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="utf-8">
    <title><?=$title;?></title>
    <meta name="description" content="GMS - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов"/>
    <meta name="keywords" content="мониторинг серверов, игровой мониторинг, gms, gms v2.0"/>
    <link rel="stylesheet" href="/public/default/css/style.css"/>
    <link rel="stylesheet" href="/public/default/css/bootstrap.css"/>
    <link rel="stylesheet" href="/public/css/font-awesome.min.css"/>
    <script src="/public/js/jquery.min.js"></script>
    <script src="/public/js/jquery.form.js"></script>
  </head>
  <body>

   <div class="container">
   <div class="row">
     <div class="page">
   <?php
   $getUrl = $_SERVER['REQUEST_URI'];
   $getUrl = substr($getUrl, 1);
   ?>
   <div class="header">
  <div class="top-menu">
  <ul>
  <li><a href="/" <?php if($getUrl == ''):?>class="current-link"<?php endif;?>>Главная</a></li>
    <li><a href="/server/add" <?php if($getUrl == 'server/add'):?>class="current-link"<?php endif;?>>Добавить сервер</a></li>
  <li><a href="/pay" <?php if($getUrl == 'pay'):?>class="current-link"<?php endif;?>>Платные услуги</a></li>
  <li><a href="/news" <?php if($getUrl == 'news'):?>class="current-link"<?php endif;?>>Новости</a></li>
  <li><a href="/banlist" <?php if($getUrl == 'banlist'):?>class="current-link"<?php endif;?>>Банлист</a></li>
  <li><a href="/listing" <?php if($getUrl == 'listing'):?>class="current-link"<?php endif;?>>Листинг</a></li>
  <li><a href="/boost" <?php if($getUrl == 'boost'):?>class="current-link"<?php endif;?>>Раскрутка</a></li>
  <li><a href="/page/1" <?php if($getUrl == '/page?id=1'):?>class="current-link"<?php endif;?>>Контакты</a></li>

 
  <li style="float: right;"><a href="/user">Личный кабинет</a></li>
  

  </ul>
  

  
   <div class="clearfix"></div>
  </div>
  
  <div class="logo">
  <img src="/public/img/logo.png" alt="Логотип" />
  </div>
  
   </div>
    
  

<?=$content;?>









<div class="footer">

<p>
<b>Мониторинг серверов cs 1.6</b>
 Мы предоставляем такие услуги как раскрутка сервера cs 1.6. Вы можете поднять онлайн на своем сервере, например заказав услугу boost раскрутка сервера cs 1.6, аренда места в топе, vip статус и ряд других предложений. Добавляйте свои серваки кс 1.6 в мониторинг прямо сейчас!
</p>


<center>
<a style="display: block; color: #fff;" href="/page/2">Пользовательское соглашение</a>
       <div class="copyright">
       Copyright © <?php echo $_SERVER['HTTP_HOST']; echo " ".date("Y");?>  Все права защищены<br/>
              Powered by <a href="https://vk.com/dev_gamems" target="_blank"><?php echo VERSION;?></a>
        </div>
        </center>
        
        
        
        
       
      
       
      </div>

    </div>
    </div>
    </div>
   <script src="/public/js/bootstrap.bundle.min.js"></script>
   <script src="/public/js/main.js"></script>
  </body>
</html>