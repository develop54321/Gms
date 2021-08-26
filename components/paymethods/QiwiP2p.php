<?php

namespace components\paymethods;

use Qiwi\Api\BillPayments;
use Qiwi\Api\BillPaymentsException;

class QiwiP2p
{
    private $secret_key;
    private $public_key;
    private $billPayments;


    /**
     * @throws \ErrorException
     */
    public function __construct($secret_key, $public_key)
    {
        $this->secret_key = $secret_key;
        $this->public_key = $public_key;
        $this->billPayments = new BillPayments($this->secret_key);
    }

    public function createBill($billId, $amount): array
    {
        $params = [
            'amount' => $amount,
            'currency' => 'RUB',
            'email' => 'example@mail.org'
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