<?php

namespace controllers\control;

use components\User;
use core\BaseController;
use PDO;

class IndexController extends AbstractController
{

    public function index()
    {

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();

        $title = "Панель управления сайтом";

        $countServers = $this->db->query('SELECT * FROM ga_servers');
        $countServers = $countServers->rowCount();

        $countUsers = $this->db->query('SELECT * FROM ga_users');
        $countUsers = $countUsers->rowCount();


        $sizeDatabase = $this->db->query('
            SELECT table_schema "' . DB_NAME . '", 
            ROUND(SUM(data_length + index_length) / 1024 / 1024, 2) AS "size" 
            FROM information_schema.TABLES GROUP BY table_schema;');
        $sizeDatabase = $sizeDatabase->fetch();


        $getVersionMysql = $this->db->query('SELECT version()');
        $getVersionMysql = $getVersionMysql->fetch();

        $notification = [];
        $countServersModeration = $this->db->query('SELECT * FROM ga_servers WHERE moderation = "0"');
        $countServersModeration = $countServersModeration->rowCount();
        if ($countServersModeration != '0') $notification[] = ['type' => 'moderationServers', 'count' => $countServersModeration];

        $countCommentsModeration = $this->db->query('SELECT * FROM ga_comments WHERE moderation = "0"');
        $countCommentsModeration = $countCommentsModeration->rowCount();
        if ($countCommentsModeration != '0') $notification[] = ['type' => 'moderationComments', 'count' => $countCommentsModeration];


        $countActiveServers = $this->db->query('SELECT * FROM ga_servers WHERE status = 1');
        $countActiveServers = $countActiveServers->rowCount();

        $counts[] = ['type' => 'countUsers', 'countUsers' => $countUsers];
        $counts[] = ['type' => 'countServers', 'countServers' => $countServers];
        $counts[] = ['type' => 'countActiveServers', 'countActiveServers' => $countActiveServers];

        $content = $this->view->renderPartial("index", ['counts' => $counts, 'notification' => $notification, 'settings' => $settings, 'sizeDatabase' => $sizeDatabase[1], 'versionMysql' => $getVersionMysql[0], 'version' => VERSION]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }

    public function login()
    {

        $title = "Авторизация";

        if (parent::isAjax()) {

            $email = strip_tags($_POST['email']);
            $password = strip_tags($_POST['password']);


            $role = 'admin';
            $check = $this->db->prepare('SELECT password, email FROM ga_users WHERE email = :email and role = :role');
            $check->bindValue(":email", $email);
            $check->bindValue(":role", $role);
            $check->execute();
            if ($row = $check->fetch()) {
                if (!password_verify($password, $row['password'])) {
                    $answer['status'] = "error";
                    $answer['error'] = "Неправильный пароль или логин";
                    exit(json_encode($answer));
                }
            } else {
                $answer['status'] = "error";
                $answer['error'] = "Неправильный пароль или логин";
                exit(json_encode($answer));
            }


            $info_user = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email');
            $info_user->bindValue(":email", $email);
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


        } else {
            $this->view->render("login", ['title' => $title]);
        }
    }
}
