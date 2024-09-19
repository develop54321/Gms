<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title><?=$title;?></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="description" content="GMS - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов"/>
    <meta name="keywords" content="мониторинг серверов, игровой мониторинг, gms, gms v3.1, система отслеживания за статусами игровых серверов, раскрутка сервера"/>
    <link rel="stylesheet" href="/public/default2/css/style.css"/>
    <link rel="stylesheet" href="/public/default2/css/bootstrap.css"/>
    <link rel="stylesheet" href="/public/default2/css/roboto.css"/>
    <link rel="stylesheet" href="/public/css/font-awesome.min.css"/>
    <script src="/public/js/jquery.min.js"></script>
    <script src="/public/js/jquery.form.js"></script>
</head>
<body>
<div class="background"></div>
<div class="overlay"></div>

<?php
   $getUrl = $_SERVER['REQUEST_URI'];
   $getUrl = substr($getUrl, 1);
   ?>

<div class="main">

    <header class="p-3">
        <div class="container">
            <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
                <a href="/" class="d-flex align-items-center mb-2 mb-lg-0 text-decoration-none">
                    <b>GMS</b>
                </a>

                <ul class="nav col-12 col-lg-auto me-lg-auto mb-2 justify-content-center mb-md-0">
                    <li><a href="/" class="nav-link px-2">Главная</a></li>
                    <li><a href="/news" class="nav-link px-2">Новости</a></li>
                    <li><a href="/listing" class="nav-link px-2">Листинг</a></li>
                    <li><a href="/pay" class="nav-link px-2">Услуги</a></li>
                    <li><a href="/banlist" class="nav-link px-2">Банлист</a></li>
                    <li><a href="/page/1" class="nav-link px-2">Контакты</a></li>
                </ul>

                <form action="/search" method="post" class="col-12 col-lg-auto mb-3 mb-lg-0 me-lg-3">
                    <div class="input-group">
                        <input type="search" class="form-control form-control-dark form-control-sm" name="query" placeholder="Поиск..." aria-label="Поиск">
                        <button type="submit" class="btn btn-light">Найти</button>
                    </div>
                </form>

                <?php widgets\default2\user\top_menu\TopMenu::run();?>
            </div>
        </div>
    </header>




        <div class="main-content">
            <div class="container">
                <?php echo $content;?>
            </div>
        </div>


        <div class="footer text-center text-lg-start mt-4">
            <div class="container p-4 pb-0">
                <section class="">
                    <div class="row">
                        <div class="col-lg-4 col-md-6 mb-4 mb-md-0">
                            <h5>Информация</h5>
                            <p>
                                GMS — инструмент на PHP, разработанный для автоматизированного отслеживания статусов игровых серверов и отображения их доступности.
                            </p>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                            <h5>Меню</h5>
                            <ul class="list-unstyled mb-0">
                                <li>
                                    <a href="#!" class="text-white">О нас</a>
                                </li>
                                <li>
                                    <a href="#!" class="text-white">Банлист</a>
                                </li>
                                <li>
                                    <a href="/news" class="text-white">Новости</a>
                                </li>
                                <li>
                                    <a href="#!" class="text-white">Помощь</a>
                                </li>
                            </ul>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
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
                Powered by <a class="text-white" href="https://game-ms.ru" target="_blank">GMS <?php echo VERSION;?></a>
            </div>

        </div>
    </div>




<script src="/public/new-style/js/bootstrap.bundle.min.js"></script>
<script src="/public/js/main.js"></script>
</body>
</html>