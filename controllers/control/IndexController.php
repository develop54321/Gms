<?php
namespace controllers\control;

use components\User;
use core\BaseController;
use PDO;

class IndexController extends BaseController{

    public function actionIndex(){
    $user = new User();
    if(!$user->isAuth()){
        $this->actionLogin();
        return false;
    }else{
    $getUserPrfile = $user->getProfile();
    if($getUserPrfile['role'] != 'admin')  parent::ShowError(404, "Страница не найдена!");

    $getSettings = $this->db->query('SELECT * FROM ga_settings');
    $settings = $getSettings->fetch();

    $title = "Панель управления сайтом";

    $countServers = $this->db->query('SELECT * FROM ga_servers');
    $countServers = $countServers->rowCount();

    $countUsers = $this->db->query('SELECT * FROM ga_users');
    $countUsers = $countUsers->rowCount();



    $sizeDatabase = $this->db->query('SELECT table_schema "'.DB_NAME.'", sum( data_length + index_length )/1024/1024 "Data Base Size in MB" FROM information_schema.TABLES GROUP BY table_schema;');
    $sizeDatabase = $sizeDatabase->fetch();

    $getVersionMysql = $this->db->query('SELECT version()');
    $getVersionMysql = $getVersionMysql->fetch();

    $notification = [];
    $countServersModeration = $this->db->query('SELECT * FROM ga_servers WHERE moderation = "0"');
    $countServersModeration = $countServersModeration->rowCount();
    if($countServersModeration != '0') $notification[] = ['type' => 'moderationServers', 'count' => $countServersModeration];

    $countCommentsModeration = $this->db->query('SELECT * FROM ga_comments WHERE moderation = "0"');
    $countCommentsModeration = $countCommentsModeration->rowCount();
    if($countCommentsModeration != '0') $notification[] = ['type' => 'moderationComments', 'count' => $countCommentsModeration];

    $counts[] = ['type' => 'countUsers', 'countUsers' => $countUsers];
    $counts[] = ['type' => 'countServers', 'countServers' => $countServers];

    $content = $this->view->renderPartial("control/index", ['counts' => $counts, 'notification' => $notification, 'settings' => $settings, 'sizeDatabase' => $sizeDatabase[1], 'versionMysql' => $getVersionMysql[0]]);

    $this->view->render("control/main", ['content' => $content, 'title' => $title]);

    }
    }

    public function actionLogin(){

    $title = "Авторизация";

    if(parent::isAjax()){

    $email = strip_tags($_POST['email']);
    $password = strip_tags($_POST['password']);
    $password = md5($password);


    $role = 'admin';
    $check = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email and password = :password and role = :role');
    $check->bindValue(":email", $email);
    $check->bindValue(":password", $password);
    $check->bindValue(":role", $role);
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


    $hash = md5(mt_rand(10, 99));
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
    $this->view->render("control/login", ['title' => $title]);
    }
    }








}
