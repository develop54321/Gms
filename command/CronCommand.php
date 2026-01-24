<?php

namespace command;

use components\GameServerQuery;
use core\Database;
use Exception;
use PDO;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

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
        $startTime = microtime(true);
        $now = time();

        $servers = $this->db->query('SELECT id, game, ip, port, query_port FROM ga_servers')
            ->fetchAll();

        foreach ($servers as $row) {
            try {
                $query = new GameServerQuery(
                    $row['ip'],
                    (int)$row['port'],
                    $row['game'],
                    isset($row['query_port']) ? (int)$row['query_port'] : null
                );

                $info = $query->query();

                // Если сервер недоступен, бросаем исключение
                if (empty($info['hostname'])) {
                    throw new Exception("Server is not available");
                }

                $status = 1;
                $sql = "UPDATE ga_servers 
                        SET status = :status, hostname = :hostname, map = :map, 
                            players = :players, max_players = :max_players, last_update_at = :last_update_at 
                        WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':status', $status);
                $update->bindParam(':hostname', $info['hostname']);
                $update->bindParam(':map', $info['map']);
                $update->bindParam(':players', $info['players']);
                $update->bindParam(':max_players', $info['max_players']);
                $update->bindParam(':last_update_at', $now);
                $update->bindParam(':id', $row['id']);
                $update->execute();

            } catch (Exception $e) {
                $status = 0;
                $sql = "UPDATE ga_servers SET status = :status WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':status', $status);
                $update->bindParam(':id', $row['id']);
                $update->execute();
            }
        }

        // Обновление времени последнего обновления серверов
        $this->db->query("UPDATE ga_settings SET last_update_servers = $now");

        // Логирование
        $executionTime = microtime(true) - $startTime;
        $text = "Серверы успешно обновлены, процесс занял " . round($executionTime, 4) . " секунд";

        $sql = 'INSERT INTO ga_system_logs (text, date_create) VALUES (:text, :date_create)';
        $stmt = $this->db->prepare($sql);
        $stmt->bindValue(':text', $text, PDO::PARAM_STR);
        $stmt->bindValue(':date_create', $now, PDO::PARAM_STR);
        $stmt->execute();

        echo "Server information updated successfully\n";

        return Command::SUCCESS;
    }
}
