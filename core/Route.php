<?php
namespace core;

use FastRoute;
use FastRoute\Dispatcher;
use FastRoute\RouteCollector;

class Route{

    private View $view;

    public function start(){
        $this->view = new View(TMPL_DIR);



        $dispatcher = \FastRoute\simpleDispatcher(function(RouteCollector $r) {
            $r->addRoute('GET', '/', ['controllers\MainController', 'index']);
            $r->addRoute('GET', '/stats', ['controllers\MainController', 'stats']);
            $r->addRoute('GET', '/listing', ['controllers\ListingController', 'index']);
            $r->addRoute(['GET', 'POST'], '/modal', ['controllers\ModalController', 'actionIndex']);
            $r->addRoute('GET', '/news', ['controllers\NewsController', 'index']);
            $r->addRoute('GET', '/boost', ['controllers\BoostController', 'index']);
            $r->addRoute('GET', '/banlist', ['controllers\BanlistController', 'index']);
            $r->addRoute('GET', '/page/{id:\d+}', ['controllers\PageController', 'index']);
            $r->addRoute(['GET', 'POST'], '/search', ['controllers\SearchController', 'index']);
            $r->addRoute('GET', '/captcha', ['controllers\MainController', 'captcha']);
            $r->addRoute(['GET', 'POST'], '/pay/server', ['controllers\PayController', 'server']);
            $r->addRoute(['GET', 'POST'], '/pay', ['controllers\PayController', 'index']);
            $r->addRoute('GET', '/pay/getform', ['controllers\PayController', 'getForm']);

            $r->addRoute(['GET', 'POST'], '/result', ['controllers\ResultController', 'index']);
            $r->addRoute('GET', '/result/success', ['controllers\ResultController', 'success']);
            $r->addRoute('GET', '/result/fail', ['controllers\ResultController', 'fail']);

            $r->addGroup('/server', function (RouteCollector $r) {
                $r->addRoute(['GET', 'POST'], '/add', ['controllers\ServerController', 'add']);
                $r->addRoute(['GET', 'POST'], '/{address}/info', ['controllers\ServerController', 'info']);
                $r->addRoute('POST', '/vote', ['controllers\ServerController', 'vote']);
                $r->addRoute('GET', '/getplayers', ['controllers\ServerController', 'getPlayers']);
                $r->addRoute('GET', '/verification', ['controllers\ServerController', 'verification']);
                $r->addRoute('POST', '/addcomment', ['controllers\ServerController', 'addComment']);
            });


            $r->addGroup('/user', function (RouteCollector $r) {
                $r->addRoute(['GET', 'POST'], '/login', ['controllers\UserController', 'login']);
                $r->addRoute(['GET', 'POST'], '/reset', ['controllers\UserController', 'reset']);
                $r->addRoute(['GET', 'POST'], '/signup', ['controllers\UserController', 'signup']);
                $r->addRoute('GET', '/logout', ['controllers\UserController', 'logout']);
                $r->addRoute('GET', '/servers', ['controllers\UserController', 'servers']);
                $r->addRoute('GET', '/removeserver', ['controllers\UserController', 'removeServer']);
                $r->addRoute(['GET', 'POST'], '/pay', ['controllers\UserController', 'pay']);
                $r->addRoute(['GET', 'POST'], '/serverpay', ['controllers\UserController', 'serverPay']);
                $r->addRoute(['GET', 'POST'], '/getform', ['controllers\UserController', 'getForm']);
                $r->addRoute('GET', '/pay-logs', ['controllers\UserController', 'payLogs']);
                $r->addRoute('GET', '', ['controllers\UserController', 'index']);
            });

            $r->addGroup('/control', function (RouteCollector $r) {
                $r->addRoute(['GET', 'POST'], '', ['controllers\control\IndexController', 'index']);
                $r->addRoute(['GET', 'POST'], '/login', ['controllers\control\IndexController', 'login']);
                $r->addRoute(['GET', 'POST'], '/reset', ['controllers\UserController', 'actionReset']);
                $r->addRoute(['GET', 'POST'], '/settings', ['controllers\control\SettingsController', 'index']);

                $r->addRoute('GET', '/paymethods', ['controllers\control\PaymethodsController', 'index']);
                $r->addRoute(['GET', 'POST'], '/paymethods/add', ['controllers\control\PaymethodsController', 'add']);
                $r->addRoute(['GET', 'POST'], '/paymethods/edit', ['controllers\control\PaymethodsController', 'edit']);
                $r->addRoute('GET', '/paymethods/remove', ['controllers\control\PaymethodsController', 'remove']);

                $r->addRoute('GET', '/games', ['controllers\control\GamesController', 'index']);
                $r->addRoute(['GET', 'POST'], '/games/add', ['controllers\control\GamesController', 'add']);
                $r->addRoute(['GET', 'POST'], '/game/edit', ['controllers\control\GamesController', 'edit']);
                $r->addRoute('GET', '/games/remove', ['controllers\control\GamesController', 'remove']);

                $r->addRoute('GET', '/codecolors', ['controllers\control\CodecolorsController', 'index']);
                $r->addRoute(['GET', 'POST'], '/codecolors/add', ['controllers\control\CodecolorsController', 'add']);
                $r->addRoute(['GET', 'POST'], '/codecolors/edit', ['controllers\control\CodecolorsController', 'edit']);
                $r->addRoute('GET', '/codecolors/remove', ['controllers\control\CodecolorsController', 'remove']);

                $r->addRoute('GET', '/services', ['controllers\control\ServicesController', 'index']);
                $r->addRoute(['GET', 'POST'], '/services/add', ['controllers\control\ServicesController', 'add']);
                $r->addRoute(['GET', 'POST'], '/services/edit', ['controllers\control\ServicesController', 'edit']);
                $r->addRoute('GET', '/services/remove', ['controllers\control\ServicesController', 'remove']);

                $r->addRoute('GET', '/users', ['controllers\control\UsersController', 'index']);
                $r->addRoute(['GET', 'POST'], '/users/search', ['controllers\control\UsersController', 'search']);
                $r->addRoute(['GET', 'POST'], '/users/edit', ['controllers\control\UsersController', 'edit']);
                $r->addRoute('GET', '/users/remove', ['controllers\control\UsersController', 'remove']);

                $r->addRoute('GET', '/servers', ['controllers\control\ServersController', 'index']);
                $r->addRoute(['GET', 'POST'], '/servers/search', ['controllers\control\ServersController', 'search']);
                $r->addRoute(['GET', 'POST'], '/servers/edit', ['controllers\control\ServersController', 'edit']);
                $r->addRoute('GET', '/servers/remove', ['controllers\control\ServersController', 'remove']);

                $r->addRoute('GET', '/comments', ['controllers\control\CommentsController', 'index']);
                $r->addRoute('GET', '/comments/search', ['controllers\control\CommentsController', 'search']);
                $r->addRoute(['GET', 'POST'], '/comments/edit', ['controllers\control\CommentsController', 'edit']);
                $r->addRoute(['GET', 'POST'], '/comments/moderation', ['controllers\control\CommentsController', 'edit']);
                $r->addRoute('GET', '/comments/remove', ['controllers\control\CommentsController', 'remove']);

                $r->addRoute('GET', '/pages', ['controllers\control\PagesController', 'index']);
                $r->addRoute(['GET', 'POST'], '/pages/add', ['controllers\control\PagesController', 'add']);
                $r->addRoute(['GET', 'POST'], '/pages/edit', ['controllers\control\PagesController', 'edit']);
                $r->addRoute('GET', '/pages/remove', ['controllers\control\PagesController', 'remove']);

                $r->addRoute('GET', '/news', ['controllers\control\NewsController', 'index']);
                $r->addRoute(['GET', 'POST'], '/news/add', ['controllers\control\NewsController', 'add']);
                $r->addRoute(['GET', 'POST'], '/news/edit', ['controllers\control\NewsController', 'edit']);
                $r->addRoute('GET', '/news/remove', ['controllers\control\NewsController', 'remove']);

                $r->addRoute('GET', '/paylogs', ['controllers\control\PaylogsController', 'index']);
                $r->addRoute('GET', '/paylogs/search', ['controllers\control\PaylogsController', 'search']);
                $r->addRoute(['GET', 'POST'], '/paylogs/add', ['controllers\control\PaylogsController', 'add']);
                $r->addRoute(['GET', 'POST'], '/paylogs/edit', ['controllers\control\PaylogsController', 'edit']);
                $r->addRoute('GET', '/paylogs/remove', ['controllers\control\PaylogsController', 'remove']);
                $r->addRoute('POST', '/modal', ['controllers\control\ModalController', 'index']);
            });

            $r->addGroup('/api', function (RouteCollector $r) {
                $r->addRoute(['POST'], '', ['controllers\ApiController', 'index']);
            });
        });


        $httpMethod = $_SERVER['REQUEST_METHOD'];
        $uri = $_SERVER['REQUEST_URI'];


        if ($pos = strpos($uri, '?')) {
            $uri = substr($uri, 0, $pos);
        }


        $routeInfo = $dispatcher->dispatch($httpMethod, $uri);


        switch ($routeInfo[0]) {
            case Dispatcher::NOT_FOUND:
                // Если маршрут не найден, можно вывести ошибку или выполнить другое действие
                $this->showError("404", "Page Not Found");
                break;
            case Dispatcher::METHOD_NOT_ALLOWED:
                // Если метод не разрешен для данного маршрута, можно вывести ошибку или выполнить другое действие
                echo '405 Method Not Allowed';
                break;
            case Dispatcher::FOUND:
                // Получаем информацию о контроллере и методе
                $controller = $routeInfo[1][0];
                $method = $routeInfo[1][1];


                // Вызываем контроллер и метод
                $instance = new $controller();
                call_user_func_array([$instance, $method], $routeInfo[2]);
                break;
        }
    }

    private function showError(int $code, string $data)
    {

        switch ($code) {
            case 404:
                header("HTTP/1.0 404 Not Found");
                break;

            case 403:
                header('HTTP/1.0 403 Forbidden');

                break;
        }


        $content = $this->view->renderPartial("404", ['code' => $code, 'data' => $data]);

        $this->view->render("main", ['content' => $content, 'title' => $data]);
        exit();

    }
}



