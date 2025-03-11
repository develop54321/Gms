<?php

namespace controllers\control;

use PDO;

class IndexController extends AbstractController
{

    public function index()
    {

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();

        $title = "Панель управления сайтом";

        $countServers = $this->db->query('SELECT * FROM ga_servers')->rowCount();
        $countServersToday = $this->db->query("
        SELECT COUNT(*) 
        FROM ga_servers 
        WHERE DATE(FROM_UNIXTIME(date_add)) = CURDATE()")->fetchColumn();

        $countServersLastWeek = $this->db->query("
        SELECT COUNT(*) 
        FROM ga_servers 
        WHERE date_add >= UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 7 DAY)) ")->fetchColumn();

        $countServersThisMonth = $this->db->query("
        SELECT COUNT(*) 
        FROM ga_servers 
        WHERE DATE_FORMAT(FROM_UNIXTIME(date_add), '%Y-%m') = DATE_FORMAT(CURDATE(), '%Y-%m')")->fetchColumn();



        $countUsers = $this->db->query('SELECT * FROM ga_users')->rowCount();
        $countUsersToday = $this->db->query("
        SELECT COUNT(*) 
        FROM ga_users 
        WHERE DATE(FROM_UNIXTIME(date_reg)) = CURDATE()")->fetchColumn();

        $countUsersLastWeek = $this->db->query("
        SELECT COUNT(*) 
        FROM ga_users 
        WHERE date_reg >= UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 7 DAY)) ")->fetchColumn();

        $countUsersThisMonth = $this->db->query("
        SELECT COUNT(*) 
        FROM ga_users 
        WHERE DATE_FORMAT(FROM_UNIXTIME(date_reg), '%Y-%m') = DATE_FORMAT(CURDATE(), '%Y-%m')")->fetchColumn();

        $countComments = $this->db->query('SELECT * FROM ga_comments')->rowCount();


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



        $queryToday = "
        SELECT SUM(JSON_EXTRACT(content, '$.price')) AS total_income_today
        FROM ga_pay_logs
        WHERE status = 'paid'
          AND DATE(FROM_UNIXTIME(date_create)) = CURDATE();";

        $stmtToday = $this->db->query($queryToday);
        $resultToday = $stmtToday->fetch(PDO::FETCH_ASSOC);
        $incomeToday = $resultToday['total_income_today'] ?? 0;


        $queryWeek = "
        SELECT SUM(JSON_EXTRACT(content, '$.price')) AS total_income_week
        FROM ga_pay_logs
        WHERE status = 'paid'
          AND YEARWEEK(FROM_UNIXTIME(date_create), 1) = YEARWEEK(CURDATE(), 1);";

        $stmtWeek = $this->db->query($queryWeek);
        $resultWeek = $stmtWeek->fetch(PDO::FETCH_ASSOC);
        $incomeWeek = $resultWeek['total_income_week'] ?? 0;

        $queryMonth = "
        SELECT SUM(JSON_EXTRACT(content, '$.price')) AS total_income_month
        FROM ga_pay_logs
        WHERE status = 'paid'
          AND MONTH(FROM_UNIXTIME(date_create)) = MONTH(CURDATE())
          AND YEAR(FROM_UNIXTIME(date_create)) = YEAR(CURDATE());";

        $stmtMonth = $this->db->query($queryMonth);
        $resultMonth = $stmtMonth->fetch(PDO::FETCH_ASSOC);
        $incomeMonth = $resultMonth['total_income_month'] ?? 0;

        $content = $this->view->renderPartial("index", [
            'notification' => $notification,
            'settings' => $settings,
            'sizeDatabase' => $sizeDatabase[1],
            'versionMysql' => $getVersionMysql[0],
            'version' => VERSION,
            'countUsers' => $countUsers,
            'countUsersToday' => $countUsersToday,
            'countUsersLastWeek' => $countUsersLastWeek,
            'countUsersThisMonth' => $countUsersThisMonth,
            'countServers' => $countServers,
            'countServersToday' => $countServersToday,
            'countServersLastWeek' => $countServersLastWeek,
            'countServersThisMonth' => $countServersThisMonth,
            'countActiveServers' => $countActiveServers,
            'countComments' => $countComments,
            'countCommentsModeration' => $countCommentsModeration,

            'incomeToday' => $incomeToday,
            'incomeWeek' => $incomeWeek,
            'incomeMonth' => $incomeMonth,
        ]);

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
