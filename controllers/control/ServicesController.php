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

        $getCounts = $this->db->query('SELECT id_service, COUNT(*) AS cnt FROM ga_services_periods GROUP BY id_service');
        $counts = [];
        foreach ($getCounts->fetchAll() as $row) {
            $counts[$row['id_service']] = (int)$row['cnt'];
        }

        foreach ($getServices as &$service) {
            $service['periods_count'] = $counts[$service['id']] ?? 0;
        }
        unset($service);

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
            if ($servicesType != 'razz') $servicesPeriod = (int)$_POST['servicesPeriod'];


            $servicesPrice = (int)$_POST['servicesPrice'];
            $text = strip_tags($_POST['text']);

            $stmt = $this->db->prepare(
                "INSERT INTO ga_services (name, type, period, price, params, text) VALUES (:name, :type, :period, :price, '', :text)"
            );
            $stmt->execute([
                ':name' => $servicesName,
                ':type' => $servicesType,
                ':period' => $servicesPeriod,
                ':price' => $servicesPrice,
                ':text' => $text,
            ]);

            $idService = (int)$this->db->lastInsertId();

            if ($servicesType != 'razz') {
                $this->savePeriods($idService, $_POST['periodsData'] ?? '[]');
            }

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
            $servicesPeriod = 0;
            if ($getInfoServices['type'] != 'razz') $servicesPeriod = (int)$_POST['servicesPeriod'];


            $servicesPrice = (int)$_POST['servicesPrice'];
            $text = strip_tags($_POST['text']);

            $sql = "UPDATE ga_services SET name = :name, period = :period, price = :price, text = :text WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':name', $servicesName);
            $update->bindParam(':period', $servicesPeriod);
            $update->bindParam(':price', $servicesPrice);
            $update->bindParam(':text', $text);
            $update->bindParam(':id', $id);
            $update->execute();

            if ($getInfoServices['type'] != 'razz') {
                $this->savePeriods($id, $_POST['periodsData'] ?? '[]');
            }

            $answer['status'] = "success";
            $answer['success'] = "Услуга успешно изменена";
            exit(json_encode($answer));

        } else {

            $getPeriods = $this->db->prepare('SELECT id, period, price FROM ga_services_periods WHERE id_service = :id_service ORDER BY sort ASC, period ASC');
            $getPeriods->execute([':id_service' => $id]);
            $periods = $getPeriods->fetchAll();

            $content = $this->view->renderPartial("services/edit", ['data' => $getInfoServices, 'periods' => $periods]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

            $stmt = $this->db->prepare("DELETE FROM ga_services_periods WHERE id_service = :id");
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

            $sql = "DELETE FROM ga_services WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }
    }

    /**
     * Replaces a service's pricing tiers with the submitted set.
     * $periodsJson is a JSON array of {period, price} objects (from the admin form's
     * hidden field). Invalid/incomplete rows are silently skipped.
     */
    private function savePeriods(int $idService, string $periodsJson): void
    {
        $rows = json_decode($periodsJson, true);
        if (!is_array($rows)) $rows = [];

        $delete = $this->db->prepare("DELETE FROM ga_services_periods WHERE id_service = :id_service");
        $delete->execute([':id_service' => $idService]);

        $insert = $this->db->prepare(
            "INSERT INTO ga_services_periods (id_service, period, price, sort) VALUES (:id_service, :period, :price, :sort)"
        );

        $sort = 0;
        foreach ($rows as $row) {
            $period = (int)($row['period'] ?? 0);
            $price = (int)($row['price'] ?? 0);
            if ($period <= 0 || $price <= 0) continue;

            $insert->execute([
                ':id_service' => $idService,
                ':period' => $period,
                ':price' => $price,
                ':sort' => $sort++,
            ]);
        }
    }

}
