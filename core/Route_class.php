<?php

class Route{
    
    public function __construct(){
        $this->view = new View(TMPL_DIR);

        $controller_name = "Main";
        $action_name = "index";
        
        $getUrl = self::rgp($_SERVER['REQUEST_URI']);

        $uri = explode("/", $getUrl);        
        $uri = array_diff($uri, array(''));
        
        if(isset($uri[1])) $controller_name = $uri[1];
        if(isset($uri[2])) $action_name = $uri[2];
            
        
        $path = null;    
      
        if(is_dir("controllers/$controller_name")){
     
        if(isset($uri[2])){
            $uriTwo = $uri[2];
        }else{
            $uri[2] = "index";
        }
        
        $controller_name =  ucfirst($uri[2])."Controller";;        
        $controller_path = "controllers/".$uri[1]."/{$controller_name}.php";
        if(isset($uri[3])) $action_name = "action".$uri[3];
        else $action_name = "actionIndex";

        }else{
     
        $action_name = "action".$action_name;
        $controller_name = ucfirst($controller_name)."Controller";
        $controller_path = "controllers/{$controller_name}.php";
        }


        if(file_exists($controller_path)) $controller = new $controller_name;
        else{
            header("HTTP/1.0 404 Not Found");
            $content = $this->view->renderPartial("404", ['code' => "404", 'data' => "Page Not Found"]);
            $this->view->render("main", ['content' => $content, 'title' => '404 Page Not Found ', 'global_error' => true]);
        }

        if(method_exists($controller, $action_name)) $controller->$action_name();
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



