<?php
namespace controllers;
use core\BaseController;
use components\System;
class PayController extends BaseController{
    
    public function actionIndex(){
    $system = new System();
            
    $title = "Платные услуги";
   
    if(isset($_POST['query'])){
    $query = $_POST['query'];
    $query = explode(":", $query);
     if(!isset($query[1])) $query[1] = null;
    
    $getInfoServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
    $getInfoServers->bindValue(":ip", $query[0]);
    $getInfoServers->bindValue(":port", $query[1]);
    $getInfoServers->execute();
    $getServers = $getInfoServers->fetchAll();
    
    $content = $this->view->renderPartial("pay", ['type' => 'search', 'servers' => $getServers]);
    }else{
        
    $content = $this->view->renderPartial("pay", ['type' => 'searchForm']);
    }
    $this->view->render("main", ['content' => $content, 'title' => $title]); 
    }
    
    
    public function actionServer(){
	
	$getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();   
    $settings = json_decode($settings['content'], true);
        
           
    $title = "Платные услуги";
    
    
    if(isset($_GET['id'])) $id = (int)$_GET['id']; else $id = null;
   
    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
    $getInfoServer->execute(array(':id' => $id));
    $getInfoServer = $getInfoServer->fetch();  
    
    if(empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");
    
    $getServices = $this->db->query('SELECT * FROM ga_services');
    $getServices = $getServices->fetchAll();  
    
    if(isset($_GET['step'])) $step = (int)$_GET['step']; else $step = 1;

    if($step == '2'){
    //step 2
    $id_services = (int)$_POST['id_services'];
    $typePayment = (int)$_POST['typePayment'];
    
    $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
    $getInfoServices->execute(array(':id' => $id_services));
    $getInfoServices = $getInfoServices->fetch();  
    if(empty($getInfoServices)) parent::ShowError(404, "Страница не найдена!");
    
    $getInfoPayment = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
    $getInfoPayment->execute(array(':id' => $typePayment));
    $getInfoPayment = $getInfoPayment->fetch();
    if(empty($getInfoPayment)) parent::ShowError(404, "Страница не найдена!");
	
	// Проверка на бан	razz Если сервер в бане и это не услуга разбана
	if($getInfoServer['ban'] == 1 and $getInfoServices['type'] != 'razz'){
		parent::ShowError(404, "Сервер Забанен!");
	}
    
    switch($getInfoServices['type']){
		//	Befirst
		case "befirst":
        if($getInfoServer['befirst_enabled'] == '0') $place = (int)$_POST['place']; else $place = 0;
        if($getInfoServer['befirst_enabled'] == '0'){
        $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE befirst_enabled = :befirst_enabled');
        $checkPlace->execute(array(':befirst_enabled' => $place));
        if($checkPlace->rowCount() != '0') parent::ShowError(404, "Нет свободных мест");
        }
		if($settings['global_settings']['befirst_on'] == 0){parent::ShowError(404, "Услуга отключена");}
		$limitBefirstServers = $settings['global_settings']['count_servers_befirst'];
		$countBefirstServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `befirst_enabled` != '0'")->rowCount();
		$CheckBefirstServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='".$id."' and `befirst_enabled` != '0' LIMIT 1")->rowCount();
		if($countBefirstServers >= $limitBefirstServers and $CheckBefirstServer == 0){
			parent::ShowError(404, "Нет свободных мест");
		}
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'befirst', 'place' => $place, 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
		
		//	Top
        case "top":
		if($settings['global_settings']['top_on'] == 0){parent::ShowError(404, "Услуга отключена");}
        if($getInfoServer['top_enabled'] == '0') $place = (int)$_POST['place']; else $place = 0;
        if($getInfoServer['top_enabled'] == '0'){
        $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
        $checkPlace->execute(array(':top_enabled' => $place));
        if($checkPlace->rowCount() != '0') parent::ShowError(404, "Нет свободных мест");
        }
		$limitTopServers = $settings['global_settings']['count_servers_top'];
		$countTopServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `top_enabled` != '0'")->rowCount();
		$CheckTopServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='".$id."' and `top_enabled` != '0' LIMIT 1")->rowCount();
		if($countTopServers >= $limitTopServers and $CheckTopServer == 0){
			parent::ShowError(404, "Нет свободных мест");
		}
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'top', 'place' => $place, 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId();   
        break;
		
        //	Vip
        case "vip":
        $vip = 1;
		if($settings['global_settings']['vip_on'] == 0){parent::ShowError(404, "Услуга отключена");}
		$limitVipServers = $settings['global_settings']['count_servers_vip'];
		$countVipServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `vip_enabled`='1'")->rowCount();
		$CheckVipServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='".$id."' and `vip_enabled` = '".$vip."' LIMIT 1")->rowCount();
		if($countVipServers >= $limitVipServers and $CheckVipServer == 0){
			parent::ShowError(404, "Нет свободных мест");
		}
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'vip', 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
		
		//	Color
        case "color":
		if($settings['global_settings']['color_on'] == 0){parent::ShowError(404, "Услуга отключена");}
		$limitColorServers = $settings['global_settings']['count_servers_color'];
		$countColorServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `color_enabled`!= '0'")->rowCount();
		$CheckColorServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='".$id."' and `color_enabled` != '0' LIMIT 1")->rowCount();
		if($countColorServers >= $limitColorServers and $CheckColorServer == 0){
			parent::ShowError(404, "Нет свободных мест");
		}
        $color = $_POST['selectColor'];
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'color', 'color' => $color, 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
		
        //	Boost
        case "boost":
		if($settings['global_settings']['boost_on'] == 0){parent::ShowError(404, "Услуга отключена");}
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'boost', 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
        
		//	Gamemenu
        case "gamemenu":
        $gamemenu = 1;
		if($settings['global_settings']['gamemenu_on'] == 0){parent::ShowError(404, "Услуга отключена");}
		$limitGamemenuServers = $settings['global_settings']['count_servers_gamemenu'];
		$countGamemenuServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `gamemenu_enabled`='1'")->rowCount();
		$CheckGamemenuServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='".$id."' and `gamemenu_enabled` = '".$gamemenu."' LIMIT 1")->rowCount();
		if($countGamemenuServers >= $limitGamemenuServers and $CheckGamemenuServer == 0){
			parent::ShowError(404, "Нет свободных мест");
		}
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'gamemenu', 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
		
		//	Votes
        case "votes":
		if($settings['global_settings']['votes_on'] == 0){parent::ShowError(404, "Услуга отключена");}
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'votes', 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
        
        //	Unban
        case "razz":
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'razz', 'id_server' => $id]);
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        break;
        
        default:
        parent::ShowError(404, "Страница не найдена!");
        break;
    }
    
    $InfoPayment = json_decode($getInfoPayment['content'], true);
    
    $InfoPayment = array_merge($InfoPayment, array('typeCode' => $getInfoPayment['typeCode']));

    $content = $this->view->renderPartial("payForm", ['InfoPayment' => $InfoPayment,'infoServices' => $getInfoServices,'payId' => $payId, 'type' => 'selectServices', 'serverInfo' => $getInfoServer, 'services' => $getServices, 'step' => 2]);
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
    
    }else if($step == '1'){
    $content = $this->view->renderPartial("pay", ['type' => 'selectServices', 'serverInfo' => $getInfoServer, 'settings' => $settings, 'services' => $getServices, 'step' => 1]);
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
    }
    
    public function actionGetForm(){
    if(parent::isAjax()){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    $settings = json_decode($settings['content'], true);
    
     if(isset($_GET['id_server'])) $id_server = (int)$_GET['id_server']; else $$id_server = null;
    
    $getInfoServerRow = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
    $getInfoServerRow->execute(array(':id' => $id_server));
    $getInfoServerRow = $getInfoServerRow->fetch();  
    if(empty($getInfoServerRow)) parent::ShowError(404, "Сервер не найден!");
    
    if(isset($_GET['id_services'])) $id_services = (int)$_GET['id_services']; else  parent::ShowError(404, "Страница не найдена!");
    
    $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
    $getInfoServices->execute(array(':id' => $id_services));
    $getInfoServices = $getInfoServices->fetch();  
    if(!isset($id_services)) parent::ShowError(404, "Страница не найдена!");
    
    
    $databefirst = '';
    if($getInfoServices['type'] == 'befirst'){
		$databefirst = [];
		for($i = 1; $i <= $settings['global_settings']['count_servers_befirst']; $i++){
			$isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE befirst_enabled = :befirst_enabled');
			$isPlace->execute(array(':befirst_enabled' => $i));    
			if($isPlace->rowCount() != '0'){
			$getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE befirst_enabled = :befirst_enabled');
			$getInfoServer->execute(array(':befirst_enabled' => $i));
			$getInfoServer = $getInfoServer->fetch();
			
			$databefirst[] = ['id' => $i, 'status' => 1];
			}else{
			$databefirst[] = ['id' => $i, 'status' => 0];  
			}
		}
    }
	
    $datatop = '';
    if($getInfoServices['type'] == 'top'){
		$datatop = [];
		for($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++){
			$isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
			$isPlace->execute(array(':top_enabled' => $i));    
			if($isPlace->rowCount() != '0'){
			$getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
			$getInfoServer->execute(array(':top_enabled' => $i));
			$getInfoServer = $getInfoServer->fetch();
			
			$datatop[] = ['id' => $i, 'status' => 1];
			}else{
			$datatop[] = ['id' => $i, 'status' => 0];  
			}
		}
    }
  
    $status = 1;
    $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
    $getPayMethods->execute(array(':status' => $status));
    $getPayMethods = $getPayMethods->fetchAll(); 

	// new colors
	$activcolor = 1;
	$getCodeColors = $this->db->prepare('SELECT * FROM ga_code_colors WHERE activ = :activ');
    $getCodeColors->execute(array(':activ' => $activcolor));
    $getCodeColors = $getCodeColors->fetchAll(); 
	
    $content = $this->view->renderPartial("payForm", ['CodeColors' => $getCodeColors, 'serverInfo' => $getInfoServerRow, 'PayMethods' => $getPayMethods, 'type' => $getInfoServices['type'], 'datatop' => $datatop, 'databefirst' => $databefirst, 'infoServices' => $getInfoServices, 'step' => '1'], true);
    echo $content;
   
    }else parent::ShowError(404, "Страница не найдена!");
    }
    
    
    public function action(){
        
    }
}
    
