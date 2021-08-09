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

       <header class="p-3 bg-dark text-white">
           <div class="container">
               <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                   <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-white text-decoration-none">
                       <svg class="bi me-2" width="40" height="32" role="img" aria-label="Bootstrap"><use xlink:href="#bootstrap"></use></svg>
                   </a>

                   <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                       <li><a href="/" class="nav-link px-2 text-secondary">Главная</a></li>
                       <li><a href="/listing" class="nav-link px-2 text-white">Листинг</a></li>
                       <li><a href="/pay" class="nav-link px-2 text-white">Услуги</a></li>
                       <li><a href="/banlist" class="nav-link px-2 text-white">Банлист</a></li>
                       <li><a href="#" class="nav-link px-2 text-white">О нас</a></li>
                   </ul>

                   <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
                       <input type="search" class="form-control form-control-dark" placeholder="Поиск..." aria-label="Search">
                   </form>

                   <?php widgets\user\top_menu\TopMenu::run();?>
               </div>
           </div>
       </header>



   <?php
   $getUrl = $_SERVER['REQUEST_URI'];
   $getUrl = substr($getUrl, 1);
   ?>

  

<?=$content;?>








       <footer class="pt-4 my-md-5 pt-md-5 border-top">
           <div class="container">
           <div class="row">
               <div class="col-12 col-md">
                   <img class="mb-2" src="/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="24" height="19">
                   <small class="d-block mb-3 text-muted">Copyright © <?php echo $_SERVER['HTTP_HOST']; echo " ".date("Y");?>  Все права защищены<br/>
                       Powered by <a href="https://vk.com/web2424" target="_blank">GMS v2.0</a></small>
               </div>
               <div class="col-6 col-md">
                   <h5>Features</h5>
                   <ul class="list-unstyled text-small">
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Cool stuff</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Random feature</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Team feature</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Stuff for developers</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Another one</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Last time</a></li>
                   </ul>
               </div>
               <div class="col-6 col-md">
                   <h5>Resources</h5>
                   <ul class="list-unstyled text-small">
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Resource</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Resource name</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Another resource</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Final resource</a></li>
                   </ul>
               </div>
               <div class="col-6 col-md">
                   <h5>About</h5>
                   <ul class="list-unstyled text-small">
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Team</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Locations</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Privacy</a></li>
                       <li class="mb-1"><a class="link-secondary text-decoration-none" href="#">Terms</a></li>
                   </ul>
               </div>
           </div>
           </div>
       </footer>



   <script src="/public/js/bootstrap.bundle.min.js"></script>
   <script src="/public/js/main.js"></script>
  </body>
</html>