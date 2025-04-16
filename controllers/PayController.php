<?php

namespace controllers;

use components\Flash;
use components\Json;
use components\pay_method\FreekassaClient;
use components\pay_method\LavaClient;
use components\pay_method\YooKassaClient;
use components\pay_method\YooKassaService;
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
        $title = "Платные услуги";

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


        //create invoice
        $user = new User();
        $userProfile = null;
        if ($user->isAuth()) {
            $userProfile = $user->getProfile();
        }

        $services = new Services();
        $invoiceId = $services->createInvoice(
            $getInfoServices,
            $getInfoServer,
            $idServices,
            $userProfile
        );


        $getInfoPayment = $this->db->prepare('SELECT id, content, typeCode FROM ga_pay_methods WHERE id = :id');
        $getInfoPayment->execute(array(':id' => $paymentMethod));
        $getInfoPayment = $getInfoPayment->fetch();
        $infoPaymentSettings = Json::decode($getInfoPayment['content'], true);

        $amount = $getInfoServices['price'];


        $description = "Оплата услуги №" . $invoiceId;
        $htmlForm = null;
        $paymentUrl = null;
        switch ($getInfoPayment['typeCode']) {
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
                    $update->bindParam(':id', $payId);
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
        $userProfile = null;
        if ($user->isAuth()) {
            $userProfile = $user->getProfile();
        }


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


            if ($userProfile['balance'] >= $getInfoServices['price']) {
                if ($getInfoServer['ban'] == 1 and $getInfoServices['type'] != 'razz') {
                    $answer['status'] = "error";
                    $answer['error'] = "Сервер в бане";
                    exit(json_encode($answer));
                }


                $services = new Services();

                $invoiceId = $services->createInvoice(
                    $getInfoServices,
                    $getInfoServer,
                    $idServices,
                    $userProfile
                );

                $services->processing(['inv_id' => $invoiceId, 'price' => $getInfoServices['price'], 'pay_methods' => "bill"]);

                $newBalance = $userProfile['balance'] - $getInfoServices['price'];
                $sql = "UPDATE ga_users SET balance = :balance  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':balance', $newBalance, PDO::PARAM_INT);
                $update->bindParam(':id', $user_profile['id'], PDO::PARAM_INT);
                $update->execute();

                $answer['status'] = "success";
                $answer['success'] = "Услуга успешно куплена";
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
    
