<?php

namespace controllers;

use components\Servers;
use components\System;
use components\User;
use core\BaseController;
use Exception;
use PDO;
use xPaw\SourceQuery\SourceQuery;

class ServerController extends BaseController
{

    public function add()
    {


        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);
        $title = "Добавить сервер";

        if (parent::isAjax()) {
            $game = strip_tags($_POST['game']);
            $ip = strip_tags($_POST['ip']);
            $port = strip_tags($_POST['port']);
            $text = strip_tags($_POST['text']);

            $isGame = $this->db->prepare('SELECT * FROM ga_games WHERE code = :code and status = :status');
            $isGame->bindValue(":code", $game);
            $isGame->bindValue(":status", 1);
            $isGame->execute();
            if ($isGame->rowCount() == '0') {
                $answer['status'] = "error";
                $answer['error'] = "Игра не найден";
                exit(json_encode($answer));
            }


            if (!filter_var($ip, FILTER_VALIDATE_IP)) {
                $answer['status'] = "error";
                $answer['error'] = "Не правильно введен ип адрес";
                exit(json_encode($answer));
            }

            if (strlen($port) < 3) {
                $answer['status'] = "error";
                $answer['error'] = "Не правильно введен порт";
                exit(json_encode($answer));
            }

            if (!is_string($text) && strlen($text) >= 300) {
                $answer['status'] = "error";
                $answer['error'] = "Ошибка: описание не должен превышать 300 символов";
                exit(json_encode($answer));
            }


            $CheckServer = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
            $CheckServer->bindValue(":ip", $ip);
            $CheckServer->bindValue(":port", $port);
            $CheckServer->execute();
            if ($CheckServer->rowCount() == '1') {

                $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
                $getInfoServer->bindValue(":ip", $ip);
                $getInfoServer->bindValue(":port", $port);
                $getInfoServer->execute();
                $getInfoServer = $getInfoServer->fetch();

                $answer['status'] = "error";
                $answer['error'] = "Сервер уже добавлен" . "<br/>
                    <a href='/server/verification?id=" . $getInfoServer['id'] . "'>Вы владелец сервера?</a>";
                exit(json_encode($answer));
            }

            if ($settings['global_settings']['auto_add_server']) {
                $status = 1;
            } else {
                $status = 0;
            }




            $user = new User();
            $id_user = 0;
            if ($user->isAuth()) {
                $user_profile = $user->getProfile();
                $id_user = $user_profile['id'];
            }

            if ($settings['global_settings']['auto_add_server'] == '1') {
                $moderation = 1;
                $success_text = "Ваш сервер успешно добавлен, информацию об сервере появиться в течение 5 минут";
            } else {
                $moderation = 0;
                $success_text = "Ваш сервер успешно добавлен, после проверки администратором она появиться в мониторинге";
            }

            $this->db->exec("INSERT INTO ga_servers (status, moderation, id_user, game, ip, port, date_add, description) 
                VALUES('$status', '$moderation','$id_user', '$game', '$ip', '$port', '" . time() . "', '$text')");

            $answer['status'] = "success";
            $answer['success'] = $success_text;
            exit(json_encode($answer));


        } else {

            $getGames = $this->db->prepare('SELECT * FROM ga_games WHERE status = :status');
            $getGames->execute(array(':status' => 1));
            $getGames = $getGames->fetchAll();

            $content = $this->view->renderPartial("server/add", ['games' => $getGames]);


            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }
    }


    public function info($address){
        $user = new User();
        $IsAuth = $user->isAuth();

        $currentSession = null;
        if ($IsAuth) $currentSession = $IsAuth['id'];

        $system = new System();
        $parseAddress = Servers::parseAddress($address);


        $getInfoServer = $this->db->prepare('
        SELECT s.id, 
               s.map, 
               s.game, 
               s.hostname, 
               s.country, 
               s.id_user, 
               s.status, 
               s.players, 
               s.max_players, 
               s.ban, 
               s.ip, 
               s.port, 
               s.date_add, 
               s.rating, 
               s.befirst_enabled, 
               s.top_enabled, 
               s.vip_enabled, 
               s.color_enabled, 
               s.boost, 
               s.gamemenu_enabled, 
               s.color_expired_date, 
               s.vip_expired_date, 
               s.gamemenu_expired_date, 
               s.top_expired_date,
               g.game game_name
        FROM ga_servers s LEFT JOIN ga_games g ON s.game = g.code 
        WHERE s.ip = :ip and s.port = :port');
        $getInfoServer->execute(array(':ip' => $parseAddress['ip'], ':port' => $parseAddress['port']));
        $getInfoServer = $getInfoServer->fetch();

        if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");


        $title = "Информация о сервере :: " . $getInfoServer['hostname'];


        $getInfoServer['img_map'] = Servers::getImagePath($getInfoServer['map'], $getInfoServer['game']);

        # UserInfo
        if ($IsAuth) {
            $user_profile = $user->getProfile();
            $getInfoServer['userid'] = $user_profile['id'];
        }

        $ownerName = null;
        if ((int)$getInfoServer['id_user'] !== 0) {
            $getInfoUser = $this->db->prepare('SELECT email FROM ga_users WHERE id = :id');
            $getInfoUser->execute(array(':id' => $getInfoServer['id_user']));
            $getInfoUser = $getInfoUser->fetch();
            $ownerName = Servers::hiddenOwnerEmail($getInfoUser['email']);

        }




        if ($getInfoServer['status'] == 1) {
            $getInfoServer['status'] = 'Online';
        } else {
            $getInfoServer['status'] = 'Offline';
        }
        $getInfoServer['show_players'] = $system->showbar($getInfoServer['players'], $getInfoServer['max_players']);


        $moderation = 1;
        $getComments = $this->db->prepare('SELECT c.id, c.text, u.lastname, u.firstname, c.date_create, u.img FROM ga_comments c LEFT JOIN ga_users u ON c.id_user=u.id WHERE c.id_server = :id_server and c.moderation = :moderation');
        $getComments->execute(array(':id_server' => $getInfoServer['id'], ':moderation' => $moderation));
        $getComments = $getComments->fetchAll();


        $content = $this->view->renderPartial("server/info", [
            'data' => $getInfoServer,
            'comments' => $getComments,
            'currentSession' => $currentSession,
            'ownerName' => $ownerName,
            'current_user' => $IsAuth
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }


    /**
     * @throws Exception
     */
    public function verification()
    {
        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");
        $title = "Смена владельца сервера";

        $system = new System();

        if (isset($_GET['id'])) $id = (int)$_GET['id'];
        else parent::ShowError(404, "Сервер не найден!");


        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $id));
        $getInfoServer = $getInfoServer->fetch();

        if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");
        if ($getInfoServer['id_user'] == $user_profile['id']) parent::ShowError('403', "Вы уже являетесь владельцем этого сервера!");

        if (parent::isAjax()) {


            if (in_array($getInfoServer['game'], ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust'])) {
                $Query = new SourceQuery();
                $Info = array();
                try {
                    $Query->Connect($getInfoServer['ip'], $getInfoServer['port'], 2, SourceQuery::GOLDSOURCE);
                    $Info = $Query->GetInfo();
                    $hostname = $Info['HostName'];
                } catch (Exception $e) {
                    $Query->Disconnect();
                    $answer['status'] = "error";
                    $answer['error'] = "Сервер недоступен";
                    exit(json_encode($answer));
                }
            } elseif ($getInfoServer['game'] == 'samp') {
                $GameQ = new \GameQ\GameQ();
                $GameQ->addServer([
                    'type' => 'mta',
                    'host' => $getInfoServer['ip'] . ":" . $getInfoServer['port'],
                ]);
                $results = $GameQ->process();
                $Info = array_shift($results);
                $hostname = utf8_decode($Info['servername']);
            } elseif ($getInfoServer['game'] == 'mta') {
                $GameQ = new \GameQ\GameQ();
                $GameQ->addServer([
                    'type' => 'mta',
                    'host' => $getInfoServer['ip'] . ":" . $getInfoServer['port'],
                ]);
                $results = $GameQ->process();
                $Info = array_shift($results);
                $hostname = utf8_decode($Info['gq_hostname']);
            }


            if ("verification_" . $getInfoServer['verification_rand'] == $hostname) {

                $sql = "UPDATE ga_servers SET id_user = :id_user WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':id_user', $user_profile['id']);
                $update->bindParam(':id', $id);
                $update->execute();

                $answer['status'] = "success";
                $answer['success'] = "Вы успешно подтвердили владение сервером";
                exit(json_encode($answer));

            } else {
                $answer['status'] = "error";
                $answer['error'] = "Название сервера не совпадает с проверочным";
                exit(json_encode($answer));
            }


        } else {

            if ($getInfoServer['verification_rand'] == 0) {
                $verification_rand = $system->generateRandomNumbers(5);
                $sql = "UPDATE ga_servers SET verification_rand = :verification_rand WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':verification_rand', $verification_rand);
                $update->bindParam(':id', $id);
                $update->execute();
                $getInfoServer['verification_rand'] = $verification_rand;
            }


            $content = $this->view->renderPartial("server/verification", ['data' => $getInfoServer]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }

    }

    public function getPlayers()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = null;

        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $id));
        $getInfoServer = $getInfoServer->fetch();

        if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");

        $Query = new SourceQuery();
        $Players = [];
        if (in_array($getInfoServer['game'], ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust', 'csgo2'])) {
            try {
                $Query->Connect($getInfoServer['ip'], $getInfoServer['port'], 3, SourceQuery::GOLDSOURCE);

                $Players = $Query->GetPlayers();

            } catch (Exception $e) {
                $Exception = $e;
            }
        } else if ($getInfoServer['game'] == 'samp') {
            $GameQ = new \GameQ\GameQ();
            $GameQ->addServer([
                'type' => 'samp',
                'host' => $getInfoServer['ip'] . ":" . $getInfoServer['port'],
            ]);
            $results = $GameQ->process();
            $Info = array_shift($results);
            $Players = $Info['players'];

        } else if ($getInfoServer['game'] == 'mta') {
            $GameQ = new \GameQ\GameQ();
            $GameQ->addServer([
                'type' => 'mta',
                'host' => $getInfoServer['ip'] . ":" . $getInfoServer['port'],
            ]);
            $results = $GameQ->process();
            $Info = array_shift($results);
            $Players = $Info['players'];

        }


        $content = $this->view->renderPartial("server/getPlayers", ['data' => $Players, 'game' => $getInfoServer['game']]);
        echo $content;
    }


    public function vote()
    {

        $id = (int)$_POST['id'];
        $type = $_POST['type'];
        $captcha = $_POST['captcha'];


        $checkServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $checkServer->execute(array(':id' => $id));
        $checkServer = $checkServer->fetch();

        if (empty($checkServer)) parent::ShowError(404, "Страница не найдена!");
        if (parent::isAjax()) {
            $system = new System();
            $ip = $system->getIP();

            if (!isset($_SESSION['captcha'])){
                $answer['status'] = "error";
                $answer['error'] = "Капча введена не верно!";
                exit(json_encode($answer));
            }

            if ($_SESSION['captcha'] != md5($captcha)) {
                $answer['status'] = "error";
                $answer['error'] = "Капча введена не верно!";
                exit(json_encode($answer));
            }


            if (isset($_COOKIE['votePlus' . $id])) {
                $answer['status'] = "error";
                $answer['error'] = "Вы уже голосовали сегодня за этот сервер!";
                exit(json_encode($answer));
            }

            $checkVote = $this->db->prepare('SELECT date_create FROM ga_logs_vote WHERE ip = :ip');
            $checkVote->execute(array(':ip' => $ip));
            $checkVote = $checkVote->fetch();
            if ($checkVote) {
                if ($checkVote['date_create'] > time()) {
                    $answer['status'] = "error";
                    $answer['error'] = "Вы уже голосовали сегодня за этот сервер!";
                    exit(json_encode($answer));
                }
            }

            $nameCookie = "votePlus" . $id;
            SetCookie("votePlus" . $id, "yes", time() + (3600 * 24));

            $this->db->exec("INSERT INTO ga_logs_vote (ip, cookie, date_create) VALUES('$ip', '$nameCookie', '" . time() . "')");

            if ($type == 'plus') {
                $rating = $checkServer['rating'] + 1;
            } else $rating = $checkServer['rating'] - 1;

            $sql = "UPDATE ga_servers SET rating = :rating WHERE id = :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':rating', $rating, PDO::PARAM_INT);
            $update->bindParam(':id', $id, PDO::PARAM_INT);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Ваш голос успешно учтен!";
            $answer['rating'] = $rating;
            exit(json_encode($answer));

        }
    }

    public function AddComment()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        $user = new User();
        $profile = $user->isAuth();
        $idUser = $profile['id'] ?? null;
        if (parent::isAjax()) {
            if (isset($_POST['id'])) $id = (int)$_POST['id']; else $id = null;
            $comment = strip_tags($_POST['comment']);

            $checkServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
            $checkServer->execute(array(':id' => $id));
            $checkServer = $checkServer->fetch();

            if (empty($checkServer)) parent::ShowError(404, "Страница не найдена!");

            if ($settings['comments']['guest_allow'] == '0' && !$profile) {
                $answer['status'] = "error";
                $answer['error'] = "Только авторизованные пользователи могут оставлять комментарии";
                exit(json_encode($answer));
            }
            //	Пустой комментарий
            if (empty($_POST['comment'])) {
                $answer['status'] = "error";
                $answer['error'] = "Введите комментарий (от 10 до 300 символов)";
                exit(json_encode($answer));
            }
            //
            //	Ограничение ввода символов
            if (strlen($_POST['comment']) < 10 or strlen($_POST['comment']) > 300) {
                $answer['status'] = "error";
                $answer['error'] = "Комментарий должен содержать от 10 до 300 символов";
                exit(json_encode($answer));
            }
            //
            if ($settings['comments']['moderation'] == '1') {
                $text_success = "Ваш комментарии успешно отправлен!";
                $moderation = 1;
            } else {
                $text_success = "Ваш комментарии успешно отправлен, после проверки администратором она появиться";
                $moderation = 0;
            }



            $stmt = $this->db->prepare("INSERT INTO ga_comments (moderation, id_user, id_server, text, date_create) 
                            VALUES (:moderation, :id_user, :id_server, :text, :date_create)");

            $stmt->bindParam(':moderation', $moderation);
            $stmt->bindParam(':id_user', $idUser);
            $stmt->bindParam(':id_server', $id);
            $stmt->bindParam(':text', $comment);
            $stmt->bindValue(':date_create', time());

            $stmt->execute();



            $answer['status'] = "success";
            $answer['success'] = $text_success;
            exit(json_encode($answer));


        }
    }

}
