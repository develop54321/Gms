<?php
class UserController extends BaseController{
    
    
    public function actionLogout(){
    $user = new User();
    if($user->isAuth()){
        unset($_SESSION['id_user']);
        unset($_SESSION['hash']);
        header("Location: /user/login"); 
    }
    }
    
    public function actionIndex(){
    $title = "Панель управления";
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login"); 
    


    $sumMonth = 0;

    if($user_profile['role'] == 'partner'){
    $begin_currnet_month = mktime(0,0,0,date("m"),1,date("Y"));
    $getPayLogs = $this->db->query('SELECT * FROM ga_pay_logs WHERE id_user = "'.$user_profile['id'].'" and  date_create > '.$begin_currnet_month.'');
    $getPayLogs = $getPayLogs->fetchAll();  
    
    $newArr = [];
    foreach($getPayLogs as $row){
        $decode = json_decode($row['content'], true);
        if($decode['type_pay'] == 'payApi'){
            $sumMonth = $sumMonth+$decode['price'];
        }
    }
    }
    
    if($user_profile['role'] == 'partner'){
        $params = json_decode($user_profile['params'], true);
        $user_profile['discount_api'] = $params['discount_api'];
    }

    $content = $this->view->renderPartial("user/index", ['sumMonth' => $sumMonth, 'user_profile' => $user_profile]);
    
    $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);
     
    }
    
    public function actionRemoveserver(){
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login"); 
    
    if(parent::isAjax()){
           
    if(isset($_GET['id'])) $id = (int)$_GET['id']; else $id = null;
    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id and id_user = :id_user');
    $getInfoServer->bindValue(":id", $id);
    $getInfoServer->bindValue(":id_user", $user_profile['id']);   
    $getInfoServer->execute();
    $getInfoServer = $getInfoServer->fetch();  
    if(empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!"); 
    
    if($getInfoServer['ban'] != 0){
    $answer['status'] = "error";
    $answer['error'] = "Нельзя удалить сервер, так как забанен";
    exit(json_encode($answer)); 
    }else{
    
    $sql = "DELETE FROM ga_servers WHERE id =  :id";
    $stmt = $this->db->prepare($sql);
    $stmt->bindParam(':id', $id, PDO::PARAM_INT);   
    $stmt->execute();     
    
    $answer['status'] = "success";
    $answer['success'] = "Сервер успешно удален";
    exit(json_encode($answer)); 
    }
    
    
    }

    
     
    }
    
    
    
    
    public function actionPay(){
    $title = "Пополнение счета";
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login"); 
    
    if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $typePayment = (int)$_POST['typePayment'];
    $amout = (int)$_POST['amout'];
    
    $CheckPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
    $CheckPayMethods->bindValue(":id", $typePayment);
    $CheckPayMethods->execute();
    if($CheckPayMethods->rowCount() == '0') parent::ShowError(404, "Страница не найдена!");
    if($amout < 0) parent::ShowError(404, "Страница не найдена!");
    
    $content = json_encode(['type_pay' => "refill", 'id_user' => $user_profile['id'], 'amout' => $amout]);
        
    $getInfoPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
    $getInfoPayMethods->execute(array(':id' => $typePayment));
    $getInfoPayMethods = $getInfoPayMethods->fetch();     
    
    $InfoPayment = json_decode($getInfoPayMethods['content'], true);
    $InfoPayment = array_merge($InfoPayment, array('typeCode' => $getInfoPayMethods['typeCode']));
 
    $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','".time()."', 'expects', ".$user_profile['id'].", '".$getInfoPayMethods['typeCode']."')");
    $payId = $this->db->lastInsertId(); 
    
    $content = $this->view->renderPartial("user/pay", ['step' => "2", 'amout' => $amout ,'payId' => $payId, 'user_profile' => $user_profile, 'InfoPayment' => $InfoPayment]);
    
    }else{
    $status = 1;
    $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
    $getPayMethods->execute(array(':status' => $status));
    $getPayMethods = $getPayMethods->fetchAll(); 
    
    
    $content = $this->view->renderPartial("user/pay", ['step' => "1" , 'user_profile' => $user_profile, 'PayMethods' => $getPayMethods]);
    
    }
     $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);
    }
    
    public function actionServers(){
        
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();    
    $settings = json_decode($settings['content'], true);
        
    $title = "Мои сервера";
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login"); 
    
    
    $countServers = $this->db->prepare('SELECT * FROM ga_servers WHERE id_user = :id_user');
    $countServers->execute(array(':id_user' => $user_profile['id'])); 
    $count = $countServers->rowCount();
     
    
    $pagination = new Pagination();
    $per_page = 5;
    $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));
    
    
    $getMyServers = $this->db->prepare('SELECT s.id, s.map, s.hostname, s.moderation, s.ip, s.port, s.players, s.max_players, s.rating, s.ban, s.status, u.email FROM ga_servers s LEFT JOIN ga_users u ON s.id_user=u.id WHERE s.id_user = :id_user ORDER BY s.id DESC LIMIT '.$result['start'].', '.$per_page.'');
    $getMyServers->execute(array(':id_user' =>  $user_profile['id']));   
    $getMyServers = $getMyServers->fetchAll();
    
    
    
    $content = $this->view->renderPartial("user/servers", ['user_profile' => $user_profile, 'servers' => $getMyServers, 'ViewPagination' => $result['ViewPagination']]);
    
    
    $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);
     
    }
    
     public function actionPaylogs(){
        
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();    
        
    $title = "История платежей";
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login"); 
    
    
    $countPaylogs = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id_user = :id_user');
    $countPaylogs->execute(array(':id_user' => $user_profile['id'])); 
    $count = $countPaylogs->rowCount();
     
    
    $pagination = new Pagination();
    $per_page = 10;
    $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));
    
    
    $newArr = [];
    
    $getPaylogs = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id_user = :id_user ORDER BY id DESC LIMIT '.$result['start'].', '.$per_page.'');
    $getPaylogs->execute(array(':id_user' => $user_profile['id']));
    
    foreach($getPaylogs as $row){
       $content = json_decode($row['content'], true);
       if($content['type_pay'] == 'refill'){
        $id = $content['id_user'];
        $servicesName = "Пополнение счета";
        $price = $content['amout'];
       }elseif($content['type_pay'] == "payServices" or $content['type_pay'] == "payApi"){
       $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
       $getInfoServices->execute(array(':id' => $content['id_services']));
       $getInfoServices = $getInfoServices->fetch();
       if(!empty($getInfoServices)){
        $servicesName = $getInfoServices['name'];
       }else{
        $servicesName = 'Услуга не найдена';
        
       }
       $id = $content['id_server'];
       $price = $content['price'];
       }
       $newArr[] = ['id' => $row['id'], 'type_pay' => $content['type_pay'], 'price' =>$price, 'id_object' => $id, 'servicesName' => $servicesName, 'date_create' => $row['date_create'], 'status' => $row['status']];
       
    }
     
    $content = $this->view->renderPartial("user/paylogs", ['user_profile' => $user_profile, 'data' => $newArr, 'ViewPagination' => $result['ViewPagination']]);
    
    
    $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);
     
    }
    
    public function actionSignup(){
    $title = "Регистрация";
    $user = new User();
    if($user->isAuth()) header("Location: /");
    
    if(parent::isAjax()){
    $firstname = strip_tags($_POST['firstname']);
    $lastname = strip_tags($_POST['lastname']);
    $email = strip_tags($_POST['email']);
    
    $password = strip_tags($_POST['password']);
    $password2 = strip_tags($_POST['password2']);
    
    
    
    if(!preg_match('/^[a-zA-Zа-яА-Я]+$/ui', $firstname)){
       $answer['status'] = "error";
       $answer['error'] = "<b></b>Имя введен неверно";
       exit(json_encode($answer));
    }
    
    if(!preg_match('/^[a-zA-Zа-яА-Я]+$/ui', $lastname)){
       $answer['status'] = "error";
       $answer['error'] = "<b>Фамилия</b> введен неверно";
       exit(json_encode($answer));
    }
    
    if(!preg_match('/\w{6,}/', $password)){
       $answer['status'] = "error";
       $answer['error'] = "<b>Пароль</b> введен неверно, минимум 6 символов";
       exit(json_encode($answer));
    }
    
    if($password != $password2){
       $answer['status'] = "error";
       $answer['error'] = "<b>Повторный пароль</b> не совпадает";
       exit(json_encode($answer));
    }
    
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
       $answer['status'] = "error";
       $answer['error'] = "<b>E-mail</b> адрес указан верно";
       exit(json_encode($answer));
    }
    
    $isEmail = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email');
    $isEmail->bindValue(":email", $email);
    $isEmail->execute();
    if($isEmail->rowCount() != '0'){
       $answer['status'] = "error";
       $answer['error'] = "Данный <b>email</b> уже занят в системе";
       exit(json_encode($answer));
    }
    

    
    $time = time();
    $this->db->exec("INSERT INTO ga_users (email, lastname, firstname, password, role, date_reg) 
    VALUES('$email', '$lastname', '$firstname', '".md5($password)."', 'user', '$time')");
    

    $answer['status']="success";
    $answer['success']="Вы успешно зарегистрировались";
    exit(json_encode($answer));
  
    }else{

    $content = $this->view->renderPartial("user/signup", []);
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
        
    }
    }
    
    
    public function actionReset(){
    $title = "Восстановления пароля";
    $user = new User();
    if($user->isAuth()) header("Location: /");
    $system = new System();
    if(parent::isAjax()){
    $email = strip_tags($_POST['email']);

    
    $check = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email ');
    $check->bindValue(":email", $email);
    $check->execute();
    if($check->rowCount() == '0'){
       $answer['status'] = "error";
       $answer['error'] = "Пользователь с указанным e-mail не найден";
       exit(json_encode($answer));
    }else{
       $reset_code = md5(mt_rand(1000,10000));
        
       $sql = "UPDATE ga_users SET reset_code = :reset_code WHERE email = :email";
       $update = $this->db->prepare($sql);                                  
       $update->bindParam(':reset_code', $reset_code, PDO::PARAM_STR);
       $update->bindParam(':email', $email, PDO::PARAM_INT);
       $update->execute(); 
       
       $site_url = $_SERVER['SERVER_NAME'];

       $linkReset = $system->getUrl()."/user/reset?code=$reset_code";
       
       $message = '
       <html>
       <head>
       <title>'.$title.'</title>
       </head>
       <body>
       <p>
        Добрый день!<br/>

Вы получили это письмо, потому что кто-то (возможно, вы) запросил на сайте '.$site_url.' восстановление пароля для пользователя, зарегистрированного с вашим e-mail '.$email.'
<br/>
Чтобы получить новый пароль, перейдите по ссылке:<br/>
'.$linkReset.'
<br/>
Если ссылка не открывается, скопируйте её и вставьте в адресную строку браузера.
<br/>
Если вы не запрашивали изменение пароля или вспомнили свой пароль, просто проигнорируйте это письмо и пользуйтесь своим текущим паролем.
       </p>
       </body>
       </html>';
       
       $mail = new Mail;
       $mail->send($email, $title, $message);
       
       $answer['status'] = "success";
       $answer['success'] = "На вашу почту было отправлено письмо с кодом подтверждения, для получение нового пароля перейдите по ссылке содержащейся в письме.";
       exit(json_encode($answer));
        
        
        
    }

    
    
    }else{
    if(isset($_GET['code'])){
    $code = $_GET['code'];    
    $checkCode = $this->db->prepare('SELECT * FROM ga_users WHERE reset_code = :reset_code');
    $checkCode->bindValue(":reset_code", $code);
    $checkCode->execute();
    if($checkCode->rowCount() == '1'){
       $newPassword = $system->generate_password(8);
       $hashPassword = md5($newPassword);
       $reset_code = '';
       $sql = "UPDATE ga_users SET password = :password, reset_code = '' WHERE reset_code = :reset_code";
       $update = $this->db->prepare($sql);     
       $update->bindParam(':password', $hashPassword);                             
       $update->bindParam(':reset_code', $code);
       $update->execute(); 
        
        
        $content = $this->view->renderPartial("user/reset", ['password' => $newPassword]);
    }else parent::ShowError(404, "Страница не найдена!"); 
        
    }else{
      $content = $this->view->renderPartial("user/reset", []);  
    }
    
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    }
    
    
    public function actionLogin(){
    $title = "Авторизация";
    $user = new User();
    if($user->isAuth()) header("Location: /");
    
    if(parent::isAjax()){
    $email = strip_tags($_POST['email']);
    $password = strip_tags($_POST['password']);
    $password = md5($password);
    
    $check = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email and password = :password');
    $check->bindValue(":email", $email);
    $check->bindValue(":password", $password);
    $check->execute();
    if($check->rowCount() == '0'){
       $answer['status'] = "error";
       $answer['error'] = "Неправильный пароль или логин";
       exit(json_encode($answer));
    }
    
    $info_user = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email and password = :password');
    $info_user->bindValue(":email", $email);
    $info_user->bindValue(":password", $password);
    $info_user->execute();
    $data_user = $info_user->fetch();
    if($data_user['role'] == 'banned'){
       $answer['status'] = "error";
       $answer['error'] = "Ваш аккаунт заблокирован";
       exit(json_encode($answer));
    }
  
    $hash = md5($data_user['id']);
    $_SESSION['id_user'] = $data_user['id'];
    $_SESSION['hash'] = $hash;
    
    $sql = "UPDATE ga_users SET hash = :hash WHERE id = :id";
    $update = $this->db->prepare($sql);                                  
    $update->bindParam(':hash', $hash, PDO::PARAM_STR);       
    $update->bindParam(':id', $data_user['id'], PDO::PARAM_INT);   
    $update->execute(); 
    
    
    
    $answer['status'] = "success";
    $answer['success'] = "Вы успешно авторизовались";
    exit(json_encode($answer));
    
    
    }else{
    $content = $this->view->renderPartial("user/login", []);
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    }
    
    
    public function actionServerpay(){
    
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login"); 
    
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
    if(parent::isAjax()){
    //step 2
    $id_services = (int)$_POST['id_services'];

    $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
    $getInfoServices->execute(array(':id' => $id_services));
    $getInfoServices = $getInfoServices->fetch();  
    if(empty($getInfoServices)) parent::ShowError(404, "Страница не найдена!");
    
    if($user_profile['balance'] >= $getInfoServices['price']){
    
    switch($getInfoServices['type']){
        case "top":
        //ТОП место
        if($getInfoServer['top_enabled'] == '0') $place = (int)$_POST['place']; else $place = 0;
        
        if($getInfoServer['top_enabled'] == '0'){
        //check place
        $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
        $checkPlace->execute(array(':top_enabled' => $place));
        if($checkPlace->rowCount() != '0') parent::ShowError(404, "Страница не найдена!");
        }
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'top', 'place' => $place, 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','".time()."', 'expects', ".$user_profile['id'].", 'bill')");
        $payId = $this->db->lastInsertId(); 
          
        break;
        
        case "vip":
        //vip статус
        $vip = 1;
        //check vip place
        $countVipServers = $this->db->prepare('SELECT * FROM ga_servers WHERE vip_enabled = :vip_enabled');
        $countVipServers->execute(array(':vip_enabled' => $vip));
        if($countVipServers->rowCount() == $settings['count_servers_vip']){
            parent::ShowError(404, "нету мест");
        }
        
         
        
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'vip', 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','".time()."', 'expects', ".$user_profile['id'].", 'bill')");
        $payId = $this->db->lastInsertId(); 
        
        break;
        
        case "color":
        //Выделение цветом
        $color = $_POST['selectColor'];
        
        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'color', 'color' => $color, 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','".time()."', 'expects', ".$user_profile['id'].", 'bill')");
        $payId = $this->db->lastInsertId(); 
        
        
        
        break;
        
        case "boost":
        //boost

         $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'boost', 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','".time()."', 'expects', ".$user_profile['id'].", 'bill')");
        $payId = $this->db->lastInsertId(); 
        
        
        
        break;
        
        case "votes":
        //votes


        $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'votes', 'id_server' => $id]);
        
        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','".time()."', 'expects', ".$user_profile['id'].", 'bill')");
        $payId = $this->db->lastInsertId(); 
        

        
        break;
        
        default:
        parent::ShowError(404, "Страница не найдена!");
        break;
    }
    $services = new Services();
    $services->checkService(['inv_id' => $payId, 'price' => $getInfoServices['price'], 'pay_methods' => "bill"]);
    
    $newBalance = $user_profile['balance']-$getInfoServices['price'];
    $sql = "UPDATE ga_users SET balance = :balance  WHERE id = :id";
    $update = $this->db->prepare($sql);                                  
    $update->bindParam(':balance', $newBalance, PDO::PARAM_INT);   
    $update->bindParam(':id', $user_profile['id'], PDO::PARAM_INT);   
    $update->execute(); 
    
    $answer['status'] = "success";
    $answer['success'] = "Услуга успешно куплена";
    exit(json_encode($answer)); 
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }else{
       $answer['status'] = "error";
       $answer['error'] = "Недостаточно средств на счете";
       exit(json_encode($answer));   
    }
    }
    }else if($step == '1'){
    
    $content = $this->view->renderPartial("user/serverpay", ['type' => 'selectServices', 'serverInfo' => $getInfoServer, 'services' => $getServices, 'step' => 1]);
    
    $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
    
    }
    
    public function actionGetForm(){
    $user = new User();
    $user_profile = $user->isAuth();
    if(!$user_profile) header("Location: /user/login");    
        
    if(parent::isAjax()){
    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();
    $settings = json_decode($settings['content'], true);
     if(isset($_GET['id_server'])) $id_server = (int)$_GET['id_server']; else $id_server = null;
    
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
    $content = $this->view->renderPartial("user/serverpayForm", ['user_profile' => $user_profile,'colors' => $colors, 'serverInfo' => $getInfoServerRow, 'PayMethods' => $getPayMethods, 'type' => $getInfoServices['type'], 'data' => $data, 'infoServices' => $getInfoServices, 'step' => '1'], true);
    echo $content;
   
    }else parent::ShowError(404, "Страница не найдена!");
    }

    
    
}