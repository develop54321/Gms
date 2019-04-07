<?php
abstract class BaseController{
    protected $view;
    public function __construct(){
        $this->view = new View(TMPL_DIR);
        $this->db = new Database();
    }
    public function ShowError($code, $data){
    switch($code){
        case "404":
         header("HTTP/1.0 404 Not Found");
        break;
        
        case "403":
        header('HTTP/1.0 403 Forbidden');

        break;
    }
       
        
    $content = $this->view->renderPartial("404", ['code' => $code, 'data' => $data]);
    
    $this->view->render("main", ['content' => $content, 'title' => $data]);
    exit();
        
    }

    public function isAjax(){
    if(!empty($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest') {   
     return true;   
    }

    }
}