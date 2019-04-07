<?php


class BanlistController extends BaseController{
    
    
    public function actionIndex(){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();   
        
    $title = "Банлист";
    
    $getBannisterServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ban != :ban');
    $getBannisterServers->execute(array(':ban' => '0')); 
    $getBannisterServers = $getBannisterServers->fetchAll();
    
    
        
    $content = $this->view->renderPartial("banlist", ['BannisterServers' => $getBannisterServers]);
    

    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
}