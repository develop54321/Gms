<?php

namespace command;

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
            $getQueueRecords = $this->db->query('SELECT * FROM ga_queue WHERE status = :status AND attempt < max_attempt LIMIT 10');
            $rows = $getQueueRecords->fetchAll();

            if (empty($rows)) {
                $io->success('No records to process.');
                return Command::SUCCESS;
            }

            foreach ($rows as $row) {
                try {
                    $this->processRecord($row);

                    //mailer


                    $status = "COMPLETED";
                    $sql = "UPDATE ga_queue SET status = :status WHERE id = :id";
                    $update = $this->db->prepare($sql);
                    $update->bindParam(':status', $status);
                    $update->bindParam(':id', $row['id']);
                    $update->execute();


                } catch (Exception $e) {
                    // Increment attempt counter
                    $stmt = $this->db->prepare("UPDATE ga_queue SET attempt = attempt + 1 WHERE id = :id");
                    $stmt->bindParam(':id', $id);
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

    private function processRecord(array $record): void
    {
        // Implement the business logic for processing a single record here
        // For example, sending data to an external API or performing some calculations

        // Simulating processing
        sleep(1); // Simulate a delay for processing
        if (rand(0, 1)) { // Simulate a random failure
            throw new \RuntimeException('Simulated processing failure');
        }

    }
}