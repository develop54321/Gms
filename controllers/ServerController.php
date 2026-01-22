<?php

namespace controllers;

use components\Captcha;
use components\GameServerQuery;
use components\Pagination;
use components\Servers;
use components\System;
use components\User;
use core\BaseController;
use Exception;
use PDO;


class ServerController extends BaseController
{

    public function add()
    {
        $settings = json_decode($this->db->query('SELECT * FROM ga_settings')->fetch()['content'], true);
        $title = "Добавить сервер";

        if (!parent::isAjax()) {
            $games = $this->db->query('SELECT * FROM ga_games WHERE status = 1')->fetchAll();
            $content = $this->view->renderPartial("server/add", ['games' => $games]);
            $this->view->render("main", ['content' => $content, 'title' => $title]);
            return;
        }

        $data = [
            'game' => strip_tags($_POST['game'] ?? ''),
            'ip' => trim(strip_tags($_POST['ip'] ?? '')),
            'port' => trim($_POST['port'] ?? ''),
            'query_port' => !empty($_POST['query_port']) ? trim($_POST['query_port']) : null,

            'text' => strip_tags($_POST['text'] ?? ''),
            'captcha' => $_POST['captcha'] ?? ''
        ];


        if (!(new Captcha())->validate($data['captcha'], "add_server")) {
            exit(json_encode(['status' => 'error', 'error' => 'Капча введена неверно']));
        }


        $stmt = $this->db->prepare('SELECT 1 FROM ga_games WHERE code = :code AND status = 1');
        $stmt->execute([':code' => $data['game']]);
        if ($stmt->rowCount() === 0) {
            exit(json_encode(['status' => 'error', 'error' => 'Игра не найдена']));
        }


        if (!is_numeric($data['port']) || $data['port'] < 1 || $data['port'] > 65535) {
            exit(json_encode(['status' => 'error', 'error' => 'Порт должен быть числом от 1 до 65535']));
        }
        if ($data['query_port'] && (!is_numeric($data['query_port']) || $data['query_port'] < 1 || $data['query_port'] > 65535)) {
            exit(json_encode(['status' => 'error', 'error' => 'Query-порт должен быть числом от 1 до 65535']));
        }

        if (mb_strlen($data['text']) > 300) {
            exit(json_encode(['status' => 'error', 'error' => 'Описание не должно превышать 300 символов']));
        }


        try {
            $resolvedIp = Servers::getIp($data['ip']);
        } catch (Exception $e) {
            exit(json_encode(['status' => 'error', 'error' => $e->getMessage()]));
        }

        $stmt = $this->db->prepare('SELECT 1 FROM ga_servers WHERE ip = :ip AND port = :port');
        $stmt->execute([':ip' => $resolvedIp, ':port' => $data['port']]);
        if ($stmt->rowCount() > 0) {
            exit(json_encode(['status' => 'error', 'error' => 'Сервер уже добавлен в систему']));
        }

        $hostForDb = filter_var($data['ip'], FILTER_VALIDATE_IP) ? null : $data['ip'];


        try {
            $query = new GameServerQuery($resolvedIp, $data['port'], $data['game'], $data['query_port']);
            $res = $query->query();

            if (empty($res['hostname'])) {
                throw new Exception("Не удалось получить информацию о сервере. Проверьте порты и настройки сервера.");
            }

            if ($data['game'] === 'samp') {
                $res['hostname'] = iconv('utf-8//IGNORE', 'cp1252//IGNORE', $res['hostname']);
                $res['hostname'] = iconv('cp1251//IGNORE', 'utf-8//IGNORE', $res['hostname']);
            }

            $user = new User();
            $id_user = $user->isAuth() ? $user->getProfile()['id'] : 0;
            $moderation = $settings['global_settings']['auto_add_server'] == '1' ? 1 : 0;


            $stmt = $this->db->prepare("
            INSERT INTO ga_servers 
            (status, moderation, id_user, game, ip, host, port, query_port, date_add, description, hostname, map, players, max_players) 
            VALUES 
            (:status, :moderation, :id_user, :game, :ip, :host, :port, :query_port, :date_add, :description, :hostname, :map, :players, :max_players)
        ");

            $stmt->execute([
                ':status' => 1,
                ':moderation' => $moderation,
                ':id_user' => $id_user,
                ':game' => $data['game'],
                ':ip' => $resolvedIp,
                ':host' => $hostForDb,
                ':port' => $data['port'],
                ':query_port' => $data['query_port'] ?: null,
                ':date_add' => time(),
                ':description' => $data['text'],
                ':hostname' => $res['hostname'] ?? null,
                ':map' => $res['map'] ?? null,
                ':players' => $res['players'] ?? null,
                ':max_players' => $res['max_players'] ?? null
            ]);

            $success = $moderation
                ? "Ваш сервер успешно добавлен, <a href='/server/{$resolvedIp}:{$data['port']}/info'>перейти</a>"
                : "Ваш сервер успешно добавлен, после проверки администратором она появится в мониторинге";

            exit(json_encode(['status' => 'success', 'success' => $success]));

        } catch (Exception $e) {
            exit(json_encode(['status' => 'error', 'error' => $e->getMessage()]));
        }
    }



    public function info($address){
        $user = new User();
        $IsAuth = $user->isAuth();

        $currentSession = null;
        if ($IsAuth) $currentSession = $IsAuth['id'];

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
               s.host, 
               s.port, 
               s.date_add, 
               s.rating, 
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

        if ($getInfoServer['ban'] == 1) parent::ShowError(403, "Сервер в бане");


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

        $moderation = 1;

        $countComments = $this->db->prepare('SELECT u.img FROM ga_comments c LEFT JOIN ga_users u ON c.id_user=u.id WHERE c.id_server = :id_server and c.moderation = :moderation');
        $countComments->execute(array(
            ':id_server' => $getInfoServer['id'],
            ':moderation' => $moderation
        ));
        $count = $countComments->rowCount();

        $pagination = new Pagination();
        $per_page = 5;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));


        $getComments = $this->db->prepare('SELECT c.id, c.text, u.lastname, u.firstname, c.date_create, u.img FROM ga_comments c LEFT JOIN ga_users u ON c.id_user=u.id WHERE c.id_server = :id_server and c.moderation = :moderation LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getComments->execute(array(':id_server' => $getInfoServer['id'], ':moderation' => $moderation));

        $getComments = $getComments->fetchAll();


        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("server/info", [
            'data' => $getInfoServer,
            'comments' => $getComments,
            'currentSession' => $currentSession,
            'ownerName' => $ownerName,
            'pagination_html' => $pagination_html,
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


            try {
                $GameServerQuery = new GameServerQuery($getInfoServer['ip'], $getInfoServer['port'], $getInfoServer['game'], $getInfoServer['query_port']);
                $res = $GameServerQuery->query();

                $hostname = $res['hostname'];


                if ($res['hostname'] === false or $res['hostname'] === null){
                    throw new \Exception("Не удалось получить информацию о сервере, <br>
                            Возможные причины: <br>
                            Неверные настройки firewall <br>
                            Неверные настройки сервера <br>
                            Неверно указаны порты");
                }



            }catch (Exception $e){
                $answer['status'] = "error";
                $answer['error'] = $e->getMessage();
                exit(json_encode($answer));
            }





            if ("ServerVerification_" . $getInfoServer['verification_rand'] == $hostname) {

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

            if ($getInfoServer['verification_rand_expired_at'] < time()) {

                $verificationRandExpiredAt = time() + 900;

                $verificationRand = $system->generateRandomNumbers(5);
                $sql = "UPDATE ga_servers SET verification_rand = :verification_rand, verification_rand_expired_at = :verification_rand_expired_at WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':verification_rand', $verificationRand);
                $update->bindParam(':verification_rand_expired_at', $verificationRandExpiredAt);
                $update->bindParam(':id', $id);
                $update->execute();
                $getInfoServer['verification_rand'] = $verificationRand;
            }


            $content = $this->view->renderPartial("server/verification", ['data' => $getInfoServer]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }

    }

    public function vote()
    {
        $id = (int)$_POST['id'];
        $type = $_POST['type'];



        $checkServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $checkServer->execute(array(':id' => $id));
        $checkServer = $checkServer->fetch();

        if (empty($checkServer)) parent::ShowError(404, "Страница не найдена!");
        if (parent::isAjax()) {
            $system = new System();
            $ip = $system->getIp();

            $captcha = new Captcha();
            if (!$captcha->validate($_POST['captcha'] ?? '', "vote_modal")) {
                $answer['status'] = 'error';
                $answer['error'] = 'Капча введена неверно';
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


            $stmt = $this->db->prepare("INSERT INTO ga_logs_vote (ip, cookie, date_create) VALUES (:ip, :cookie, :date_create)");
            $stmt->execute([':ip'=> $ip, ':cookie'=> $nameCookie, ':date_create'=> time()]);


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

            if (empty($_POST['comment'])) {
                $answer['status'] = "error";
                $answer['error'] = "Введите комментарий (от 10 до 300 символов)";
                exit(json_encode($answer));
            }

            if (strlen($_POST['comment']) < 10 or strlen($_POST['comment']) > 500) {
                $answer['status'] = "error";
                $answer['error'] = "Комментарий должен содержать от 10 до 500 символов";
                exit(json_encode($answer));
            }

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
