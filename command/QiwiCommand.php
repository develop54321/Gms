<?php

namespace command;

use components\paymethods\QiwiP2p;
use components\User;
use core\Database;
use Qiwi\Api\BillPaymentsException;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

/**
 * Обработка платежей по кассе киви
 */
class QiwiCommand extends Command
{
    protected static $defaultName = "qiwi";

    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
        parent::__construct($name);
    }

    /**
     * @throws BillPaymentsException
     * @throws \ErrorException
     */
    protected function execute(InputInterface $input, OutputInterface $output): int{
        $user = new User();
        $payMethod = "qiwi_p2p";
        $getInfoPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
        $getInfoPayMethods->execute(array(':typeCode' => $payMethod));
        $getInfoPayMethods = $getInfoPayMethods->fetch();
        $InfoPayment = json_decode($getInfoPayMethods['content'], true);

        $getPayLogs = $this->db->query('SELECT * FROM ga_pay_logs WHERE pay_methods = "' . $payMethod . '" and status = "expects"');
        $getPayLogs = $getPayLogs->fetchAll();
        foreach ($getPayLogs as $row) {
            $content = json_decode($row['content'], true);
            $qiwi = new QiwiP2p($InfoPayment['secret_key']);
            $result = $qiwi->getBillInfo($row['bill_id']);
            if ($result['status']['value'] == 'PAID') {
                $user->refill(['inv_id' => $row['id'], 'amout' => $content['amout']]);
            }


        }

        return Command::SUCCESS;
    }

}