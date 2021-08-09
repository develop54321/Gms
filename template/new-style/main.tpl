<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="utf-8">
    <title><?=$title;?></title>
    <meta name="description" content="GMS - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов"/>
    <meta name="keywords" content="мониторинг серверов, игровой мониторинг, gms, gms v2.0, система отслеживания за статусами игровых серверов, раскрутка сервера"/>
    <link rel="stylesheet" href="/public/new-style/css/style.css"/>
    <link rel="stylesheet" href="/public/new-style/css/bootstrap.css"/>
    <link rel="stylesheet" href="/public/css/font-awesome.min.css"/>
    <script src="/public/js/jquery.min.js"></script>
    <script src="/public/js/jquery.form.js"></script>
  </head>
  <body>

   <div class="container-fluid">
   <div class="row">
       <header class="p-3 bg-dark text-white">
           <div class="container">
               <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                   <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                       <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstrap"></use></svg>
                   </a>

                   <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                       <li><a href="#" class="nav-link px-2 text-secondary">Главная</a></li>
                       <li><a href="#" class="nav-link px-2 text-white">Листинг</a></li>
                       <li><a href="#" class="nav-link px-2 text-white">Услуги</a></li>
                       <li><a href="#" class="nav-link px-2 text-white">Банлист</a></li>
                       <li><a href="#" class="nav-link px-2 text-white">О нас</a></li>
                   </ul>

                   <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
                       <input type="search" class="form-control form-control-dark" placeholder="Поиск..." aria-label="Search">
                   </form>

                   <div class="text-end">
                       <button type="button" class="btn btn-outline-light me-2">Авторизация</button>
                       <button type="button" class="btn btn-warning">Регистрация</button>
                   </div>
               </div>
           </div>
       </header>



   <?php
   $getUrl = $_SERVER['REQUEST_URI'];
   $getUrl = substr($getUrl, 1);
   ?>

  

<?=$content;?>









<div class="footer">

<p>
<b>Мониторинг серверов cs 1.6</b>
 Мы предоставляем такие услуги как раскрутка сервера cs 1.6. Вы можете поднять онлайн на своем сервере, например заказав услугу boost раскрутка сервера cs 1.6, аренда места в топе, vip статус и ряд других предложений. Добавляйте свои серваки кс 1.6 в мониторинг прямо сейчас!
</p>


<center>
<a style="display: block; color: #fff;" href="/page?id=2">Пользовательское соглашение</a>
       <div class="copyright">
       Copyright © <?php echo $_SERVER['HTTP_HOST']; echo " ".date("Y");?>  Все права защищены<br/>
              Powered by <a href="https://vk.com/web2424" target="_blank">GMS v2.0</a>
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