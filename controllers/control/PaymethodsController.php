<?php

namespace controllers\control;

use components\System;


class PaymethodsController extends AbstractController
{

    public function index()
    {
        $title = "Способы оплат";

        $getPayMethods = $this->db->query('SELECT * FROM ga_pay_methods WHERE status ="1"');
        $payMethods = $getPayMethods->fetchAll();


        $content = $this->view->renderPartial("paymethods/index", ['paymethods' => $payMethods]);
        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

    public function add()
    {
        $title = "Добавление платежной системы";

        if (parent::isAjax()) {

            $status = $_POST['status'];
            $type = (int)$_POST['type'];

            $params = '';
            $servicesParams = $_POST['servicesParams'];
            if (!empty($servicesParams)) {
                $colors = explode("\n", $servicesParams);
                $params = json_encode($colors);
            }

            $sql = "UPDATE ga_pay_methods SET status = :status, content = :content  WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':status', $status);
            $update->bindParam(':content', $params);
            $update->bindParam(':id', $type);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Платежная система успешно добавлена";
            exit(json_encode($answer));

        } else {

            $getPayMethods = $this->db->query('SELECT * FROM ga_pay_methods WHERE status = "0"');
            $getPayMethods = $getPayMethods->fetchAll();

            $content = $this->view->renderPartial("paymethods/add", ['PayMethods' => $getPayMethods]);
            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }

    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $status = 0;
            $sql = "UPDATE ga_pay_methods SET status = :status WHERE id = :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':status', $status);
            $update->bindParam(':id', $id);
            $update->execute();
        }
    }


    public function edit()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Настройка кассы";

        $getInfoPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE id = :id');
        $getInfoPayMethods->execute(array(':id' => $id));
        $getInfoPayMethods = $getInfoPayMethods->fetch();
        if (empty($getInfoPayMethods)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {

            $status = (int)$_POST['status'];
            if ($getInfoPayMethods['typeCode'] == 'freekassa') {
                $content = json_encode(['fk_id' => $_POST['fk_id'], 'fk_key1' => $_POST['fk_key1'], 'fk_key2' => $_POST['fk_key2']]);
            } elseif ($getInfoPayMethods['typeCode'] == 'yoomoney') {
                $content = json_encode(['receiver' => $_POST['receiver'], 'secret_key' => $_POST['secret_key']]);
            }elseif ($getInfoPayMethods['typeCode'] == 'yookassa') {
                $content = json_encode(['shop_id' => $_POST['shop_id'], 'secret_key' => $_POST['secret_key']]);
            }elseif ($getInfoPayMethods['typeCode'] == 'lava') {
                $content = json_encode(['shop_id' => $_POST['shop_id'], 'secret_key' => $_POST['secret_key']]);
            }

            $sql = "UPDATE ga_pay_methods SET status = :status, content = :content WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':status', $status);
            $update->bindParam(':content', $content);
            $update->bindParam(':id', $id);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Настройки успешно изменены";
            exit(json_encode($answer));

        } else {

            $system = new System();
            $url = $system->getUrl();
            $params = json_decode($getInfoPayMethods['content'], true);
            $content = $this->view->renderPartial("paymethods/edit", ['data' => $getInfoPayMethods, 'params' => $params, 'url' => $url]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }

}