<?php

namespace controllers;

use components\paymethods\QiwiP2p;
use components\User;
use core\BaseController;
use components\System;
use Exception;
use PDO;
use xPaw\SourceQuery\SourceQuery;

class CronController extends BaseController
{
    public $backup_folder = 'backups';

    public function actionPay()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        if (!isset($_GET['key'])) parent::ShowError(404, "Страница не найдена");
        if ($settings['global_settings']['cron_key'] == $_GET['key']) {
            $getServers = $this->db->query('SELECT * FROM ga_servers WHERE befirst_enabled != "0" or top_enabled != "0" or vip_enabled !="0" or color_enabled !="0" or gamemenu_enabled !="0"');
            $getServers = $getServers->fetchAll();
            foreach ($getServers as $row) {
                if ($row['befirst_enabled'] != '0') {
                    if ($row['befirst_expired_date'] < time()) {
                        $befirst_enabled = 0;
                        $befirst_expired_date = 0;
                        $sql = "UPDATE ga_servers SET befirst_enabled = :befirst_enabled, befirst_expired_date = :befirst_expired_date WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':befirst_enabled', $befirst_enabled, PDO::PARAM_INT);
                        $update->bindParam(':befirst_expired_date', $befirst_expired_date, PDO::PARAM_INT);
                        $update->bindParam(':id', $row['id'], PDO::PARAM_INT);
                        $update->execute();
                    }
                }

                if ($row['top_enabled'] != '0') {
                    if ($row['top_expired_date'] < time()) {
                        $top_enabled = 0;
                        $top_expired_date = 0;
                        $sql = "UPDATE ga_servers SET top_enabled = :top_enabled, top_expired_date = :top_expired_date WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':top_enabled', $top_enabled, PDO::PARAM_INT);
                        $update->bindParam(':top_expired_date', $top_expired_date, PDO::PARAM_INT);
                        $update->bindParam(':id', $row['id'], PDO::PARAM_INT);
                        $update->execute();
                    }
                }

                if ($row['vip_enabled'] != '0') {
                    if ($row['vip_expired_date'] < time()) {
                        $vip_enabled = 0;
                        $vip_expired_date = 0;
                        $sql = "UPDATE ga_servers SET vip_enabled = :vip_enabled, vip_expired_date = :vip_expired_date WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':vip_enabled', $vip_enabled, PDO::PARAM_INT);
                        $update->bindParam(':vip_expired_date', $vip_expired_date, PDO::PARAM_INT);
                        $update->bindParam(':id', $row['id'], PDO::PARAM_INT);
                        $update->execute();
                    }
                }

                if ($row['gamemenu_enabled'] != '0') {
                    if ($row['gamemenu_expired_date'] < time()) {
                        $gamemenu_enabled = 0;
                        $gamemenu_expired_date = 0;
                        $sql = "UPDATE ga_servers SET gamemenu_enabled = :gamemenu_enabled, gamemenu_expired_date = :gamemenu_expired_date WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':gamemenu_enabled', $gamemenu_enabled, PDO::PARAM_INT);
                        $update->bindParam(':gamemenu_expired_date', $gamemenu_expired_date, PDO::PARAM_INT);
                        $update->bindParam(':id', $row['id'], PDO::PARAM_INT);
                        $update->execute();
                    }
                }

                if ($row['color_enabled'] != '0') {
                    if ($row['color_expired_date'] < time()) {
                        $color_enabled = 0;
                        $color_expired_date = 0;
                        $sql = "UPDATE ga_servers SET color_enabled = :color_enabled, color_expired_date = :color_expired_date WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':color_enabled', $color_enabled, PDO::PARAM_INT);
                        $update->bindParam(':color_expired_date', $color_expired_date, PDO::PARAM_INT);
                        $update->bindParam(':id', $row['id'], PDO::PARAM_INT);
                        $update->execute();
                    }
                }

            }

        } else parent::ShowError(404, "Страница не найдена");
    }

    /**
     * @throws Exception
     */
    public function actionIndex()
    {
        $mem_start = memory_get_usage();
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        if (!isset($_GET['key'])) parent::ShowError(404, "Страница не найдена");
        if ($settings['global_settings']['cron_key'] == $_GET['key']) {
            $getServers = $this->db->query('SELECT * FROM ga_servers');
            $getServers = $getServers->fetchAll();
            $Query = new SourceQuery();
            $Info = array();
            foreach ($getServers as $row) {
                if (in_array($row['game'], ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust'])){
                try {
                    $Query->Connect($row['ip'], $row['port'], 2, SourceQuery::GOLDSOURCE);
                    $Info = $Query->GetInfo();
                    $status = 1;
                    $sql = "UPDATE ga_servers SET status = :status, hostname = :hostname, map = :map, players = :players, max_players = :max_players WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':status', $status);
                    $update->bindParam(':hostname', $Info['HostName']);
                    $update->bindParam(':map', $Info['Map']);
                    $update->bindParam(':players', $Info['Players']);
                    $update->bindParam(':max_players', $Info['MaxPlayers']);
                    $update->bindParam(':id', $row['id']);
                    $update->execute();
                } catch (Exception $e) {
                    $Exception = $e;
                    $status = 0;
                    $sql = "UPDATE ga_servers SET status = :status WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':status', $status);
                    $update->bindParam(':id', $row['id']);
                    $update->execute();
                }
                $Query->Disconnect();
            }elseif ($row['game'] == 'samp'){
                    try {
                        $GameQ = new \GameQ\GameQ();
                        $GameQ->addServer([
                            'type' => $row['game'],
                            'host' => $row['ip'].":".$row['port'],
                        ]);
                        $results = $GameQ->process();
                        $Info = array_shift($results);
                        $hostname = utf8_decode($Info['servername']);


                        $status = 1;
                        $mapName = $Info['gq_hostname'];
                        $players = $Info['gq_numplayers'];
                        $maxPlayers = $Info['gq_maxplayers'];
                        $sql = "UPDATE ga_servers SET status = :status, hostname = :hostname, map = :map, players = :players, max_players = :max_players WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':status', $status);
                        $update->bindParam(':hostname', $hostname);
                        $update->bindParam(':map', $mapName);
                        $update->bindParam(':players', $players);
                        $update->bindParam(':max_players', $maxPlayers);
                        $update->bindParam(':id', $row['id']);
                        $update->execute();
                    } catch (Exception $e) {
                        $Exception = $e;
                        $status = 0;
                        $sql = "UPDATE ga_servers SET status = :status WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':status', $status);
                        $update->bindParam(':id', $row['id']);
                        $update->execute();
                    }

                }elseif ($row['game'] == 'mta'){
                    try {

                        $GameQ = new \GameQ\GameQ();
                        $GameQ->addServer([
                            'type' => 'mta',
                            'host' => $row['ip'].":".$row['port'],
                        ]);
                        $results = $GameQ->process();

                        $Info = array_shift($results);

                        if (empty($Info['gq_hostname'])){
                            throw new \DomainException();
                        }
                        $hostname = $Info['gq_hostname'];
                        $status = 1;
                        $mapName = $Info['gq_mapname'];
                        $players = $Info['num_players'];
                        $maxPlayers = $Info['max_players'];
                        $sql = "UPDATE ga_servers SET status = :status, hostname = :hostname, map = :map, players = :players, max_players = :max_players WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':status', $status);
                        $update->bindParam(':hostname', $hostname);
                        $update->bindParam(':map', $mapName);
                        $update->bindParam(':players', $players);
                        $update->bindParam(':max_players', $maxPlayers);
                        $update->bindParam(':id', $row['id']);
                        $update->execute();
                    } catch (Exception $e) {
                        $Exception = $e;
                        $status = 0;
                        $sql = "UPDATE ga_servers SET status = :status WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':status', $status);
                        $update->bindParam(':id', $row['id']);
                        $update->execute();
                    }
                }
            }

        } else parent::ShowError(404, "Страница не найдена");
        $time = time();
        $sql = "UPDATE ga_settings SET last_update_servers = $time";
        $this->db->query($sql);
        echo "server information updated successfully";
    }


    /**
     * Обработка платежей по кассе киви
     * @throws \Qiwi\Api\BillPaymentsException|\ErrorException
     */
    public function actionQiwi(){
        $getSettings = $this->db->query('SELECT content FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        if (!isset($_GET['key'])) parent::ShowError(404, "Страница не найдена!");
        if ($settings['global_settings']['cron_key'] == $_GET['key']) {

            $user = new User();
            $payMethod = "qiwi_p2p";
            $getInfoPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
            $getInfoPayMethods->execute(array(':typeCode' => $payMethod));
            $getInfoPayMethods = $getInfoPayMethods->fetch();
            $InfoPayment = json_decode($getInfoPayMethods['content'], true);

            $getPayLogs = $this->db->query('SELECT * FROM ga_pay_logs WHERE pay_methods = "'.$payMethod.'" and status = "expects"');
            $getPayLogs = $getPayLogs->fetchAll();
            foreach ($getPayLogs as $row) {
                $content = json_decode($row['content'], true);
                $qiwi = new QiwiP2p($InfoPayment['secret_key']);
                $result = $qiwi->getBillInfo($row['bill_id']);
                if ($result['status']['value'] == 'PAID'){
                    $user->refill(['inv_id' => $row['id'], 'amout' => $content['amout']]);
                }



            }
            echo "invoices have been processed successfully";
        }else{
            parent::ShowError(404, "Страница не найдена!");
        }
    }

    /**
     * Проверка счетов на актуальность
     */
    public function actionPayments()
    {
        $getSettings = $this->db->query('SELECT content FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        if (!isset($_GET['key'])) parent::ShowError(404, "Страница не найдена!");
        if ($settings['global_settings']['cron_key'] == $_GET['key']) {
            $getPayLogs = $this->db->query('SELECT * FROM ga_pay_logs WHERE pay_methods != "bill" and status = "expects"');
            $getPayLogs = $getPayLogs->fetchAll();
            foreach ($getPayLogs as $row) {
                $expiredTime = $row['date_create']+($settings['global_settings']['expired_time_payment'] * 3600);
                if ($expiredTime < time()){
                    $status = 'expired';
                    $sql = "UPDATE ga_pay_logs SET status = :status WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':status', $status);
                    $update->bindParam(':id', $row['id']);
                    $update->execute();
                }

            }
            echo "invoices have been processed successfully";
        }else{
            parent::ShowError(404, "Страница не найдена!");
        }
    }

}
