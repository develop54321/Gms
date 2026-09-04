<?php
$brandFavicon = \components\Settings::global('favicon_path');
$brandDescription = \components\Settings::global('site_description');
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title><?=$title;?></title>
    <?php if ($brandFavicon): ?>
        <link rel="icon" href="<?php echo $brandFavicon; ?>?v=<?php echo @filemtime(ROOT_DIR . ltrim($brandFavicon, '/')); ?>">
    <?php else: ?>
        <link rel="icon" type="image/png" sizes="16x16" href="/public/img/favicon/favicon-16x16.png">
        <link rel="icon" type="image/png" sizes="32x32" href="/public/img/favicon/favicon-32x32.png">
        <link rel="shortcut icon" href="/public/img/favicon/favicon.ico">
    <?php endif; ?>
    <link rel="apple-touch-icon" sizes="180x180" href="/public/img/favicon/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="192x192" href="/public/img/favicon/android-chrome-192x192.png">
    <link rel="icon" type="image/png" sizes="512x512" href="/public/img/favicon/android-chrome-512x512.png">
    <link rel="manifest" href="/public/img/favicon/site.webmanifest">

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <meta name="description" content="<?php echo $brandDescription ?: 'GMS - это веб движок запрограммированный на языке PHP, для отслеживание за статусами игровых серверов'; ?>"/>
    <meta name="keywords" content="мониторинг серверов, игровой мониторинг, gms, gms v3.1.5, система отслеживания за статусами игровых серверов, раскрутка сервера"/>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Chakra+Petch:wght@500;600;700&family=Manrope:wght@400;500;600;700;800&display=swap">
    <link rel="stylesheet" href="/public/dark/css/style.css?v=1.0.9"/>
    <link rel="stylesheet" href="/public/dark/css/bootstrap.css"/>
    <link rel="stylesheet" href="/public/dark/css/roboto.css"/>
    <link rel="stylesheet" href="/public/css/font-awesome.min.css"/>
    <link rel="stylesheet" href="/public/dark/css/theme.css?v=2.3.0"/>
    <script src="/public/js/jquery.min.js"></script>
    <script src="/public/js/jquery.form.js"></script>
</head>
<body>
<div id="cookieBanner" class="position-fixed bottom-0 start-0 w-100 bg-dark text-white py-3 px-4 shadow" style="z-index: 1050; display: none;">
    <div class="container d-flex flex-column flex-md-row align-items-center justify-content-between gap-3">
        <div class="small">
            Мы используем файлы cookie для улучшения работы сайта и повышения удобства пользователей.
            Продолжая пользоваться сайтом, вы соглашаетесь с их использованием.
        </div>
        <div class="d-flex gap-2">
            <a href="/page/5" class="btn btn-outline-light btn-sm">Подробнее</a>
            <button id="acceptCookies" class="btn btn-primary btn-sm">
                Принять
            </button>
        </div>
    </div>
</div>

<div class="bg-mesh"></div>

<?php
   $getUrl = $_SERVER['REQUEST_URI'];
   $getUrl = substr($getUrl, 1);
   ?>

<div class="main">

    <header class="py-2">
        <div class="container site-header-inner">

            <?php widgets\dark\user\top_menu\TopMenu::run();?>

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
                            <p class="text-white-50">
                                GMS — инструмент на PHP, разработанный для автоматизированного отслеживания статусов игровых серверов и отображения их доступности.
                            </p>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                            <h5>Меню</h5>
                            <ul class="list-unstyled mb-0">
                                <li>
                                    <a href="#!">О нас</a>
                                </li>
                                <li>
                                    <a href="/banlist">Банлист</a>
                                </li>
                                <li>
                                    <a href="/news">Новости</a>
                                </li>
                                <li>
                                    <a href="#!">Помощь</a>
                                </li>
                            </ul>
                        </div>

                        <div class="col-lg-3 col-md-6 mb-4 mb-md-0">
                            <h5>Аккаунт</h5>

                            <ul class="list-unstyled mb-0">
                                <li>
                                    <a href="/pay">Услуги</a>
                                </li>
                                <li>
                                    <a href="/boost">Раскрутка</a>
                                </li>
                                <li>
                                    <a href="/user/login">Авторизация</a>
                                </li>
                                <li>
                                    <a href="/user/signup">Регистрация</a>
                                </li>

                            </ul>
                        </div>
                </section>
                <hr class="mb-4"/>
            </div>

            <div class="text-center p-3">
                Powered by <a href="https://game-ms.ru" target="_blank">GMS <?php echo VERSION;?></a>
            </div>
        </div>
    </div>

<div id="modalPreloader" class="modal-preloader d-none">
    <div class="spinner-border text-light" role="status">
        <span class="visually-hidden">Loading...</span>
    </div>
</div>

<script src="/public/new-style/js/bootstrap.bundle.min.js"></script>
<script src="/public/js/main.js"></script>
</body>
</html>