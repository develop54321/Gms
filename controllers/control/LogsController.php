<?php

namespace controllers\control;

use components\Pagination;
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


        $pagination_html = $result['ViewPagination'];


        $userPay = '';
        $content = $this->view->renderPartial("logs/index", [
            'userPay' => $userPay,
            'data' => $getLogs,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }

    public function clear(){
        $sql = "TRUNCATE TABLE ga_system_logs";
        $this->db->exec($sql);

        return header("Location: /control/logs");
    }

}
