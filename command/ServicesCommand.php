<?php

namespace command;

use core\Database;
use PDO;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class ServicesCommand extends Command
{
    protected static $defaultName = "services";

    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
        parent::__construct($name);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int{
        $getServers = $this->db->query('SELECT * FROM ga_servers WHERE top_enabled != "0" or vip_enabled !="0" or color_enabled !="0" or gamemenu_enabled !="0"');
        $getServers = $getServers->fetchAll();
        foreach ($getServers as $row) {
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

        return Command::SUCCESS;
    }

}