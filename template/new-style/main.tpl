<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title><?=$title;?></title>
    <meta name="description"
          content="GMS - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов"/>
    <meta name="keywords"
          content="мониторинг серверов, игровой мониторинг, gms, gms v2.0, система отслеживания за статусами игровых серверов, раскрутка сервера"/>
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
                GMS
            </a>

            <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                <li><a href="/" class="nav-link px-2 text-secondary">Главная</a></li>
                <li><a href="/listing" class="nav-link px-2 text-white">Листинг</a></li>
                <li><a href="/pay" class="nav-link px-2 text-white">Услуги</a></li>
                <li><a href="/banlist" class="nav-link px-2 text-white">Банлист</a></li>
                <li><a href="#" class="nav-link px-2 text-white">О нас</a></li>
            </ul>

            <form class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">

                <div class="input-group">

                    <input type="search" class="form-control form-control-dark form-control-sm" placeholder="Поиск..."
                           aria-label="Search">

                    <button type="button" class="btn btn-outline-warning">Найти</button>
                </div>


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


<footer class="text-center text-lg-start text-white mt-4" style="background-color: #3e4551">
    <div class="container p-4 pb-0">
        <section class="">
            <div class="row">
                <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                    <h5>Информация</h5>
                    <p><b>GMS</b> - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов</p>
                </div>

                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5>Меню</h5>
                    <ul class="list-unstyled mb-0">
                        <li>
                            <a href="#!" class="text-white">О нас</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Банлист</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Новости</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Помощь</a>
                        </li>
                    </ul>
                </div>

                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5>Меню</h5>

                    <ul class="list-unstyled mb-0">
                        <li>
                            <a href="#!" class="text-white">Услуги</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Раскрутка</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Авторизация</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Регистрация</a>
                        </li>

                    </ul>
                </div>


                <div class="col-lg-2 col-md-6 mb-4 mb-md-0">
                    <h5>Меню</h5>

                    <ul class="list-unstyled mb-0">
                        <li>
                            <a href="#!" class="text-white">Услуги</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Раскрутка</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Авторизация</a>
                        </li>
                        <li>
                            <a href="#!" class="text-white">Регистрация</a>
                        </li>

                    </ul>
                </div>
        </section>
        <hr class="mb-4"/>

    </div>

    <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2)">
        Powered by <a class="text-white" href="https://gamems.ru">GMS</a>
    </div>

</footer>


<script src="/public/new-style/js/bootstrap.bundle.min.js"></script>
<script src="/public/js/main.js"></script>
</body>
</html>