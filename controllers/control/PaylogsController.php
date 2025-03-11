<?php

namespace controllers\control;

use components\Pagination;
use components\User;
use PDO;


class PaylogsController extends AbstractController
{

    public function index()
    {
        $title = "История платежей";

        $countServers = $this->db->query('SELECT * FROM ga_pay_logs');
        $count = $countServers->rowCount();

        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));

        $newArr = [];
        $getPaylogs = $this->db->query('SELECT * FROM ga_pay_logs ORDER BY date_create DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getPaylogs = $getPaylogs->fetchAll();
        foreach ($getPaylogs as $row) {
            $content = json_decode($row['content'], true);
            if ($content['type_pay'] == 'refill') {
                $id = $content['id_user'];
                $servicesName = "Пополнение счета";
                $price = $content['amount'] ?? 0;
            } elseif ($content['type_pay'] == "payServices" or $content['type_pay'] == 'payApi') {
                if ($content['type_pay'] == 'payApi') $payApi = "[API]"; else $payApi = '';
                $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
                $getInfoServices->execute(array(':id' => $content['id_services']));
                $getInfoServices = $getInfoServices->fetch();
                if (!empty($getInfoServices)) {
                    $servicesName = $payApi . $getInfoServices['name'];
                } else {
                    $servicesName = 'Услуга не найдена';

                }
                $id = $content['id_server'];
                $price = $content['price'];
            }
            if ($row['pay_methods'] == 'bill') {
                $payMethods = "Внутренней счет";
            } else {
                $payMethods = $row['pay_methods'];
            }

            $newArr[] = ['id' => $row['id'], 'payMethods' => $payMethods, 'id_user' => $row['id_user'], 'type_pay' => $content['type_pay'], 'price' => $price, 'id_object' => $id, 'servicesName' => $servicesName, 'date_create' => $row['date_create'], 'status' => $row['status']];

        }
        $status = 1;
        $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
        $getPayMethods->execute(array(':status' => $status));
        $getPayMethods = $getPayMethods->fetchAll();


        $pagination_html = $result['ViewPagination'];

        $userPay = '';
        $content = $this->view->renderPartial("paylogs/index", ['userPay' => $userPay,
            'data' => $newArr,
            'PayMethods' => $getPayMethods,
            'methodPay' => '',
            'statusPay' => '',
            'typePay' => '',
            'pagination_html' => $pagination_html,
            'filter' => null
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }


    public function search()
    {
        $title = "Логи платежей";

        $filter = [];
        $sql = '';

        if (isset($_GET['typePay']) && !empty($_GET['typePay'])) {
            $typePay = strip_tags($_GET['typePay']);
            $sql .= "WHERE content LIKE ('%type_pay\":\"" . $typePay . "%')";
        } else {
            $typePay = '';
        }


        if (isset($_GET['statusPay']) && !empty($_GET['statusPay'])) {
            $statusPay = strip_tags($_GET['statusPay']);
            if (stristr($sql, "WHERE") == false) {
                $sql .= "WHERE status = '$statusPay'";
            } else $sql .= " AND status = '$statusPay'";

        } else {
            $statusPay = '';
        }


        if (isset($_GET['methodPay']) && !empty($_GET['methodPay'])) {
            $methodPay = strip_tags($_GET['methodPay']);
            if (stristr($sql, "WHERE") == false) {
                $sql .= "WHERE pay_methods = '$methodPay'";
            } else $sql .= " AND pay_methods = '$methodPay'";

        } else {
            $methodPay = '';
        }

        if (isset($_GET['userPay']) && !empty($_GET['userPay'])) {
            $userPay = strip_tags($_GET['userPay']);
            $user = new User();
            $getInfoUser = $user->getProfileBy("email", $userPay);

            if (stristr($sql, "WHERE") == false) {
                $sql .= "WHERE content LIKE ('%id_user\":\"" . $getInfoUser['id'] . "%')";
            } else $sql .= " AND content LIKE ('%id_user\":\"" . $getInfoUser['id'] . "%')";

        } else {
            $userPay = '';
        }


        if (isset($_GET['dateStart']) && $_GET['dateStart'] != '') {
            $queryDate['dateStart'] = strtotime($_GET['dateStart']);
            $filter['dateStart'] = strip_tags($_GET['dateStart']);
        } else {
            $filter['dateStart'] = '';
            $queryDate['dateStart'] = strtotime("1970-01-01");
        }

        if (isset($_GET['dateEnd']) && $_GET['dateEnd'] != '') {
            $queryDate['dateEnd'] = strtotime($_GET['dateEnd']) + 48 * 3600;
            $queryDate['dateEnd'] = $queryDate['dateEnd'];
            $filter['dateEnd'] = strip_tags($_GET['dateEnd']);
        } else {
            $filter['dateEnd'] = date("Y-m-d");
            $queryDate['dateEnd'] = strtotime(date("Y-m-d"));
        }

        if (isset($_GET['dateStart']) or isset($_GET['dateEnd'])) {
            if (stristr($sql, "WHERE") == false) {
                $sql .= "WHERE `date_create` BETWEEN '" . $queryDate['dateStart'] . "' and '" . $queryDate['dateEnd'] . "'";
            } else {
                $sql .= " AND `date_create` BETWEEN '" . $queryDate['dateStart'] . "' and '" . $queryDate['dateEnd'] . "'";
            }
        }

        $countServers = $this->db->query("SELECT * FROM ga_pay_logs $sql");
        $count = $countServers->rowCount();

        //echo $sql;
        $pagination = new Pagination();
        $per_page = 5;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count, 'no_rgp' => ''));


        $newArr = [];
        $getPaylogs = $this->db->query("SELECT * FROM ga_pay_logs $sql ORDER BY `date_create` DESC LIMIT " . $result['start'] . ", " . $per_page . "");
        $getPaylogs = $getPaylogs->fetchAll();
        foreach ($getPaylogs as $row) {
            $content = json_decode($row['content'], true);
            if ($content['type_pay'] == 'refill') {
                $id = $content['id_user'];
                $servicesName = "Пополнение счета";
                $price = $content['amount'] ?? 0;
            } elseif ($content['type_pay'] == "payServices" or $content['type_pay'] == 'payApi') {
                if ($content['type_pay'] == 'payApi') $payApi = "[API]"; else $payApi = '';
                $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
                $getInfoServices->execute(array(':id' => $content['id_services']));
                $getInfoServices = $getInfoServices->fetch();
                if (!empty($getInfoServices)) {
                    $servicesName = $payApi . $getInfoServices['name'];
                } else {
                    $servicesName = 'Услуга не найдена';

                }
                $id = $content['id_server'];
                $price = $content['price'];
            }
            if ($row['pay_methods'] == 'bill') {
                $payMethods = "Внутренней счет";
            } else {
                $payMethods = $row['pay_methods'];
            }

            $newArr[] = ['id' => $row['id'], 'payMethods' => $payMethods, 'id_user' => $row['id_user'], 'type_pay' => $content['type_pay'], 'price' => $price, 'id_object' => $id, 'servicesName' => $servicesName, 'date_create' => $row['date_create'], 'status' => $row['status']];

        }

        $status = 1;
        $getPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE status = :status');
        $getPayMethods->execute(array(':status' => $status));
        $getPayMethods = $getPayMethods->fetchAll();


        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("paylogs/index", [
            'filter' => $filter,
            'userPay' => $userPay,
            'methodPay' => $methodPay,
            'PayMethods' => $getPayMethods,
            'statusPay' => $statusPay,
            'typePay' => $typePay,
            'data' => $newArr,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


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
