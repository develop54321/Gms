<?php

namespace components\paymethods;

use Qiwi\Api\BillPayments;
use Qiwi\Api\BillPaymentsException;

class QiwiP2p
{
    private $secret_key;
    private $billPayments;

    private $currency = "RUB";

    /**
     * @throws \ErrorException
     */
    public function __construct($secret_key)
    {
        $this->secret_key = $secret_key;
        $this->billPayments = new BillPayments($this->secret_key);
    }

    public function createBill($billId, $amount, $email): array
    {
        $params = [
            'amount' => $amount,
            'currency' => $this->currency,
            'email' => $email
        ];


        return $this->billPayments->createBill($billId, $params);

    }

    /**
     * @throws BillPaymentsException
     */
    public function getBillInfo($billId){
        return $this->billPayments->getBillInfo($billId);
    }



}