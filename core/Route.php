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
            $r->addRoute('GET', '/listing', ['controllers\ListingController', 'index']);
            $r->addRoute(['GET', 'POST'], '/modal', ['controllers\ModalController', 'actionIndex']);
            $r->addRoute('GET', '/pay', ['controllers\PayController', 'index']);
            $r->addRoute('GET', '/banlist', ['controllers\BanlistController', 'index']);
            $r->addRoute('GET', '/page/{id:\d+}', ['controllers\PageController', 'index']);
            $r->addRoute('POST', '/search', ['controllers\SearchController', 'index']);

            $r->addGroup('/server', function (RouteCollector $r) {
                $r->addRoute(['GET', 'POST'], '/add', ['controllers\ServerController', 'actionAdd']);
                $r->addRoute('GET', '/reset', ['controllers\UserController', 'actionReset']);
            });


            $r->addGroup('/user', function (RouteCollector $r) {
                $r->addRoute(['GET', 'POST'], '/login', ['controllers\UserController', 'actionLogin']);
                $r->addRoute(['GET', 'POST'], '/reset', ['controllers\UserController', 'actionReset']);
                $r->addRoute(['GET', 'POST'], '/signup', ['controllers\UserController', 'actionSignup']);
                $r->addRoute('GET', '/logout', ['controllers\UserController', 'actionLogout']);
                $r->addRoute('GET', '/servers', ['controllers\UserController', 'actionServers']);
                $r->addRoute('GET', '/pay', ['controllers\UserController', 'actionPay']);
                $r->addRoute('GET', '/pay-logs', ['controllers\UserController', 'actionPayLogs']);
                $r->addRoute('GET', '', ['controllers\UserController', 'actionIndex']);
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
                echo '404 Not Found';
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



//        $controllerName = "Main";
//        $actionName = "index";
//
//        $getUrl = self::rgp($_SERVER['REQUEST_URI']);
//
//        $uri = explode("/", $getUrl);
//        $uri = array_diff($uri, array(''));
//
//        if(isset($uri[1])) $controllerName = $uri[1];
//        if(isset($uri[2])) $actionName = $uri[2];
//
//
//        if(is_dir("controllers/$controllerName")){
//
//        if(isset($uri[2])){
//            $uriTwo = $uri[2];
//        }else{
//            $uri[2] = "index";
//        }
//            $controllerName =  ucfirst($uri[2])."Controller";;
//            $controllerPath = "\\controllers\\".$uri[1]."\\{$controllerName}";
//        if(isset($uri[3])) $actionName = "action".$uri[3];
//        else $actionName = "actionIndex";
//
//        }else{
//            $actionName = "action".$actionName;
//            $controllerName = ucfirst($controllerName)."Controller";
//            $controllerPath = "\\controllers\\$controllerName";
//        }
//
//        if(class_exists($controllerPath)) {
//            $controller = new $controllerPath;
//        }
//        else{
//            header("HTTP/1.0 404 Not Found");
//            $content = $this->view->renderPartial("404", ['code' => "404", 'data' => "Page Not Found"]);
//            $this->view->render("main", ['content' => $content, 'title' => '404 Page Not Found ', 'global_error' => true]);
//        }
//
//        if(method_exists($controller, $actionName)) $controller->$actionName();
//        else {
//            header("HTTP/1.0 404 Not Found");
//            $content = $this->view->renderPartial("404", ['code' => "404", 'data' => "Page Not Found"]);
//            $this->view->render("main", ['content' => $content, 'title' => '404 Page Not Found ', 'global_error' => true]);
//        }


    }

    public static function rgp($url) {
    return preg_replace('/^([^?]+)(\?.*?)?(#.*)?$/', '$1$3', $url);
    }

    public function showError(){

    }
}



