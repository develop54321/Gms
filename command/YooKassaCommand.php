<?php

namespace command;

use components\pay_method\YooKassaService;
use components\Services;
use components\User;
use core\Database;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class YooKassaCommand extends Command
{

    protected static $defaultName = "yookassa";

    private Database $db;

    public function __construct(string $name = null)
    {
        $this->db = new Database();
        parent::__construct($name);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $getPayLogs = $this->db->query('SELECT id, bill_id, content FROM ga_pay_logs WHERE pay_methods = "yookassa" and status = "expects"');
        $getPayLogs = $getPayLogs->fetchAll();

        if (!empty($getPayLogs)) {

            $getInfoPayMethods = $this->db->prepare('SELECT * FROM ga_pay_methods WHERE typeCode = :typeCode');
            $getInfoPayMethods->execute([':typeCode' => "yookassa"]);
            $getInfoPayMethods = $getInfoPayMethods->fetch();

            $InfoPayment = json_decode($getInfoPayMethods['content'], true);
            $InfoPayment = array_merge($InfoPayment, array('typeCode' => $getInfoPayMethods['typeCode']));


            $youKassaService = new YooKassaService(
                $InfoPayment['shop_id'],
                $InfoPayment['secret_key'],
            );


            $services = new Services();
            $user = new User();

            foreach ($getPayLogs as $payLog) {

                $decodeContent = json_decode($payLog['content'], true);

                try {
                    $res = $youKassaService->getPaymentInfo(
                        $payLog['bill_id'],
                    );


                    if (in_array($res->getStatus(), [
                        "succeeded",
                        "canceled"
                    ])) {

                        if ($decodeContent['type_pay'] == 'refill') {
                            $user->refill([
                                'inv_id' => $payLog['id'],
                                'amount' => $decodeContent['amount']
                            ]);
                        } else {
                            $services->processing([
                                'inv_id' => $payLog['id'],
                                'price' => $decodeContent['amount'],
                                'pay_methods' => "yookassa"
                            ]);
                        }
                        echo "ok";
                    }
                }catch (\Exception $e){
                    echo $e->getMessage();
                }
            }
        }




        return Command::SUCCESS;
    }

}