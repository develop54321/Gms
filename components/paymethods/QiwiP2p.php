<?php

namespace components\paymethods;

use Qiwi\Api\BillPayments;

class QiwiP2p
{
    private $secret_key;
    private $public_key;


    public function __construct($secret_key, $public_key)
    {
        $this->secret_key = $secret_key;
        $this->public_key = $public_key;
    }

    public function createBill($billId, $amount): array
    {
        $billPayments = new BillPayments($this->secret_key);

        $fields = [
            'amount' => $amount,
            'currency' => 'RUB',
            'email' => 'example@mail.org'
        ];


        return $billPayments->createBill($billId, $fields);



    }

}