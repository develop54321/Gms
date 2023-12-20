<?php

namespace command;

use core\Database;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use xPaw\SourceQuery\SourceQuery;

class CronCommand extends Command
{

    protected static $defaultName = "cron";

    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
        parent::__construct($name);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $getServers = $this->db->query('SELECT * FROM ga_servers');
        $getServers = $getServers->fetchAll();
        $Query = new SourceQuery();
        $Info = array();
        foreach ($getServers as $row) {
            if (in_array($row['game'], ['cs', 'csgo', 'css', 'tf2', 'ld2', 'rust'])) {
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
            } elseif ($row['game'] == 'samp') {
                try {
                    $GameQ = new \GameQ\GameQ();
                    $GameQ->addServer([
                        'type' => $row['game'],
                        'host' => $row['ip'] . ":" . $row['port'],
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

            } elseif ($row['game'] == 'mta') {
                try {

                    $GameQ = new \GameQ\GameQ();
                    $GameQ->addServer([
                        'type' => 'mta',
                        'host' => $row['ip'] . ":" . $row['port'],
                    ]);
                    $results = $GameQ->process();

                    $Info = array_shift($results);

                    if (empty($Info['gq_hostname'])) {
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

        $time = time();
        $sql = "UPDATE ga_settings SET last_update_servers = $time";
        $this->db->query($sql);
        echo "server information updated successfully";


        return Command::SUCCESS;
    }
}