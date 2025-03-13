<?php

namespace components;

use core\BaseController;
use PDO;

class Services extends BaseController
{

    public function processing($data): bool
    {

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $getInfoPay->execute(array(':id' => $data['inv_id']));
        $getInfoPay = $getInfoPay->fetch();

        if (empty($getInfoPay)) parent::ShowError(404, "Страница не найдена!");
        $getInfoPay = json_decode($getInfoPay['content'], true);

        if ($getInfoPay['price'] != $data['price']) parent::ShowError(404, "Страница не найдена!");


        $getInfoServices = $this->db->prepare('SELECT * FROM ga_services WHERE id = :id');
        $getInfoServices->execute(array(':id' => $getInfoPay['id_services']));
        $getInfoServices = $getInfoServices->fetch();

        $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServer->execute(array(':id' => $getInfoPay['id_server']));
        $getInfoServer = $getInfoServer->fetch();

        switch ($getInfoPay['type']) {
            //	Top
            case "top":
                if ($getInfoServer['top_enabled'] != '0') {
                    $place = $getInfoServer['top_enabled'];
                    $expired_time = ($getInfoServices['period'] * 86400) + $getInfoServer['top_expired_date'];
                } else {
                    $expired_time = time() + $getInfoServices['period'] * 86400;
                    $place = $getInfoPay['place'];
                }
                $sql = "UPDATE ga_servers SET top_enabled = :top_enabled, top_expired_date = :top_expired_date  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':top_enabled', $place, PDO::PARAM_INT);
                $update->bindParam(':top_expired_date', $expired_time);
                $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);
                $update->execute();
                break;

            //	Vip
            case "vip":
                if ($getInfoServer['vip_enabled'] != '0') {
                    $expired_time = $getInfoServer['vip_expired_date'] + ($getInfoServices['period'] * 86400);
                } else {
                    $expired_time = time() + $getInfoServices['period'] * 86400;
                }
                $vip = 1;
                $sql = "UPDATE ga_servers SET vip_enabled = :vip_enabled, vip_expired_date = :vip_expired_date  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':vip_enabled', $vip, PDO::PARAM_INT);
                $update->bindParam(':vip_expired_date', $expired_time, PDO::PARAM_INT);
                $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);
                $update->execute();
                break;

            //	Color
            case "color":
                if ($getInfoServer['color_enabled'] != '0') {
                    $expired_time = $getInfoServer['color_expired_date'] + ($getInfoServices['period'] * 86400);
                } else {
                    $expired_time = time() + $getInfoServices['period'] * 86400;
                }
                $sql = "UPDATE ga_servers SET color_enabled = :color_enabled, color_expired_date = :color_expired_date  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':color_enabled', $getInfoPay['color']);
                $update->bindParam(':color_expired_date', $expired_time, PDO::PARAM_INT);
                $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);
                $update->execute();
                break;

            //	Boost
            case "boost":
                if ($getInfoServer['boost'] != '0') {
                    $this->db->query("UPDATE ga_servers SET boost = boost + " . $getInfoServices['period'] . " WHERE id = '" . $getInfoPay['id_server'] . "'");
                } else {
                    $countBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost');
                    $countBoostServers->execute(array(':boost' => 0));
                    $countBoostServers = $countBoostServers->rowCount();

                    $getBoostServers = $this->db->prepare('SELECT id, hostname, boost FROM ga_servers WHERE boost != :boost ORDER BY boost_position ASC');
                    $getBoostServers->execute(array(':boost' => 0));
                    $getBoostServers = $getBoostServers->fetchAll();

                    if ($countBoostServers == $settings['global_settings']['count_servers_boost']) {
                        foreach ($getBoostServers as $row) {
                            if ($row['boost'] == '1') {
                                $zero = 0;
                                $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
                                $update = $this->db->prepare($sql);
                                $update->bindParam(':boost', $zero);
                                $update->bindParam(':boost_position', $zero);
                                $update->bindParam(':id', $row['id']);
                                $update->execute();
                                break;
                            } else {
                                $boost_position = time() + 1;
                                $this->db->query("UPDATE ga_servers SET boost = boost-1, boost_position = $boost_position WHERE id = '" . $row['id'] . "'");
                            }
                        }

                        $boost_position = time();
                        $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':boost', $getInfoServices['period']);
                        $update->bindParam(':boost_position', $boost_position);
                        $update->bindParam(':id', $getInfoPay['id_server']);
                        $update->execute();
                    } else {

                        $boost_position = time();
                        $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':boost', $getInfoServices['period']);
                        $update->bindParam(':boost_position', $boost_position);
                        $update->bindParam(':id', $getInfoPay['id_server']);
                        $update->execute();
                    }
                }
                break;

            //	Gamemenu
            case "gamemenu":
                if ($getInfoServer['gamemenu_enabled'] != '0') {
                    $expired_time = $getInfoServer['gamemenu_expired_date'] + ($getInfoServices['period'] * 86400);
                } else {
                    $expired_time = time() + $getInfoServices['period'] * 86400;
                }
                $gamemenu = 1;
                $sql = "UPDATE ga_servers SET gamemenu_enabled = :gamemenu_enabled, gamemenu_expired_date = :gamemenu_expired_date  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':gamemenu_enabled', $gamemenu, PDO::PARAM_INT);
                $update->bindParam(':gamemenu_expired_date', $expired_time, PDO::PARAM_INT);
                $update->bindParam(':id', $getInfoPay['id_server'], PDO::PARAM_INT);
                $update->execute();
                break;

            //	Votes
            case "votes":
                $this->db->query("UPDATE ga_servers SET rating = rating+" . $getInfoServices['period'] . " WHERE id = '" . $getInfoPay['id_server'] . "'");
                break;

            //	Unban
            case "razz":
                $this->db->query("UPDATE ga_servers SET ban = '0', ban_couse = '' WHERE id = '" . $getInfoPay['id_server'] . "'");
                break;
        }
        $status = "paid";
        $sql = "UPDATE ga_pay_logs SET status = :status, pay_methods = :pay_methods WHERE id = :id";
        $update = $this->db->prepare($sql);
        $update->bindParam(':status', $status);
        $update->bindParam(':pay_methods', $data['pay_methods']);
        $update->bindParam(':id', $data['inv_id']);
        $update->execute();

        return true;
    }


    public function createInvoice(array $getInfoServices, $getInfoServer, $idServices, $userProfile)
    {
        $settings = $this->getSettings();
        $type = $getInfoServices['type'];

        switch ($type) {
            case "top":
                $payId = $this->processTopService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings);
                break;
            case "vip":
                $payId = $this->processVipService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings);
                break;
            case "color":
                $payId = $this->processColorService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings);
                break;
            case "gamemenu":
                $payId = $this->processGamemenuService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings);
                break;
            case "boost":
                $payId = $this->processBoostService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings);
                break;
            case "votes":
                $payId = $this->processVotesService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings);
                break;
            case "razz":
                $payId = $this->processUnbanService($getInfoServices, $getInfoServer, $idServices, $userProfile);
                break;
            default:
                throw new \Exception("Service not found");
        }

        return $payId;
    }

    private function getSettings()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        return json_decode($settings['content'], true);
    }

    private function processTopService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings)
    {
        $place = $getInfoServer['top_enabled'] == '0' ? (int)$_POST['place'] : 0;

        if ($getInfoServer['top_enabled'] == '0') {
            $this->checkPlaceAvailability($place);
        }

        $this->checkServiceAvailability($settings['global_settings']['top_on'], "Услуга отключена");

        $limitTopServers = $settings['global_settings']['count_servers_top'];
        $countTopServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `top_enabled` != '0'")->rowCount();
        $checkTopServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $getInfoServer['id'] . "' and `top_enabled` != '0' LIMIT 1")->rowCount();

        if ($countTopServers >= $limitTopServers && $checkTopServer == 0) {
            throw new \Exception("Нет свободных мест");
        }

        return $this->insertPayLog($idServices, $getInfoServices['price'], 'top', $userProfile['id'], ['place' => $place, 'id_server' => $getInfoServer['id']]);
    }

    private function processVipService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings)
    {
        $this->checkServiceAvailability($settings['global_settings']['vip_on'], "Услуга отключена");

        $limitVipServers = $settings['global_settings']['count_servers_vip'];
        $countVipServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `vip_enabled`='1'")->rowCount();
        $checkVipServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $getInfoServer['id'] . "' and `vip_enabled` = '1' LIMIT 1")->rowCount();

        if ($countVipServers >= $limitVipServers && $checkVipServer == 0) {
            throw new \Exception("Нет свободных мест");
        }

        return $this->insertPayLog($idServices, $getInfoServices['price'], 'vip', $userProfile['id'], ['id_server' => $getInfoServer['id']]);
    }

    private function processColorService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings)
    {
        $this->checkServiceAvailability($settings['global_settings']['color_on'], "Услуга отключена");

        $limitColorServers = $settings['global_settings']['count_servers_color'];
        $countColorServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `color_enabled`!= '0'")->rowCount();
        $checkColorServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $getInfoServer['id'] . "' and `color_enabled` != '0' LIMIT 1")->rowCount();

        if ($countColorServers >= $limitColorServers && $checkColorServer == 0) {
            throw new \Exception("Нет свободных мест");
        }

        $color = $_POST['selectColor'];
        return $this->insertPayLog($idServices, $getInfoServices['price'], 'color', $userProfile['id'], ['color' => $color, 'id_server' => $getInfoServer['id']]);
    }

    private function processGamemenuService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings)
    {
        $this->checkServiceAvailability($settings['global_settings']['gamemenu_on'], "Услуга отключена");

        $limitGamemenuServers = $settings['global_settings']['count_servers_gamemenu'];
        $countGamemenuServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `gamemenu_enabled`='1'")->rowCount();
        $checkGamemenuServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $getInfoServer['id'] . "' and `gamemenu_enabled` = '1' LIMIT 1")->rowCount();

        if ($countGamemenuServers >= $limitGamemenuServers && $checkGamemenuServer == 0) {
            throw new \Exception("Нет свободных мест");
        }

        return $this->insertPayLog($idServices, $getInfoServices['price'], 'gamemenu', $userProfile['id'], ['id_server' => $getInfoServer['id']]);
    }

    private function processBoostService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings)
    {
        $this->checkServiceAvailability($settings['global_settings']['boost_on'], "Услуга отключена");
        return $this->insertPayLog($idServices, $getInfoServices['price'], 'boost', $userProfile['id'], ['id_server' => $getInfoServer['id']]);
    }

    private function processVotesService($getInfoServices, $getInfoServer, $idServices, $userProfile, $settings)
    {
        $this->checkServiceAvailability($settings['global_settings']['votes_on'], "Услуга отключена");
        return $this->insertPayLog($idServices, $getInfoServices['price'], 'votes', $userProfile['id'], ['id_server' => $getInfoServer['id']]);
    }

    private function processUnbanService($getInfoServices, $getInfoServer, $idServices, $userProfile)
    {
        return $this->insertPayLog($idServices, $getInfoServices['price'], 'razz', $userProfile['id'], ['id_server' => $getInfoServer['id']]);
    }

    private function checkPlaceAvailability($place)
    {
        $checkPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
        $checkPlace->execute([':top_enabled' => $place]);
        if ($checkPlace->rowCount() != '0') {
            throw new \Exception("Нет свободных мест");
        }
    }

    private function checkServiceAvailability($serviceEnabled, $errorMessage)
    {
        if ($serviceEnabled == 0) {
            throw new \Exception($errorMessage);
        }
    }

    private function insertPayLog($idServices, $price, $type, $userId, $additionalData = [])
    {
        $content = json_encode(array_merge([
            'id_services' => $idServices,
            'type_pay' => "payServices",
            'price' => $price,
            'type' => $type
        ], $additionalData));

        $stmt = $this->db->prepare("INSERT INTO ga_pay_logs (content, date_create, status, id_user, pay_methods) VALUES (:content, :date_create, 'expects', :id_user, 'bill')");
        $stmt->execute([
            ':content' => $content,
            ':date_create' => time(),
            ':id_user' => $userId
        ]);

        return $this->db->lastInsertId();
    }
}