<?php
namespace core;

use controllers;

class Route{

    public function start(){
        $this->view = new View(TMPL_DIR);

        $controllerName = "Main";
        $actionName = "index";

        $getUrl = self::rgp($_SERVER['REQUEST_URI']);

        $uri = explode("/", $getUrl);
        $uri = array_diff($uri, array(''));

        if(isset($uri[1])) $controllerName = $uri[1];
        if(isset($uri[2])) $actionName = $uri[2];


        if(is_dir("controllers/$controllerName")){

        if(isset($uri[2])){
            $uriTwo = $uri[2];
        }else{
            $uri[2] = "index";
        }
            $controllerName =  ucfirst($uri[2])."Controller";;
            $controllerPath = "\\controllers\\".$uri[1]."\\{$controllerName}";
        if(isset($uri[3])) $actionName = "action".$uri[3];
        else $actionName = "actionIndex";

        }else{
            $actionName = "action".$actionName;
            $controllerName = ucfirst($controllerName)."Controller";
            $controllerPath = "\\controllers\\$controllerName";
        }

        if(class_exists($controllerPath)) {
            $controller = new $controllerPath;
        }
        else{
            header("HTTP/1.0 404 Not Found");
            $content = $this->view->renderPartial("404", ['code' => "404", 'data' => "Page Not Found"]);
            $this->view->render("main", ['content' => $content, 'title' => '404 Page Not Found ', 'global_error' => true]);
        }

        if(method_exists($controller, $actionName)) $controller->$actionName();
        else {
            header("HTTP/1.0 404 Not Found");
            $content = $this->view->renderPartial("404", ['code' => "404", 'data' => "Page Not Found"]);
            $this->view->render("main", ['content' => $content, 'title' => '404 Page Not Found ', 'global_error' => true]);
        }


    }

    public static function rgp($url) {
    return preg_replace('/^([^?]+)(\?.*?)?(#.*)?$/', '$1$3', $url);
    }

    public function showError(){

    }
}



