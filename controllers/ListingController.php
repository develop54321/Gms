<?php


class ListingController extends BaseController{
    
    
    public function actionIndex(){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();   
    $settings = json_decode($settings['content'], true);
    $title = "Листинг серверов";
    
    $countTopPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled != :top_enabled');
    $countTopPlace->execute(array(':top_enabled' => 0)); 
    $countTopPlace = $countTopPlace->rowCount();
    
    
    $topServers = [];
    for($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++){
    $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
    $isPlace->execute(array(':top_enabled' => $i));    
    if($isPlace->rowCount() != '0'){
    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
    $getInfoServer->execute(array(':top_enabled' => $i));
    $getInfoServer = $getInfoServer->fetch();
    $topServers[] = ['id_position' => $i, 'id' => $getInfoServer['id'], 'ip' => $getInfoServer['ip'], 'port' => $getInfoServer['port'], 'status' => 1];
    }else{
      $topServers[] = ['id_position' => $i, 'id' => '', 'hostname' => 'Место свободно', 'ip' => '127.0.1', 'port' => 27015, 'status' => 0];  
    }    
    }
    
    
    $countVipServers = $this->db->prepare('SELECT * FROM ga_servers WHERE vip_enabled != :vip_enabled');
    $countVipServers->execute(array(':vip_enabled' => 0)); 
    $countVipServers = $countVipServers->rowCount();
    
    $getVipServers = $this->db->prepare('SELECT * FROM ga_servers WHERE vip_enabled != :vip_enabled');
    $getVipServers->execute(array(':vip_enabled' => 0));   
    $getVipServers = $getVipServers->fetchAll();
    
    
    $countBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost');
    $countBoostServers->execute(array(':boost' => 0)); 
    $countBoostServers = $countBoostServers->rowCount();
    
    $getBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost ORDER BY boost_position DESC');
    $getBoostServers->execute(array(':boost' => 0)); 
    $getBoostServers = $getBoostServers->fetchAll();
    
    
    $content = $this->view->renderPartial("listing", ['settings' => $settings, 'countTopPlace' => $countTopPlace, 'topServers' => $topServers, 'countVipServers' => $countVipServers, 'vipServers' => $getVipServers, 'countBoostServers' => $countBoostServers, 'boostServers' => $getBoostServers]);
    

    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
}