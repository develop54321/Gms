<?php
class Services extends BaseController{
    
    function checkService($data){
    
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();     
    $settings = json_decode($settings['content'], true);
      
    $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
    $getInfoPay->execute(array(':id' => $data['inv_id']));
    $getInfoPay = $getInfoPay->fetch();
        
    if(empty($getInfoPay)) parent::ShowError(404, "Страница не найдена!");
    $getInfoPay = json_decode($getInfoPay['content'], true);
        
    if($getInfoPay['price'] != $data['price']) parent::ShowError(404, "Страница не найдена!");    
        
        
    $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
    $getInfoServices->execute(array(':id' => $getInfoPay['id_services']));
    $getInfoServices = $getInfoServices->fetch(); 
    
    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
    $getInfoServer->execute(array(':id' => $getInfoPay['id_server']));
    $getInfoServer = $getInfoServer->fetch();
        
    switch($getInfoPay['type']){
        case "top":
        
        if($getInfoServer['top_enabled'] != '0'){
        //уже в тоже
        $place = $getInfoServer['top_enabled'];
        $expired_time = ($getInfoServices['period']*86400)+$getInfoServer['top_expired_date'];
        }else{
        $expired_time = time()+$getInfoServices['period']*86400;
        $place = $getInfoPay['place'];
        }
        $sql = "UPDATE ga_servers SET top_enabled = :top_enabled, top_expired_date = :top_expired_date  WHERE id = :id";
        $update = $this->db->prepare($sql);                                  
        $update->bindParam(':top_enabled', $place, PDO::PARAM_INT);   
        $update->bindParam(':top_expired_date', $expired_time);   
        $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);   
        $update->execute(); 
        
        break;
        
        
        case "vip":
        if($getInfoServer['vip_enabled'] != '0'){
            $expired_time = $getInfoServer['vip_expired_date']+($getInfoServices['period']*86400);
        }else{
            $expired_time = time()+$getInfoServices['period']*86400;
        }
        $vip = 1;
        $sql = "UPDATE ga_servers SET vip_enabled = :vip_enabled, vip_expired_date = :vip_expired_date  WHERE id = :id";
        $update = $this->db->prepare($sql);                                  
        $update->bindParam(':vip_enabled', $vip, PDO::PARAM_INT);   
        $update->bindParam(':vip_expired_date', $expired_time, PDO::PARAM_INT);   
        $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);   
        $update->execute(); 
        
        
        break;
        
        
        case "color":
        
        if($getInfoServer['color_enabled'] != null){
            $expired_time = $getInfoServer['color_expired_date']+($getInfoServices['period']*86400);
        }else{
            $expired_time = time()+$getInfoServices['period']*86400;
        }
        
        $sql = "UPDATE ga_servers SET color_enabled = :color_enabled, color_expired_date = :color_expired_date  WHERE id = :id";
        $update = $this->db->prepare($sql);                                  
        $update->bindParam(':color_enabled', $getInfoPay['color']);   
        $update->bindParam(':color_expired_date', $expired_time, PDO::PARAM_INT);   
        $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);   
        $update->execute(); 
        
        break;
        
        case "boost":
        
        if($getInfoServer['boost'] != '0'){
            
        $this->db->query("UPDATE ga_servers SET boost = boost+1 WHERE id = '".$getInfoPay['id_server']."'");
            
        }else{
        
        $countBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost');
        $countBoostServers->execute(array(':boost' => 0)); 
        $countBoostServers = $countBoostServers->rowCount(); 
  
        $getBoostServers = $this->db->prepare('SELECT id, hostname, boost FROM ga_servers WHERE boost != :boost ORDER BY boost_position ASC');
        $getBoostServers->execute(array(':boost' => 0)); 
        $getBoostServers = $getBoostServers->fetchAll();
        
        if($countBoostServers == $settings['global_settings']['count_servers_boost']){
        foreach($getBoostServers as $row){
        if($row['boost'] == '1'){
        $zero = 0;
        $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
        $update = $this->db->prepare($sql);                                  
        $update->bindParam(':boost', $zero);     
        $update->bindParam(':boost_position', $zero);    
        $update->bindParam(':id', $row['id']); 
        $update->execute(); 
        break;
        }else{
        $boost_position = time()+1; 
        $this->db->query("UPDATE ga_servers SET boost = boost-1, boost_position = $boost_position WHERE id = '".$row['id']."'");
        }}

        $boost_position = time();
        $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
        $update = $this->db->prepare($sql);                                  
        $update->bindParam(':boost', $getInfoServices['period']);     
        $update->bindParam(':boost_position', $boost_position);    
        $update->bindParam(':id', $getInfoPay['id_server']); 
        $update->execute(); 
        }else{
            
        $boost_position = time();
        $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
        $update = $this->db->prepare($sql);                                  
        $update->bindParam(':boost', $getInfoServices['period']);     
        $update->bindParam(':boost_position', $boost_position);    
        $update->bindParam(':id', $getInfoPay['id_server']); 
        $update->execute();
        }
        }
        
        break;
        
        case "votes":
        $this->db->query("UPDATE ga_servers SET rating = rating+".$getInfoServices['period']." WHERE id = '".$getInfoPay['id_server']."'");
        break;
        
        
        case "razz":
        $this->db->query("UPDATE ga_servers SET ban = '0', ban_couse = '' WHERE id = '".$getInfoPay['id_server']."'");
        break;
    } 
     $status = "paid";
     $sql = "UPDATE ga_pay_logs SET status = :status, pay_methods = :pay_methods WHERE id = :id";
     $update = $this->db->prepare($sql);                                  
     $update->bindParam(':status', $status);    
     $update->bindParam(':pay_methods', $data['pay_methods']);       
     $update->bindParam(':id', $data['inv_id']); 
     $update->execute(); 
    
    return true;
    }
    
}