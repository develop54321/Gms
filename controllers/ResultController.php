<?php

namespace controllers;

use components\Services;
use components\User;
use core\BaseController;

class ResultController extends BaseController
{


    public function index()
    {
        $services = new Services();
        $user = new User();

        if (isset($_GET['type'])) $type = $_GET['type']; else parent::ShowError(404, "Страница не найдена");


        try {
            switch ($type) {

                case "freekassa":
                    $fk_id = addslashes($_REQUEST["MERCHANT_ID"]);
                    $out_summ = addslashes($_REQUEST["AMOUNT"]);
                    $InvId = addslashes($_REQUEST["MERCHANT_ORDER_ID"]);
                    $crc = $_REQUEST["SIGN"];

                    $typeCode = 'freekassa';
                    $getInfoPayment = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
                    $getInfoPayment->execute(array(':typeCode' => $typeCode));
                    $getInfoPayment = $getInfoPayment->fetch();
                    $getInfoPayment = json_decode($getInfoPayment['content'], true);

                    $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
                    $getInfoPay->execute(array(':id' => $InvId));
                    $getInfoPay = $getInfoPay->fetch();
                    $getInfoPay = json_decode($getInfoPay['content'], true);

                    $my_crc = md5($fk_id . ':' . $out_summ . ':' . $getInfoPayment['fk_key2'] . ':' . $InvId);
                    if (strtoupper($my_crc) != strtoupper($crc)) {
                        exit("bad sign");
                    }

                    if ($getInfoPay['type_pay'] == 'refill') {
                        $user->refill(['inv_id' => $InvId, 'amount' => $out_summ]);
                    } else {
                        $services->processing(['inv_id' => $InvId, 'price' => $out_summ, 'pay_methods' => $typeCode]);
                    }
                    echo "OK$InvId\n";


                    break;

                case "yoomoney":

                    $typeCode = 'yoomoney';
                    $getInfoPayment = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
                    $getInfoPayment->execute(array(':typeCode' => $typeCode));
                    $getInfoPayment = $getInfoPayment->fetch();
                    $getInfoPayment = json_decode($getInfoPayment['content'], true);


                    $sha1 = sha1($_POST['notification_type'] . '&' . $_POST['operation_id'] . '&' . $_POST['amount'] . '&643&' . $_POST['datetime'] . '&' . $_POST['sender'] . '&' . $_POST['codepro'] . '&' . $getInfoPayment['secret_key'] . '&' . $_POST['label']);

                    if ($sha1 != $_POST['sha1_hash']) {
                        exit("bad hash");
                    }

                    $amount = $_POST['withdraw_amount'];
                    $InvId = $_POST['label'];
 
                    $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
                    $getInfoPay->execute(array(':id' => $InvId));
                    $getInfoPay = $getInfoPay->fetch();
                    $getInfoPay = json_decode($getInfoPay['content'], true);

                    if ($getInfoPay['type_pay'] == 'refill') {
                        $user->refill(['inv_id' => $InvId, 'amount' => $amount]);
                    } else {
                        $services->processing(['inv_id' => $InvId, 'price' => $amount, 'pay_methods' => $typeCode]);
                    }

                    exit("ok");

                    break;

                default:
                    parent::ShowError(400, "Bad request");
                    break;


            }
        } catch (\Exception $exception) {
            throw new \Exception($exception);
        }
    }

    public function success()
    {
        $title = "Оплата успешно прошла";
        $content = $this->view->renderPartial("pay/success");

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

    public function fail()
    {
        $title = "Ошибка платежа";
        $content = $this->view->renderPartial("pay/fail");

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
}