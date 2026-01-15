<?php

namespace controllers;

use components\Flash;
use components\Json;
use components\pay_method\FreekassaClient;
use components\pay_method\LavaClient;
use components\pay_method\YooKassaClient;
use components\pay_method\YooMoneyClient;
use components\Services;
use components\User;
use core\BaseController;
use components\System;
use PDO;

class PayController extends BaseController
{

    public function index()
    {
        $title = "Заказ платной услуги";

        if (isset($_POST['query'])) {
            $query = $_POST['query'];
            $query = explode(":", $query);
            if (!isset($query[1])) $query[1] = null;

            $getInfoServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
            $getInfoServers->bindValue(":ip", $query[0]);
            $getInfoServers->bindValue(":port", $query[1]);
            $getInfoServers->execute();
            $getServers = $getInfoServers->fetchAll();

            $content = $this->view->renderPartial("pay", ['type' => 'search', 'servers' => $getServers]);
        } else {

            $content = $this->view->renderPartial("pay", ['type' => 'searchForm']);
        }
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }


    public function select($id)
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);


        $title = "Заказ платной услуги";


        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $id));
        $getInfoServer = $getInfoServer->fetch();


        $getServices = $this->db->query('SELECT * FROM ga_services');
        $getServices = $getServices->fetchAll();


        $content = $this->view->renderPartial("pay/select", ['type' => 'selectServices',
            'serverInfo' => $getInfoServer,
            'settings' => $settings,
            'services' => $getServices,
            'step' => 1,
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }


    public function form($id)
    {
        if (parent::isAjax()) {
            $getSettings = $this->db->query('SELECT * FROM ga_settings');
            $settings = $getSettings->fetch();
            $settings = json_decode($settings['content'], true);

            $id_server = (int)$id;

            $getInfoServerRow = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
            $getInfoServerRow->execute(array(':id' => $id_server));
            $getInfoServerRow = $getInfoServerRow->fetch();
            if (empty($getInfoServerRow)) parent::ShowError(404, "Сервер не найден!");

            if (isset($_GET['id_services'])) $id_services = (int)$_GET['id_services']; else  parent::ShowError(404, "Страница не найдена!");

            $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
            $getInfoServices->execute(array(':id' => $id_services));
            $getInfoServices = $getInfoServices->fetch();
            if (!isset($id_services)) parent::ShowError(404, "Страница не найдена!");


            $top = null;

            if ($getInfoServices) {
                $top = '';
                if ($getInfoServices['type'] == 'top') {
                    $top = [];
                    for ($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++) {
                        $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                        $isPlace->execute(array(':top_enabled' => $i));
                        if ($isPlace->rowCount() != '0') {
                            $top[] = ['id' => $i, 'status' => 1];
                        } else {
                            $top[] = ['id' => $i, 'status' => 0];
                        }
                    }
                }
            }

            $status = 1;
            $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
            $getPayMethods->execute(array(':status' => $status));
            $getPayMethods = $getPayMethods->fetchAll();

            // new colors
            $activColor = 1;
            $getCodeColors = $this->db->prepare('SELECT * FROM ga_code_colors WHERE activ = :activ');
            $getCodeColors->execute(array(':activ' => $activColor));
            $getCodeColors = $getCodeColors->fetchAll();

            $userData = null;
            $user = new User();
            if ($user->isAuth()) {
                $userData = $user->getProfile();
            }

            $content = $this->view->renderPartial("pay/form", [
                'CodeColors' => $getCodeColors,
                'serverInfo' => $getInfoServerRow,
                'PayMethods' => $getPayMethods,
                'type' => $getInfoServices['type'] ?? null,
                'top' => $top,
                'infoServices' => $getInfoServices,
                'user' => $userData,
                'idServices' => $id_services
            ]);
            echo $content;

        } //else parent::ShowError(404, "Страница не найдена!");
    }


    /**
     * Возвращает платежную форму
     * @return void
     * @throws \Exception
     */
    public function getPayForm($id)
    {

        $postData = parent::readPostJson();
        $paymentMethod = (int)$postData['payment_method'];
        $idServices = (int)$postData['id_services'];

        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $id));
        $getInfoServer = $getInfoServer->fetch();

        if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");


        $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
        $getInfoServices->execute(array(':id' => $idServices));
        $getInfoServices = $getInfoServices->fetch();
        if (empty($getInfoServices))  parent::ShowError(400, "Services not found!");


        $getInfoPayment = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
        $getInfoPayment->execute(array(':id' => $paymentMethod));
        $getInfoPayment = $getInfoPayment->fetch();
        if (empty($getInfoPayment)) parent::ShowError(400, "PayMethod not found!");

        $params = [];

        //create invoice
        $user = new User();
        if ($user->isAuth()) {
            $userProfile = $user->getProfile();
            $params['user_id'] = $userProfile['id'];
        }

        $services = new Services();






        if (isset($postData['color'])) $params['color'] = htmlspecialchars($postData['color']);
        if (isset($postData['place'])) $params['place'] = htmlspecialchars($postData['place']);


        try {
            $invoiceId = $services->validate(
                $getInfoServices,
                $getInfoServer,
                $params
            );

        }catch (\Exception $e){
            $answer['status'] = "error";
            $answer['error'] = $e->getMessage();
            exit(json_encode($answer));
        }




        $getInfoPayment = $this->db->prepare('SELECT id, content, typeCode FROM ga_pay_methods WHERE id = :id');
        $getInfoPayment->execute(array(':id' => $paymentMethod));
        $getInfoPayment = $getInfoPayment->fetch();
        $infoPaymentSettings = Json::decode($getInfoPayment['content'], true);


        if ($infoPaymentSettings === null){
            $answer['status'] = "error";
            $answer['error'] = "Настройка способа оплаты не завершена. Обратитесь, пожалуйста, к системному администратору.";
            exit(json_encode($answer));
        }


        $amount = $getInfoServices['price'];


        $description = "Оплата услуги №" . $invoiceId;
        $htmlForm = null;
        $paymentUrl = null;
        switch ($getInfoPayment['typeCode']) {
            case "freekassa":
                $merchant_id = $infoPaymentSettings['fk_id'];
                $secret_word = $infoPaymentSettings['fk_key1'];
                $order_id = $invoiceId;
                $order_amount = $amount;
                $currency = 'RUB';

                $sign = md5($merchant_id.':'.$order_amount.':'.$secret_word.':'.$currency.':'.$order_id);


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
                    if ($infoPaymentSettings['shop_id'] === null or empty($infoPaymentSettings['shop_id'])){
                        $answer['status'] = "error";
                        $answer['error'] = "Настройка способа оплаты не завершена. Обратитесь, пожалуйста, к системному администратору.";
                        exit(json_encode($answer));
                    }

                    $client = new YooKassaClient(
                        $infoPaymentSettings['shop_id'],
                        $infoPaymentSettings['secret_key']
                    );

                    /** @var array{guid: string, url: string} $resp */
                    $resp = $client->createPayment(
                        $amount,
                        $description,
                        $invoiceId
                    );

                    $sql = "UPDATE ga_pay_logs SET bill_id = :bill_id WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':bill_id', $resp['guid'], );
                    $update->bindParam(':id', $invoiceId);
                    $update->execute();


                    $paymentUrl = $resp['url'];
                }catch (\Exception $e){
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
                }catch (\Exception $e){
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


    /**
     * Логика оплаты с лицевого счета
     * @return void
     * @throws \Exception
     */
    public function ajax($id)
    {
        $user = new User();
        if (!$user->isAuth()) {
            $answer['status'] = "error";
            $answer['error'] = "Требуется авторизация";
            exit(json_encode($answer));
        }

        $userProfile = $user->getProfile();
        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $id));
        $getInfoServer = $getInfoServer->fetch();

        if (empty($getInfoServer)) parent::ShowError(404, "Сервер не найден!");


        if (parent::isAjax()) {

            $idServices = (int)$_POST['id_services'];

            $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
            $getInfoServices->execute(array(':id' => $idServices));
            $getInfoServices = $getInfoServices->fetch();
            if (empty($getInfoServices)) {
                $answer['status'] = "error";
                $answer['error'] = "Услуга не найдена";
                exit(json_encode($answer));
            }


            $services = new Services();




            if ($userProfile['balance'] >= $getInfoServices['price']) {
                if ($getInfoServer['ban'] == 1 and $getInfoServices['type'] != 'razz') {
                    $answer['status'] = "error";
                    $answer['error'] = "Сервер в бане";
                    exit(json_encode($answer));
                }

                $params = [];
                $params['user_id'] = $userProfile['id'];

                if (isset($_POST['color']) && !empty(trim($_POST['color']))) {
                    $params['color'] = htmlspecialchars($_POST['color']);
                } else {
                    $params['color'] = null;
                }

                if (isset($_POST['place']) && !empty(trim($_POST['place']))) {
                    $params['place'] = htmlspecialchars($_POST['place']);
                } else {
                    $params['place'] = null;
                }

                // validate services
                try {
                    $invoiceId = $services->validate(
                        $getInfoServices,
                        $getInfoServer,
                        $params
                    );

                }catch (\Exception $e){
                    $answer['status'] = "error";
                    $answer['error'] = $e->getMessage();
                    exit(json_encode($answer));
                }



                $services->processing(['inv_id' => $invoiceId, 'price' => $getInfoServices['price'], 'pay_methods' => "bill"]);

                $newBalance = $userProfile['balance'] - $getInfoServices['price'];
                $sql = "UPDATE ga_users SET balance = :balance  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':balance', $newBalance, PDO::PARAM_INT);
                $update->bindParam(':id', $userProfile['id'], PDO::PARAM_INT);
                $update->execute();

                $address = $getInfoServer['ip'] . ':' . $getInfoServer['port'];

                $answer['status'] = "success";
                $answer['redirect_href'] = "/server/${address}/info";
                $answer['success'] = "Услуга успешно куплена. Вы будете перенаправлены через 3 сек.";
                exit(json_encode($answer));
            } else {
                $answer['status'] = "error";
                $answer['error'] = "Недостаточно средств на счете";
                exit(json_encode($answer));
            }

        }

        parent::ShowError(404, "Page not found!");

    }

}
    
