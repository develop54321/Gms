<?php

namespace command;

use command\queue\MailerQueue;
use core\Database;
use Exception;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class QueueMailCommand extends Command
{
    protected static $defaultName = "queue:mail";

    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
        parent::__construct($name);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);

        try {
            // Fetch records to process
            $getQueueRecords = $this->db->query("SELECT message, id, attempt FROM ga_queue WHERE status = 'WAIT' AND attempt < max_attempt LIMIT 50");
            $rows = $getQueueRecords->fetchAll();

            if (empty($rows)) {
                $io->success('No records to process.');
                return Command::SUCCESS;
            }

            $mailerQueue = new MailerQueue();
            foreach ($rows as $row) {
                try {
                    $message = json_decode($row['message'], true);

                    // Mailer
                    $mailerQueue->run($output, $message);

                    // Update status to COMPLETED
                    $status = "COMPLETED";
                    $sql = "UPDATE ga_queue SET status = :status WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':status', $status);
                    $update->bindParam(':id', $row['id']);
                    $update->execute();
                } catch (Exception $e) {
                    // Increment attempt counter
                    $newAttempt = $row['attempt'] + 1;
                    if ($newAttempt >= 3) {
                        $status = "FAILED";
                        $sql = "UPDATE ga_queue SET status = :status, attempt = :attempt WHERE id = :id";
                    } else {
                        $sql = "UPDATE ga_queue SET attempt = :attempt WHERE id = :id";
                    }

                    $stmt = $this->db->prepare($sql);
                    $stmt->bindParam(':attempt', $newAttempt);
                    $stmt->bindParam(':id', $row['id']);
                    if (isset($status)) {
                        $stmt->bindParam(':status', $status);
                    }
                    $stmt->execute();
                }
            }

            $io->success('GA queue processed successfully.');
            return Command::SUCCESS;
        } catch (Exception $e) {
            $io->error('An error occurred during processing. Check logs for details.');
            return Command::FAILURE;
        }
    }

}