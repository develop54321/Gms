<?php
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
    
    switch($getInfoServices['type']){
        case "top":

        if($getInfoServer['top_enabled'] == '0') $place = (int)$_POST['place']; else $place = 0;
        
        if($getInfoServer['top_enabled'] == '0'){
       
        $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
        $checkPlace->execute(array(':top_enabled' => $place));
        if($checkPlace->rowCount() != '0') parent::ShowError(404, "Страница не найдена!");
        }
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'top', 'place' => $place, 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
          
        break;
        
        case "vip":
        
        $vip = 1;

        $countVipServers = $this->db->prepare('SELECT * FROM ga_servers WHERE vip_enabled = :vip_enabled');
        $countVipServers->execute(array(':vip_enabled' => $vip));
        if($countVipServers->rowCount() == $settings['count_servers_vip']){
            parent::ShowError(404, "нету мест");
        }
        
         
        
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'vip', 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        
        break;
        
        case "color":

        $color = $_POST['selectColor'];
        
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'color', 'color' => $color, 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        
        
        
        break;
        
        case "boost":
 

        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'boost', 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        
        
        
        break;
        
        case "votes":

        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'votes', 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status) VALUES('$content','".time()."', 'expects')");
        $payId = $this->db->lastInsertId(); 
        
        
        
        break;
        
        
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
    
    $content = $this->view->renderPartial("pay", ['type' => 'selectServices', 'serverInfo' => $getInfoServer, 'services' => $getServices, 'step' => 1]);
    
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
    
    
    $data = '';
    if($getInfoServices['type'] == 'top'){
        
    $data = [];
    for($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++){
        $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
    $isPlace->execute(array(':top_enabled' => $i));    
    if($isPlace->rowCount() != '0'){
    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
    $getInfoServer->execute(array(':top_enabled' => $i));
    $getInfoServer = $getInfoServer->fetch();
    
    $data[] = ['id' => $i, 'status' => 1];
    }else{
    $data[] = ['id' => $i, 'status' => 0];  
    }
        
    }
    }
  
    $status = 1;
    $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
    $getPayMethods->execute(array(':status' => $status));
    $getPayMethods = $getPayMethods->fetchAll(); 
    $colors = [];
    if($getInfoServices['type'] == 'color'){
        $colors = json_decode($getInfoServices['params'], true);
    }
    $content = $this->view->renderPartial("payForm", ['colors' => $colors, 'serverInfo' => $getInfoServerRow, 'PayMethods' => $getPayMethods, 'type' => $getInfoServices['type'], 'data' => $data, 'infoServices' => $getInfoServices, 'step' => '1'], true);
    echo $content;
   
    }else parent::ShowError(404, "Страница не найдена!");
    }
    
    
    public function action(){
        
    }
}
    
