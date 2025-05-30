<?php

namespace controllers\control;

use PDO;


class ServicesController extends AbstractController
{

    public function index()
    {
        $title = "Услуги";

        $getServices = $this->db->query('SELECT * FROM ga_services');
        $getServices = $getServices->fetchAll();

        $content = $this->view->renderPartial("services/index", ['services' => $getServices]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }

    public function add()
    {

        $title = "Добавление новой услуги";

        if (parent::isAjax()) {

            $servicesName = strip_tags($_POST['servicesName']);
            $servicesType = strip_tags($_POST['servicesType']);
            $servicesPeriod = 0;
            if ($servicesType != 'razz') $servicesPeriod = strip_tags($_POST['servicesPeriod']);


            $servicesPrice = strip_tags($_POST['servicesPrice']);
            $text = strip_tags($_POST['text']);

            $this->db->exec("INSERT INTO ga_services (name, type, period, price, params, text) 
            VALUES('$servicesName', '$servicesType', '$servicesPeriod','$servicesPrice', '', '$text')");

            $answer['status'] = "success";
            $answer['success'] = "Услуга успешно добавлена";
            exit(json_encode($answer));

        } else {

            $content = $this->view->renderPartial("services/add", []);

            $this->view->render("main", ['content' => $content, 'title' => $title]);
        }

    }


    public function edit()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Изменение услуги #$id";

        $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
        $getInfoServices->execute(array(':id' => $id));
        $getInfoServices = $getInfoServices->fetch();
        if (empty($getInfoServices)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {

            $servicesName = strip_tags($_POST['servicesName']);
            $servicesType = '';
            $servicesPeriod = 0;
            if ($servicesType != 'razz') $servicesPeriod = strip_tags($_POST['servicesPeriod']);


            $servicesPrice = strip_tags($_POST['servicesPrice']);
            $text = strip_tags($_POST['text']);

            $sql = "UPDATE ga_services SET name = :name, period = :period, price = :price, text = :text WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':name', $servicesName);
            $update->bindParam(':period', $servicesPeriod);
            $update->bindParam(':price', $servicesPrice);
            $update->bindParam(':text', $text);
            $update->bindParam(':id', $id);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Услуга успешно изменена";
            exit(json_encode($answer));

        } else {


            $content = $this->view->renderPartial("services/edit", ['data' => $getInfoServices]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_services WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }
    }

}
