<?php

namespace command\queue;

use components\Mail;
use core\Database;
use Exception;
use PHPMailer\PHPMailer\PHPMailer;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class MailerQueue
{
    private OutputInterface $output;
    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
    }
    public function run(OutputInterface $output, array $message): int
    {
        $getSettings = $this->db->query('SELECT params_mail FROM ga_settings');
        $settings = $getSettings->fetch();
        if (!$settings) {
            $output->writeln('<error>No email settings found!</error>');
            return Command::FAILURE;
        }

        $params = json_decode($settings['params_mail'], true);
        if (!$params) {
            $output->writeln('<error>Invalid JSON format in email settings!</error>');
            return Command::FAILURE;
        }


        $mail = new Mail();

        try {

            $mail->send($params, $message);

            $output->writeln('<info>Email sent successfully!</info>');
            return Command::SUCCESS;
        } catch (Exception $e) {
            $output->writeln('<error>Email sending failed: ' . $e->getMessage() . '</error>');
            return Command::FAILURE;
        }
    }

}