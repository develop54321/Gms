<?php

namespace command\queue;

use core\Database;
use Exception;
use PHPMailer\PHPMailer\PHPMailer;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class MailerQueue
{
    private OutputInterface $output;
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

        $mail = new PHPMailer(true);

        try {
            if ($params['type'] === 'smtp') {
                $mail->isSMTP();
                $mail->Host = $params['smtp_server'] ?? '';
                $mail->Port = $params['smtp_port'] ?? 587;
                $mail->SMTPAuth = !empty($params['smtp_username']) && !empty($params['smtp_password']);
                $mail->Username = $params['smtp_username'] ?? '';
                $mail->Password = $params['smtp_password'] ?? '';
                $mail->SMTPSecure = $params['encrypt'] === 'ssl' ? PHPMailer::ENCRYPTION_SMTPS : ($params['encrypt'] === 'tls' ? PHPMailer::ENCRYPTION_STARTTLS : '');
                $mail->SMTPAutoTLS = isset($params['auto_tls']) ? (bool)$params['auto_tls'] : true;
            }

            $mail->setFrom($params['from'], 'Mailer');

            $mail->addAddress($message['address']);

            $mail->Subject = $message['subject'];
            $mail->Body = $message['content'];
            $mail->send();

            $output->writeln('<info>Email sent successfully!</info>');
            return Command::SUCCESS;
        } catch (Exception $e) {
            $output->writeln('<error>Email sending failed: ' . $mail->ErrorInfo . '</error>');
            return Command::FAILURE;
        }
    }

}