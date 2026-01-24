<?php

namespace controllers;

use core\BaseController;
use components\System;
use PDO;

class ApiController extends BaseController
{
    public function index()
    {
        $spQueryFields = array('login', 'sv', 'services', 'key', 'game');
        foreach ($spQueryFields as $spFieldName) {
            if (!isset($_REQUEST[$spFieldName])) {
                exit($this->response(['status' => "error", 'code' => "no_params", 'message' => 'There is no parameter in the data request ' . $spFieldName]));
            }
        }

        $key = $_REQUEST['key'];
        $login = $_REQUEST['login'];

        $sv = $_REQUEST['sv'];
        $id_services = $_REQUEST['services'];
        $game = $_REQUEST['game'];

        $getInfoPartner = $this->db->prepare('SELECT * FROM ga_users WHERE api_login = :api_login');
        $getInfoPartner->execute(array(':api_login' => $login));
        $getInfoPartner = $getInfoPartner->fetch();
        $params = json_decode($getInfoPartner['params'], true);

        if (empty($getInfoPartner) or $getInfoPartner['role'] != 'partner') exit($this->response(['status' => "error", 'code' => "no_partner", 'message' => 'You are not a partner']));

        if ($params['key_api'] != $key) exit($this->response(['status' => "error", 'code' => "no_valid_key", 'message' => 'Invalid access key']));

        $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
        $getInfoServices->execute(array(':id' => $id_services));
        $getInfoServices = $getInfoServices->fetch();
        if (empty($getInfoServices)) exit($this->response(['status' => "error", 'code' => "no_service", 'message' => 'Service not found']));

        $priceSale = $getInfoServices['price'] * $params['discount_api'] / 100;
        $RealPrice = $getInfoServices['price'] - $priceSale;
        if ($getInfoPartner['balance'] >= $RealPrice) {

            $newBalance = $getInfoPartner['balance'] - $getInfoServices['price'];
            $sql = "UPDATE ga_users SET balance = :balance  WHERE id = :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':balance', $newBalance, PDO::PARAM_INT);
            $update->bindParam(':id', $getInfoPartner['id'], PDO::PARAM_INT);
            $update->execute();

            $this->buy(['id_user' => $getInfoPartner['id'], 'id_services' => $id_services, 'sv' => $sv, 'game' => $game, 'price' => $RealPrice]);
        } else exit($this->response(['status' => "error", 'code' => "no_money", 'message' => 'Not enough money']));

    }


    private function buy($data)
    {

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);


        if (isset($data['sv'])) $query = $data['sv'];
        $query = explode(":", $query);
        if (!isset($query[1])) $query[1] = null;

        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
        $getInfoServer->bindValue(":ip", $query[0]);
        $getInfoServer->bindValue(":port", $query[1]);
        $getInfoServer->execute();
        $getInfoServer = $getInfoServer->fetch();

        if (!empty($getInfoServer)) {
            if ($getInfoServer['ban'] == '1') {
                exit($this->response(['status' => "error", 'code' => "server_is_banned", 'message' => 'Server is banned']));
            }
            $id_server = $getInfoServer['id'];
        } else {

            $country = null;

            $status = "0";

            $this->db->exec("INSERT INTO ga_servers (status, game, ip, port, date_add, country, moderation) 
            VALUES('$status', '" . $data['game'] . "', '$query[0]', '$query[1]', '" . time() . "', '$country', '1')");
            $id_server = $this->db->lastInsertId();

            $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
            $getInfoServer->bindValue(":id", $id_server);
            $getInfoServer->execute();
            $getInfoServer = $getInfoServer->fetch();


        }

        $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
        $getInfoServices->execute(array(':id' => $data['id_services']));
        $getInfoServices = $getInfoServices->fetch();


        switch ($getInfoServices['type']) {

            case "boost":
                if ($getInfoServer['boost'] !== null) {
                    $sql = "UPDATE ga_servers SET boost = boost + 1 WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->execute([':id' => $id_server]);

                } else {
                    $countBoostServers = $this->db->query("SELECT COUNT(*) FROM ga_servers WHERE boost IS NOT NULL")->fetchColumn();
                    $getBoostServers = $this->db->query(
                        "SELECT id, boost FROM ga_servers WHERE boost IS NOT NULL ORDER BY boost_position ASC")->fetchAll(PDO::FETCH_ASSOC);

                    // Если лимит достигнут
                    if ($countBoostServers >= $settings['global_settings']['count_servers_boost']) {
                        foreach ($getBoostServers as $row) {
                            if ($row['boost'] <= 1) {
                                // Убираем boost
                                $sql = "UPDATE ga_servers SET boost = NULL, boost_position = NULL WHERE id = :id";
                                $update = $this->db->prepare($sql);
                                $update->execute([':id' => $row['id']]);
                                break;

                            } else {
                                $sql = "UPDATE ga_servers SET boost = boost - 1, boost_position = :pos WHERE id = :id";
                                $update = $this->db->prepare($sql);
                                $update->execute([
                                    ':pos' => time() + 1,
                                    ':id'  => $row['id']
                                ]);
                            }
                        }
                    }

                    // Назначаем boost текущему серверу
                    $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :pos WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->execute([
                        ':boost' => $getInfoServices['period'],
                        ':pos'   => time(),
                        ':id'    => $id_server
                    ]);
                }

                break;


        }

        $content = json_encode(['id_services' => $data['id_services'], 'id_user' => $data['id_user'], 'type_pay' => "payApi", 'price' => $data['price'], 'type' => 'boost', 'id_server' => $id_server]);

        $this->db->exec("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES('$content','" . time() . "', 'paid', " . $data['id_user'] . ", 'bill')");

        exit($this->response(['status' => "success", 'code' => "purchased", 'message' => 'Server successfully added']));
    }

    private function response($data)
    {
        return json_encode($data);
    }


    public function ping()
    {
        $serverName = $_SERVER['SERVER_NAME'];

        exit($this->response(['status' => "success", 'code' => "ping", 'server_name' => $serverName, 'version' => VERSION]));

    }

}
