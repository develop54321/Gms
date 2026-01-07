<?php

namespace components;

use core\BaseController;
use PDO;

class Services extends BaseController
{

    private const TYPE_TOP = "top";
    private const TYPE_VIP = "vip";
    private const TYPE_COLOR = "color";
    private const TYPE_GAME_MENU = "gamemenu";
    private const TYPE_UNBAN = "razz";
    private const TYPE_VOTES = "votes";
    private const TYPE_BOOST = "boost";

    private function getSettings()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        return Json::decode($settings['content'], true);
    }


    public function validate(array $infoServices, $server, $params)
    {
        $settings = $this->getSettings();

        switch ($infoServices["type"]) {
            case self::TYPE_TOP:

                if ($settings['global_settings']['top_on'] === null) throw new \InvalidArgumentException("Услуга отключена");


                if ($server['top_enabled'] !== null){
                    $params['place']  = $server['top_enabled'];
                }else{
                    if ($params['place'] === null or $params['place'] === "") {
                        throw new \InvalidArgumentException("Не выбрано место");
                    }
                }




                $limitTopServers = $settings['global_settings']['count_servers_top'];
                $countQuery = $this->db->prepare("SELECT COUNT(*) FROM ga_servers WHERE top_enabled IS NOT NULL");
                $countQuery->execute();
                $countTopServers = (int)$countQuery->fetchColumn();

                $checkQuery = $this->db->prepare("SELECT COUNT(*) FROM ga_servers WHERE id = :server_id AND top_enabled IS NOT NULL");
                $checkQuery->execute([':server_id' => $server['id']]);
                $currentHasTop = (int)$checkQuery->fetchColumn() > 0;

                if ($countTopServers >= $limitTopServers && !$currentHasTop) {
                    throw new \InvalidArgumentException("Нет свободных мест");
                }

                return $this->insertPayLog(
                    $infoServices['id'],
                    $infoServices['price'],
                    self::TYPE_TOP,
                    $params['user_id'] ?? null,
                    ['place' => $params['place'], 'id_server' => $server['id']]);
                break;


            case self::TYPE_COLOR:
                if ($settings['global_settings']['color_on'] === null) throw new \InvalidArgumentException("Услуга отключена");


                if ($server['color_enabled'] === null) {
                    if ($params['color'] === null) {
                        throw new \InvalidArgumentException("Не выбран цвет");
                    }
                }

                $limitColorServers = $settings['global_settings']['count_servers_color'];

                $countQuery = $this->db->prepare("SELECT COUNT(*) FROM ga_servers WHERE color_enabled IS NOT NULL");
                $countQuery->execute();
                $countColorServers = (int)$countQuery->fetchColumn();

                $checkQuery = $this->db->prepare("SELECT 1 FROM ga_servers WHERE id = :server_id AND color_enabled IS NOT NULL LIMIT 1");
                $checkQuery->execute([':server_id' => $server['id']]);
                $checkColorServer = $checkQuery->rowCount();

                if ($countColorServers >= $limitColorServers && $checkColorServer == 0) {
                    throw new \InvalidArgumentException("Нет свободных мест");
                }


                $fetchCode = $this->db->prepare('SELECT * FROM ga_code_colors WHERE code = :code');
                $fetchCode->execute([':code' => $params['color']]);
                $codeData = $fetchCode->fetch(PDO::FETCH_ASSOC);

                if (!$codeData) {
                    throw new \InvalidArgumentException("Code color " . htmlspecialchars($params['color']) . " not found");
                }


                return $this->insertPayLog(
                    $infoServices['id'],
                    $infoServices['price'],
                    self::TYPE_COLOR,
                    $params['user_id'] ?? null,
                    ['color' => $params['color'], 'id_server' => $server['id']]
                );
                break;

            case self::TYPE_VIP:

                if ($settings['global_settings']['vip_on'] === null) throw new \InvalidArgumentException("Услуга отключена");

                $limitVipServers = $settings['global_settings']['count_servers_vip'];
                $countQuery = $this->db->prepare("SELECT COUNT(*) FROM ga_servers WHERE vip_enabled = 1");
                $countQuery->execute();
                $countVipServers = (int)$countQuery->fetchColumn();


                $checkQuery = $this->db->prepare("SELECT COUNT(*) FROM ga_servers WHERE id = :server_id AND vip_enabled = 1");
                $checkQuery->execute([':server_id' => $server['id']]);
                $currentHasVip = (int)$checkQuery->fetchColumn() > 0;

                if ($countVipServers >= $limitVipServers && !$currentHasVip) throw new \InvalidArgumentException("Нет свободных мест");


                return $this->insertPayLog(
                    $infoServices['id'],
                    $infoServices['price'],
                    self::TYPE_VIP,
                    $params['user_id'] ?? null,
                    ['id_server' => $server['id']]);
                break;

            case self::TYPE_GAME_MENU:
                if ($settings['global_settings']['gamemenu_on'] === null) throw new \InvalidArgumentException("Услуга отключена");


                $limitGameMenuServers = $settings['global_settings']['count_servers_gamemenu'];
                $countGameMenuServers = $this->db->query("SELECT `id` FROM `ga_servers` WHERE `gamemenu_enabled` = '1'")->rowCount();
                $checkGameMenuServer = $this->db->query("SELECT * FROM `ga_servers` WHERE `id`='" . $server['id'] . "' and `gamemenu_enabled` = '1' LIMIT 1")->rowCount();

                if ($countGameMenuServers >= $limitGameMenuServers && $checkGameMenuServer == 0) throw new \InvalidArgumentException("Нет свободных мест");


                return $this->insertPayLog(
                    $infoServices['id'],
                    $infoServices['price'],
                    self::TYPE_GAME_MENU,
                    $params['user_id'] ?? null,
                    ['id_server' => $server['id']]
                );


                break;


            case self::TYPE_VOTES:
                if ($settings['global_settings']['votes_on'] === null) throw new \InvalidArgumentException("Услуга отключена");

                return $this->insertPayLog(
                    $infoServices['id'],
                    $infoServices['price'],
                    self::TYPE_VOTES,
                    $params['user_id'] ?? null,
                    ['id_server' => $server['id']]
                );
                break;

                case self::TYPE_UNBAN:
                    return $this->insertPayLog(
                        $infoServices['id'],
                        $infoServices['price'],
                        self::TYPE_UNBAN,
                        $params['user_id'] ?? null,
                        ['id_server' => $server['id']]
                    );
                 break;

                 case self::TYPE_BOOST:
                     if ($settings['global_settings']['boost_on'] === null) throw new \InvalidArgumentException("Услуга отключена");

                     return $this->insertPayLog(
                         $infoServices['id'],
                         $infoServices['price'],
                         self::TYPE_BOOST,
                         $params['user_id'] ?? null,
                         ['id_server' => $server['id']]
                     );
                     break;
            default:
                throw new \InvalidArgumentException("Service type '{$infoServices["type"]}' is not supported.");
        }






    }
    public function processing($data): bool
    {

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = Json::decode($settings['content'], true);

        $getInfoPay = $this->db->prepare('SELECT * FROM ga_pay_logs WHERE id = :id');
        $getInfoPay->execute(array(':id' => $data['inv_id']));
        $getInfoPay = $getInfoPay->fetch();

        if (empty($getInfoPay)) parent::ShowError(404, "Страница не найдена!");
        $getInfoPay = Json::decode($getInfoPay['content'], true);

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
                if ($getInfoServer['top_enabled'] !== null) {
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
                if ($getInfoServer['vip_enabled'] !== null) {
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
                if ($getInfoServer['color_enabled'] !== null) {
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
                if ($getInfoServer['boost'] !== null) {
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
                            if ($row['boost'] === 1) {
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
                if ($getInfoServer['gamemenu_enabled'] !== null) {
                    $expired_time = $getInfoServer['gamemenu_expired_date'] + ($getInfoServices['period'] * 86400);
                } else {
                    $expired_time = time() + $getInfoServices['period'] * 86400;
                }
                $gameMenu = 1;
                $sql = "UPDATE ga_servers SET gamemenu_enabled = :gamemenu_enabled, gamemenu_expired_date = :gamemenu_expired_date  WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':gamemenu_enabled', $gameMenu, PDO::PARAM_INT);
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
                $this->db->query("UPDATE ga_servers SET ban = null, ban_couse = null WHERE id = '" . $getInfoPay['id_server'] . "'");
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




    private function insertPayLog($idServices, $price, $type, $userId = null, $additionalData = [])
    {

        $content = Json::encode(array_merge([
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