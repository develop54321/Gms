<?php

namespace controllers\control;

use components\Pagination;
use components\User;
use core\BaseController;
use PDO;


class LogsController extends AbstractController
{

    public function index()
    {
        $title = "Логи системные";

        $countServers = $this->db->query('SELECT * FROM ga_pay_logs');
        $count = $countServers->rowCount();

        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));


        $getLogs = $this->db->query('SELECT * FROM ga_system_logs ORDER BY date_create DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getLogs = $getLogs->fetchAll();


        $userPay = '';
        $content = $this->view->renderPartial("logs/index", ['userPay' => $userPay, 'data' => $getLogs, 'ViewPagination' => $result['ViewPagination']]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_system_logs WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }
    }

}
