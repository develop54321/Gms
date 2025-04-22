<?php

namespace controllers;

use components\Flash;
use components\Json;
use components\Mail;
use components\Pagination;
use components\pay_method\FreekassaClient;
use components\pay_method\LavaClient;
use components\pay_method\YooKassaClient;
use components\pay_method\YooKassaService;
use components\pay_method\YooMoneyClient;
use components\ReCaptcha;
use components\Services;
use components\System;
use components\User;
use core\BaseController;
use PDO;
use PDOException;
use Ramsey\Uuid\Guid\Guid;
use Ramsey\Uuid\Uuid;

class UserController extends BaseController
{


    public function logout()
    {
        $user = new User();
        if ($user->isAuth()) {
            $expire_time = time() - 3600;
            setcookie('id_user', '', $expire_time, '/');
            setcookie('hash', '', $expire_time, '/');
            header("Location: /user/login");
        }
    }

    public function index()
    {
        $title = "Панель управления";
        $user = new User();
        $user_profile = $user->isAuth();
        if ($user_profile === false) return header("Location: /user/login");


        $sumMonth = 0;

        if ($user_profile['role'] == 'partner') {
            $begin_currnet_month = mktime(0, 0, 0, date("m"), 1, date("Y"));
            $getPayLogs = $this->db->query('SELECT * FROM ga_pay_logs WHERE id_user = "' . $user_profile['id'] . '" and  date_create > ' . $begin_currnet_month . '');
            $getPayLogs = $getPayLogs->fetchAll();

            $newArr = [];
            foreach ($getPayLogs as $row) {
                $decode = json_decode($row['content'], true);
                if ($decode['type_pay'] == 'payApi') {
                    $sumMonth = $sumMonth + $decode['price'];
                }
            }
        }

        if ($user_profile['role'] == 'partner') {
            $params = json_decode($user_profile['params'], true);
            $user_profile['discount_api'] = $params['discount_api'];
        }

        $content = $this->view->renderPartial("user/index", ['sumMonth' => $sumMonth, 'user_profile' => $user_profile]);

        $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);

    }

    public function removeServer()
    {
        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");

        if (parent::isAjax()) {

            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = null;
            $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id and id_user = :id_user');
            $getInfoServer->bindValue(":id", $id);
            $getInfoServer->bindValue(":id_user", $user_profile['id']);
            $getInfoServer->execute();
            $getInfoServer = $getInfoServer->fetch();
            if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");

            if ($getInfoServer['ban'] != 0 or $getInfoServer['befirst_enabled'] != 0 or $getInfoServer['top_enabled'] != 0 or $getInfoServer['vip_enabled'] != 0 or $getInfoServer['color_enabled'] != 0 or $getInfoServer['gamemenu_enabled'] != 0 or $getInfoServer['boost'] != 0) {
                $answer['status'] = "error";
                $answer['error'] = "Сервер имеет платную услугу или забанен, удаление невозможно!";
                exit(json_encode($answer));
            } else {

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


    public function pay()
    {
        $title = "Пополнение счета";
        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");



        if (parent::isAjax()) {

            $dataPost = $this->readPostJson();


            if ($dataPost['typePayment'] === null) {
                $answer['status'] = "error";
                $answer['error'] = "Способ оплаты не выбран";
                exit(json_encode($answer));
            }
            $typePayment = (int)$dataPost['typePayment'];
            $amount = (int)$dataPost['amount'];

            $CheckPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
            $CheckPayMethods->bindValue(":id", $typePayment);
            $CheckPayMethods->execute();
            if ($CheckPayMethods->rowCount() == '0') parent::ShowError(404, "Страница не найдена!");
            if ($amount <= 0) parent::ShowError(404, "Страница не найдена!");


            $content = json_encode(['type_pay' => "refill", 'id_user' => $user_profile['id'], 'amount' => $amount]);

            $getInfoPayMethod = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
            $getInfoPayMethod->execute(array(':id' => $typePayment));
            $getInfoPayMethod = $getInfoPayMethod->fetch();
            $infoPaymentSettings = Json::decode($getInfoPayMethod['content'], true);
            if (!$getInfoPayMethod) {
                $answer["status"] = "error";
                $answer["error"] = "Способ оплаты не найден";
                exit(json_encode($answer));
            }


            $stmt = $this->db->prepare("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods)
            VALUES (:content, :date_create, :status, :id_user, :pay_methods)");


            $stmt->bindParam(':content', $content);
            $stmt->bindValue(':date_create', time(), PDO::PARAM_INT);
            $stmt->bindValue(':status', 'expects');
            $stmt->bindValue(':id_user', $user_profile['id'], PDO::PARAM_INT);
            $stmt->bindValue(':pay_methods', $getInfoPayMethod['typeCode']);
            $stmt->execute();

            $invoiceId = $this->db->lastInsertId();

            $description = "Оплата услуги №" . $invoiceId;
            $htmlForm = null;
            $paymentUrl = null;
            switch ($getInfoPayMethod['typeCode']) {
                case "freekassa":
                    $sign = md5($infoPaymentSettings['fk_id'] . ":" . $amount . ":" . $infoPaymentSettings['fk_key1'] . ":" . $invoiceId);
                    $client = new FreekassaClient(
                        $infoPaymentSettings['fk_id'],
                        $amount,
                        $invoiceId,
                        $sign
                    );

                    $htmlForm = $client->getHtmlForm();
                    break;


                case "yoomoney":
                    $client = new YooMoneyClient(
                        $infoPaymentSettings['receiver'],
                        $amount,
                        $invoiceId,
                        $description
                    );


                    $htmlForm = $client->getHtmlForm();
                    break;

                case "yookassa":
                    try {
                        $client = new YooKassaClient(
                            (int)$infoPaymentSettings['shop_id'],
                            $infoPaymentSettings['secret_key']
                        );

                        /** @var array{guid: string, url: string} $resp */
                        $resp = $client->createPayment(
                            $amount,
                            $description,
                            $invoiceId
                        );

                        $paymentUrl = $resp['url'];
                    } catch (\Exception $e) {
                        $answer['status'] = "error";
                        $answer['error'] = $e->getMessage();
                        exit(json_encode($answer));

                    }
                    break;


                case "lava":
                    try {
                        $client = new LavaClient(
                            $infoPaymentSettings['shop_id'],
                            $infoPaymentSettings['secret_key']
                        );

                        /** @var array{guid: string, url: string} $resp */
                        $resp = $client->createPayment(
                            $amount,
                            $invoiceId
                        );

                        $paymentUrl = $resp['url'];
                    } catch (\Exception $e) {
                        $answer['status'] = "error";
                        $answer['error'] = $e->getMessage();
                        exit(json_encode($answer));

                    }


                    break;

                default:
                    parent::ShowError(400, "Bad request!");
            }


            $answer['status'] = "success";
            $answer['payment_form'] = $htmlForm;
            $answer['payment_url'] = $paymentUrl;
            exit(json_encode($answer));

        }


        $status = 1;
        $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
        $getPayMethods->execute(array(':status' => $status));
        $getPayMethods = $getPayMethods->fetchAll();


        $content = $this->view->renderPartial("user/pay", ['user_profile' => $user_profile, 'pay_methods' => $getPayMethods]);


        $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);
    }

    public function servers()
    {
        $title = "Мои сервера";
        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");


        $countServers = $this->db->prepare('SELECT * FROM ga_servers WHERE id_user = :id_user');
        $countServers->execute(array(':id_user' => $user_profile['id']));
        $count = $countServers->rowCount();


        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));


        $getMyServers = $this->db->prepare('SELECT s.id, s.map, s.hostname, s.game, s.moderation, s.ip, s.port, s.players, s.max_players, s.rating, s.ban, s.status, u.email FROM ga_servers s LEFT JOIN ga_users u ON s.id_user=u.id WHERE s.id_user = :id_user ORDER BY s.id DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getMyServers->execute(array(':id_user' => $user_profile['id']));
        $getMyServers = $getMyServers->fetchAll();

        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("user/servers", [
            'user_profile' => $user_profile,
            'servers' => $getMyServers,
            'pagination_html' => $pagination_html
        ]);


        $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);

    }

    public function payLogs()
    {

        $title = "История платежей";
        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");


        $countPaylogs = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id_user = :id_user');
        $countPaylogs->execute(array(':id_user' => $user_profile['id']));
        $count = $countPaylogs->rowCount();


        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));


        $newArr = [];

        $getPayLogs = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id_user = :id_user ORDER BY id DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getPayLogs->execute(array(':id_user' => $user_profile['id']));

        foreach ($getPayLogs as $row) {
            $content = json_decode($row['content'], true);
            if ($content['type_pay'] == 'refill') {
                $id = $content['id_user'];
                $servicesName = "Пополнение счета";
                $price = $content['amount'] ?? 0;
            } elseif ($content['type_pay'] == "payServices" or $content['type_pay'] == "payApi") {
                $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
                $getInfoServices->execute(array(':id' => $content['id_services']));
                $getInfoServices = $getInfoServices->fetch();
                if (!empty($getInfoServices)) {
                    $servicesName = $getInfoServices['name'];
                } else {
                    $servicesName = 'Услуга не найдена';

                }
                $id = $content['id_server'];
                $price = $content['price'];
            }
            $newArr[] = ['id' => $row['id'], 'type_pay' => $content['type_pay'], 'price' => $price, 'id_object' => $id, 'servicesName' => $servicesName, 'date_create' => $row['date_create'], 'pay_methods' => $row['pay_methods'], 'status' => $row['status']];

        }

        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("user/paylogs", [
            'user_profile' => $user_profile,
            'data' => $newArr,
            'pagination_html' => $pagination_html
        ]);


        $this->view->render("main", ['content' => $content, 'title' => $title, 'user_profile' => $user_profile]);

    }

    public function signup()
    {
        $title = "Регистрация";
        $user = new User();
        if ($user->isAuth()) header("Location: /");

        if (parent::isAjax()) {
            $firstname = strip_tags($_POST['firstname']);
            $lastname = strip_tags($_POST['lastname']);
            $email = strip_tags($_POST['email']);

            $password = strip_tags($_POST['password']);
            $password2 = strip_tags($_POST['password2']);
            $captcha = $_POST['captcha'] ?? null;

            if (!isset($_SESSION['captcha'])) {
                $answer['status'] = "error";
                $answer['error'] = "Капча введена не верно!";
                exit(json_encode($answer));
            }

            if ($_SESSION['captcha'] != md5($captcha)) {
                $answer['status'] = "error";
                $answer['error'] = "Капча введена не верно!";
                exit(json_encode($answer));
            }

            if (!preg_match('/^[a-zA-Zа-яА-Я]+$/ui', $firstname)) {
                $answer['status'] = "error";
                $answer['error'] = "<b>Имя</b> введен неверно";
                exit(json_encode($answer));
            }

            if (!preg_match('/^[a-zA-Zа-яА-Я]+$/ui', $lastname)) {
                $answer['status'] = "error";
                $answer['error'] = "<b>Фамилия</b> введен неверно";
                exit(json_encode($answer));
            }

            if (!preg_match('/^.{6,}$/', $password)) {
                $answer['status'] = "error";
                $answer['error'] = "<b>Пароль</b> введен неверно, минимум 6 символов";
                exit(json_encode($answer));
            }

            if ($password != $password2) {
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
            if ($isEmail->rowCount() != '0') {
                $answer['status'] = "error";
                $answer['error'] = "Данный <b>email</b> уже занят в системе";
                exit(json_encode($answer));
            }


            $password = password_hash($password, PASSWORD_DEFAULT);
            $time = time();
            $this->db->exec("INSERT INTO ga_users (email, lastname, firstname, password, role, date_reg) 
            VALUES('$email', '$lastname', '$firstname', '$password', 'user', '$time')");


            $content = "
            <p>Здравствуйте!</p>
            <p>Добро пожаловать на <a href=\"" . BASE_URL . "\">" . BASE_URL . "</a>! <br/> Мы рады, что вы присоединились к нам.</p>
            <p>Ваш аккаунт успешно зарегистрирован. Теперь вы можете пользоваться всеми возможностями нашего сайта.</p>
            <p>Если у вас возникнут вопросы или потребуется помощь, не стесняйтесь обращаться в нашу службу поддержки.</p>
            <p>Спасибо, что выбрали нас!</p>
            <p>С уважением,<br/>Команда " . BASE_URL . "</p>
            ";

            $stmt = $this->db->prepare("INSERT INTO ga_queue (status, attempt, max_attempt, message, date_create)
                VALUES (:status, :attempt, :max_attempt, :message, :date_create)");

            $message = json_encode([
                "address" => $email,
                "subject" => "Добро пожаловать",
                "content" => $content,
            ]);

            $status = "WAIT";
            $stmt->bindParam(':status', $status);
            $stmt->bindValue(':attempt', 1, PDO::PARAM_INT);
            $stmt->bindValue(':max_attempt', 3, PDO::PARAM_INT);
            $stmt->bindValue(':message', $message);
            $stmt->bindValue(':date_create', time());
            $stmt->execute();


            unset($_SESSION['captcha']);

            $answer['status'] = "success";
            $answer['success'] = "Вы успешно зарегистрировались";
            exit(json_encode($answer));

        } else {

            $content = $this->view->renderPartial("user/signup", []);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function reset()
    {
        $title = "Восстановления пароля";
        $user = new User();
        if ($user->isAuth()) header("Location: /");
        $system = new System();
        if (parent::isAjax()) {
            $email = strip_tags($_POST['email']);

            if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $answer['status'] = "error";
                $answer['error'] = "<b>E-mail</b> адрес указан верно";
                exit(json_encode($answer));
            }


            $check = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email ');
            $check->bindValue(":email", $email);
            $check->execute();
            $findUserByEmail = $check->fetch(PDO::FETCH_ASSOC);
            if ($findUserByEmail === null) {
                $answer['status'] = "error";
                $answer['error'] = "Пользователь с указанным e-mail не найден";
                exit(json_encode($answer));
            } else {

                // Проверяем, истекло ли время с момента создания reset_code
                $resetCodeCreatedAt = $findUserByEmail['reset_code_created_at'];
                $currentTime = time();
                $timeDifference = $currentTime - $resetCodeCreatedAt;


                if ($timeDifference < 300) {
                    $answer['status'] = "error";
                    $answer['error'] = "Вы недавно запрашивали код активации, попробуйте через " . (300 - $timeDifference) . " секунд";
                    exit(json_encode($answer));
                }

                $resetCodeCreatedAt = time();
                $resetCode = md5(mt_rand(1000, 10000));


                $sql = "UPDATE ga_users SET reset_code = :reset_code, reset_code_created_at = :reset_code_created_at WHERE email = :email";
                $update = $this->db->prepare($sql);
                $update->bindParam(':reset_code', $resetCode);
                $update->bindParam('reset_code_created_at', $resetCodeCreatedAt);
                $update->bindParam(':email', $email);
                $update->execute();


                $linkReset = BASE_URL . "/user/reset?code=$resetCode";

                $content = "
                <p>Здравствуйте!</p>
                <p>Вы получили это письмо, потому что на сайте <a href=\"" . BASE_URL . "\">" . BASE_URL . "</a> был запрошен сброс пароля для аккаунта, зарегистрированного на ваш email: <strong>" . $email . "</strong>.</p>
                <p>Для установки нового пароля перейдите по ссылке ниже:</p>
                <p><a href=\"" . $linkReset . "\">Сбросить пароль</a></p>
                <p>Если ссылка не открывается, скопируйте её и вставьте в адресную строку браузера:</p>
                <p><code>" . $linkReset . "</code></p>
                <p>Если вы не запрашивали сброс пароля или вспомнили свой текущий пароль, просто проигнорируйте это письмо.</p>
                <p>С уважением,<br/>Команда " . BASE_URL . "</p>
                ";

                $stmt = $this->db->prepare("INSERT INTO ga_queue (status, attempt, max_attempt, message, date_create)
                VALUES (:status, :attempt, :max_attempt, :message, :date_create)");

                $message = json_encode([
                    "address" => $email,
                    "subject" => "Сброс пароля",
                    "content" => $content,
                ]);

                $status = "WAIT";
                $stmt->bindParam(':status', $status);
                $stmt->bindValue(':attempt', 1, PDO::PARAM_INT);
                $stmt->bindValue(':max_attempt', 3, PDO::PARAM_INT);
                $stmt->bindValue(':message', $message);
                $stmt->bindValue(':date_create', time());
                $stmt->execute();


                $answer['status'] = "success";
                $answer['success'] = "На вашу почту было отправлено письмо с кодом подтверждения, для получение нового пароля перейдите по ссылке содержащейся в письме.";
                exit(json_encode($answer));
            }


        } else {
            if (isset($_GET['code'])) {
                $code = $_GET['code'];
                $checkCode = $this->db->prepare('SELECT * FROM ga_users WHERE reset_code = :reset_code');
                $checkCode->bindValue(":reset_code", $code);
                $checkCode->execute();
                if ($checkCode->rowCount() === 1) {
                    $newPassword = $system->generateCharacter(8);

                    $hashPassword = password_hash($newPassword, PASSWORD_DEFAULT);

                    $null = null;
                    $sql = "UPDATE ga_users SET password = :password, reset_code = '', reset_code_created_at = :reset_code_created_at WHERE reset_code = :reset_code";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':password', $hashPassword);
                    $update->bindParam(':reset_code', $code);
                    $update->bindParam(':reset_code_created_at', $null);
                    $update->execute();


                    $content = $this->view->renderPartial("user/reset", ['password' => $newPassword]);
                } else parent::ShowError(404, "Страница не найдена!");

            } else {
                $content = $this->view->renderPartial("user/reset", []);
            }


            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }
    }


    public function login()
    {
        $title = "Авторизация";
        $user = new User();
        if ($user->isAuth()) header("Location: /");

        if (parent::isAjax()) {
            $email = strip_tags($_POST['email']);
            $password = strip_tags($_POST['password']);

            $check = $this->db->prepare('SELECT password, email FROM ga_users WHERE email = :email');
            $check->bindValue(":email", $email);
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

            if ($data_user['role'] == 'banned') {
                $answer['status'] = "error";
                $answer['error'] = "Ваш аккаунт заблокирован";
                exit(json_encode($answer));
            }

            $hash = md5($data_user['id']);
            setcookie('hash', $hash, time() + (86400 * 30), "/");
            setcookie('id_user', $data_user['id'], time() + (86400 * 30), "/");

            $sql = "UPDATE ga_users SET hash = :hash WHERE id = :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':hash', $hash, PDO::PARAM_STR);
            $update->bindParam(':id', $data_user['id'], PDO::PARAM_INT);
            $update->execute();


            $answer['status'] = "success";
            $answer['success'] = "Вы успешно авторизовались";
            exit(json_encode($answer));


        } else {
            $content = $this->view->renderPartial("user/login", []);

            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }
    }


    public function serverPay()
    {

        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        $title = "Платные услуги";


        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = null;

        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $id));
        $getInfoServer = $getInfoServer->fetch();

        if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");

        $getServices = $this->db->query('SELECT * FROM ga_services');
        $getServices = $getServices->fetchAll();

        if (isset($_GET['step'])) $step = (int)$_GET['step']; else $step = 1;

        if ($step == '2') {
            if (parent::isAjax()) {
                //step 2
                $id_services = (int)$_POST['id_services'];

                $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
                $getInfoServices->execute(array(':id' => $id_services));
                $getInfoServices = $getInfoServices->fetch();
                if (empty($getInfoServices)) parent::ShowError(404, "Страница не найдена!");

                if ($user_profile['balance'] >= $getInfoServices['price']) {

                    // Проверка на бан	razz Если сервер в бане и это не услуга разбана
                    if ($getInfoServer['ban'] == 1 and $getInfoServices['type'] != 'razz') {
                        $answer['status'] = "error";
                        $answer['error'] = "Сервер Забанен!";
                        exit(json_encode($answer));
                    }

                    switch ($getInfoServices['type']) {
                        //	Befirst
                        case "befirst":
                            if ($getInfoServer['befirst_enabled'] == '0') $place = (int)$_POST['place']; else $place = 0;
                            if ($getInfoServer['befirst_enabled'] == '0') {
                                $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE befirst_enabled = :befirst_enabled');
                                $checkPlace->execute(array(':befirst_enabled' => $place));
                                if ($checkPlace->rowCount() != '0') {
                                    $answer['status'] = "error";
                                    $answer['error'] = "Нет свободных мест";
                                    exit(json_encode($answer));
                                }
                            }
                            if ($settings['global_settings']['befirst_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $limitBefirstServers = $settings['global_settings']['count_servers_befirst'];
                            $countBefirstServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `befirst_enabled` != '0'")->rowCount();
                            $CheckBefirstServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $id . "' and `befirst_enabled` != '0' LIMIT 1")->rowCount();
                            if ($countBefirstServers >= $limitBefirstServers and $CheckBefirstServer == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Нет свободных мест";
                                exit(json_encode($answer));
                            }
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'befirst', 'place' => $place, 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Top
                        case "top":
                            if ($getInfoServer['top_enabled'] == '0') $place = (int)$_POST['place']; else $place = 0;
                            if ($getInfoServer['top_enabled'] == '0') {
                                $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                                $checkPlace->execute(array(':top_enabled' => $place));
                                if ($checkPlace->rowCount() != '0') {
                                    $answer['status'] = "error";
                                    $answer['error'] = "Нет свободных мест";
                                    exit(json_encode($answer));
                                }
                            }
                            if ($settings['global_settings']['top_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $limitTopServers = $settings['global_settings']['count_servers_top'];
                            $countTopServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `top_enabled` != '0'")->rowCount();
                            $CheckTopServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $id . "' and `top_enabled` != '0' LIMIT 1")->rowCount();
                            if ($countTopServers >= $limitTopServers and $CheckTopServer == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Нет свободных мест";
                                exit(json_encode($answer));
                            }
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'top', 'place' => $place, 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Vip
                        case "vip":
                            $vip = 1;
                            if ($settings['global_settings']['vip_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $limitVipServers = $settings['global_settings']['count_servers_vip'];
                            $countVipServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `vip_enabled`='1'")->rowCount();
                            $CheckVipServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $id . "' and `vip_enabled` = '" . $vip . "' LIMIT 1")->rowCount();
                            if ($countVipServers >= $limitVipServers and $CheckVipServer == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Нет свободных мест";
                                exit(json_encode($answer));
                            }
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'vip', 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Color
                        case "color":
                            if ($settings['global_settings']['color_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $limitColorServers = $settings['global_settings']['count_servers_color'];
                            $countColorServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `color_enabled`!= '0'")->rowCount();
                            $CheckColorServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $id . "' and `color_enabled` != '0' LIMIT 1")->rowCount();
                            if ($countColorServers >= $limitColorServers and $CheckColorServer == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Нет свободных мест";
                                exit(json_encode($answer));
                            }
                            $color = $_POST['selectColor'];
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'color', 'color' => $color, 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Gamemenu
                        case "gamemenu":
                            $gamemenu = 1;
                            if ($settings['global_settings']['gamemenu_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $limitGamemenuServers = $settings['global_settings']['count_servers_gamemenu'];
                            $countGamemenuServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `gamemenu_enabled`='1'")->rowCount();
                            $CheckGamemenuServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $id . "' and `gamemenu_enabled` = '" . $gamemenu . "' LIMIT 1")->rowCount();
                            if ($countGamemenuServers >= $limitGamemenuServers and $CheckGamemenuServer == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Нет свободных мест";
                                exit(json_encode($answer));
                            }
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'gamemenu', 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Boost
                        case "boost":
                            if ($settings['global_settings']['boost_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'boost', 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Votes
                        case "votes":
                            if ($settings['global_settings']['votes_on'] == 0) {
                                $answer['status'] = "error";
                                $answer['error'] = "Услуга отключена";
                                exit(json_encode($answer));
                            }
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'votes', 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        //	Unban
                        case "razz":
                            $content = json_encode(['id_services' => $id_services, 'type_pay' => "payServices", 'price' => $getInfoServices['price'], 'type' => 'razz', 'id_server' => $id]);
                            $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'expects', " . $user_profile['id'] . ", 'bill')");
                            $payId = $this->db->lastInsertId();
                            break;

                        default:
                            parent::ShowError(404, "Страница не найдена!");
                            break;
                    }
                    $services = new Services();
                    $services->processing(['inv_id' => $payId, 'price' => $getInfoServices['price'], 'pay_methods' => "bill"]);

                    $newBalance = $user_profile['balance'] - $getInfoServices['price'];
                    $sql = "UPDATE ga_users SET balance = :balance  WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':balance', $newBalance, PDO::PARAM_INT);
                    $update->bindParam(':id', $user_profile['id'], PDO::PARAM_INT);
                    $update->execute();

                    $answer['status'] = "success";
                    $answer['success'] = "Услуга успешно куплена";
                    exit(json_encode($answer));

                    $this->view->render("main", ['content' => $content, 'title' => $title]);
                } else {
                    $answer['status'] = "error";
                    $answer['error'] = "Недостаточно средств на счете";
                    exit(json_encode($answer));
                }
            }
        } else if ($step == '1') {

            $content = $this->view->renderPartial("user/serverpay", ['type' => 'selectServices', 'serverInfo' => $getInfoServer, 'settings' => $settings, 'services' => $getServices, 'step' => 1]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }

    }

    public function getForm()
    {
        $user = new User();
        $user_profile = $user->isAuth();
        if (!$user_profile) header("Location: /user/login");

        if (parent::isAjax()) {
            $getSettings = $this->db->query('SELECT * FROM ga_settings');
            $settings = $getSettings->fetch();
            $settings = json_decode($settings['content'], true);
            if (isset($_GET['id_server'])) $id_server = (int)$_GET['id_server']; else $id_server = null;

            $getInfoServerRow = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
            $getInfoServerRow->execute(array(':id' => $id_server));
            $getInfoServerRow = $getInfoServerRow->fetch();
            if (empty($getInfoServerRow)) parent::ShowError(404, "Сервер не найден!");

            if (isset($_GET['id_services'])) $id_services = (int)$_GET['id_services']; else  parent::ShowError(404, "Страница не найдена!");

            $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
            $getInfoServices->execute(array(':id' => $id_services));
            $getInfoServices = $getInfoServices->fetch();
            if (!isset($id_services)) parent::ShowError(404, "Страница не найдена!");

            $databefirst = null;
            $datatop = null;
            if ($getInfoServices) {


                if ($getInfoServices['type'] == 'befirst') {
                    $databefirst = [];
                    for ($i = 1; $i <= $settings['global_settings']['count_servers_befirst']; $i++) {
                        $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE befirst_enabled = :befirst_enabled');
                        $isPlace->execute(array(':befirst_enabled' => $i));
                        if ($isPlace->rowCount() != '0') {
                            $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE befirst_enabled = :befirst_enabled');
                            $getInfoServer->execute(array(':befirst_enabled' => $i));
                            $getInfoServer = $getInfoServer->fetch();

                            $databefirst[] = ['id' => $i, 'status' => 1];
                        } else {
                            $databefirst[] = ['id' => $i, 'status' => 0];
                        }
                    }
                }


                if ($getInfoServices['type'] == 'top') {
                    $datatop = [];
                    for ($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++) {
                        $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                        $isPlace->execute(array(':top_enabled' => $i));
                        if ($isPlace->rowCount() != '0') {
                            $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                            $getInfoServer->execute(array(':top_enabled' => $i));
                            $getInfoServer = $getInfoServer->fetch();

                            $datatop[] = ['id' => $i, 'status' => 1];
                        } else {
                            $datatop[] = ['id' => $i, 'status' => 0];
                        }
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

            $content = $this->view->renderPartial("user/serverpayForm", [
                'user_profile' =>
                    $user_profile,
                'CodeColors' => $getCodeColors,
                'serverInfo' => $getInfoServerRow,
                'PayMethods' => $getPayMethods,
                'type' => $getInfoServices['type'] ?? null,
                'datatop' => $datatop,
                'databefirst' => $databefirst,
                'infoServices' => $getInfoServices,
                'step' => '1'
            ]);
            echo $content;

        } else parent::ShowError(404, "Страница не найдена!");
    }


}