<?php

namespace controllers;
require 'SourceQuery/bootstrap.php';

use core\BaseController;
use components\System;
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
            }

        } else parent::ShowError(404, "Страница не найдена");
        $time = time();
        $sql = "UPDATE ga_settings SET last_update_servers = $time";
        $this->db->query($sql);
        echo "server information updated successfully";
    }

    public function actionTasks()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        if (!isset($_GET['key'])) parent::ShowError(404, "Страница не найдена");
        if ($settings['global_settings']['cron_key'] == $_GET['key']) {
            if ($settings['global_settings']['autoBackupDb'] == '1') {
                $currentDate = date("d-m-Y");
                $hash = "db_" . md5(mt_rand(111, 999));
                $name = $currentDate . "-" . $hash . ".sql";
                $full_path = $this->backupDB($this->backup_folder, "$currentDate-$hash");
                $this->db->exec("INSERT INTO ga_backup (name, type, date_create, hash) VALUES('$name', 'database', " . time() . ", '$full_path')");
            }
        }
    }

    private function backupDB($backup_folder, $backup_name)
    {
        $fullFileName = $backup_folder . '/' . $backup_name . '.sql';
        $command = 'mysqldump -h' . DB_HOST . ' -u' . DB_USER . ' -p' . DB_PASSWORD . ' ' . DB_NAME . ' > ' . $fullFileName;
        shell_exec($command);
        return $fullFileName;
    }

}