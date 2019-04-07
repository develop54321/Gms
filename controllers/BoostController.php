<?php


class BoostController extends BaseController{
    
    
    public function actionIndex(){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();   
        
    $title = "Boost раскрутка";
    
    $getBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost and status = :status ORDER BY boost_position DESC');
    $getBoostServers->execute(array(':boost' => 0, ':status' => 1)); 
    $getBoostServers = $getBoostServers->fetchAll();
    
    
        
    $content = $this->view->renderPartial("boost", ['boostServers' => $getBoostServers]);
    

    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
    
    
    
}