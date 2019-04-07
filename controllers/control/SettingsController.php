<?php 

class SettingsController extends BaseController{
    
    public function actionIndex(){
    $user = new User();
    if(!$user->isAuth()){
        header("Location: /control/index");
    }
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");
    
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    
    $title = "Настройки";
    
    if(parent::isAjax()){
    $content = [];
    $global_settings = $_POST['global_settings'];
    $content['global_settings']['site_name'] = $global_settings['site_name'];
    $content['global_settings']['auto_add_server'] = $global_settings['auto_add_server'];   
    $content['global_settings']['count_servers_top'] = $global_settings['count_servers_top'];
    $content['global_settings']['count_servers_main'] = $global_settings['count_servers_main'];
    $content['global_settings']['count_servers_vip'] = $global_settings['count_servers_vip'];   
    $content['global_settings']['count_servers_boost'] = $global_settings['count_servers_boost'];
    
    $comments = $_POST['comments'];
    $content['comments']['guest_allow'] = $comments['guest_allow'];
    $content['comments']['moderation'] = $comments['moderation'];
    
    $content['global_settings']['cron_key'] = $global_settings['cron_key'];
    $content['global_settings']['auto_backup_database'] = $global_settings['auto_backup_database'];
    
    $contentJson = json_encode($content);
    
    $id = 1;
    $sql = "UPDATE ga_settings SET content = :content WHERE id= :id";
    $update = $this->db->prepare($sql);                                   
    $update->bindParam(':content', $contentJson);       
    $update->bindParam(':id', $id); 
    $update->execute();     
        
        
    $answer['status'] = "success";
    $answer['success'] = "Настройки успешно сохранены";
    exit(json_encode($answer));
    
    }else{
    $settings = json_decode($settings['content'], true);
    $content = $this->view->renderPartial("control/settings", ['settings' => $settings]);
 
    $this->view->render("control/main", ['content' => $content, 'title' => $title]);
    
    }
    }
    

}