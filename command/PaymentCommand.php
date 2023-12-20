<?php

namespace command;

use core\Database;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class PaymentCommand extends Command
{
    protected static $defaultName = "payment";

    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
        parent::__construct($name);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int{
        $getSettings = $this->db->query('SELECT content FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);


        $getPayLogs = $this->db->query('SELECT * FROM ga_pay_logs WHERE pay_methods != "bill" and status = "expects"');
        $getPayLogs = $getPayLogs->fetchAll();
        foreach ($getPayLogs as $row) {
            $expiredTime = $row['date_create'] + ($settings['global_settings']['expired_time_payment'] * 3600);
            if ($expiredTime < time()) {
                $status = 'expired';
                $sql = "UPDATE ga_pay_logs SET status = :status WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':status', $status);
                $update->bindParam(':id', $row['id']);
                $update->execute();
            }

        }

        return Command::SUCCESS;
    }
}