<?php

namespace command;

use core\Database;
use PDO;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class ServicesCommand extends Command
{
    protected static $defaultName = 'services';

    private Database $db;

    public function __construct()
    {
        parent::__construct();
        $this->db = new Database();
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $stmt = $this->db->query("
            SELECT *
            FROM ga_servers
            WHERE top_enabled IS NOT NULL
               OR vip_enabled IS NOT NULL
               OR color_enabled IS NOT NULL
               OR gamemenu_enabled IS NOT NULL
        ");

        $servers = $stmt->fetchAll(PDO::FETCH_ASSOC);
        $now = time();


        foreach ($servers as $row) {
            $this->disableIfExpired($row, 'top', $now);
            $this->disableIfExpired($row, 'vip', $now);
            $this->disableIfExpired($row, 'gamemenu', $now);
            $this->disableIfExpired($row, 'color', $now);
        }

        return Command::SUCCESS;
    }

    private function disableIfExpired(array $row, string $service, int $now): void
    {
        $enabledField = "{$service}_enabled";
        $expiredField = "{$service}_expired_date";

        if (
            $row[$enabledField] !== null &&
            (
                $row[$expiredField] === null ||
                $row[$expiredField] < $now
            )
        ) {
            $sql = "
            UPDATE ga_servers
            SET {$enabledField} = NULL,
                {$expiredField} = NULL
            WHERE id = :id
        ";

            $stmt = $this->db->prepare($sql);
            $stmt->bindValue(':id', $row['id'], PDO::PARAM_INT);
            $stmt->execute();
        }
    }

}
