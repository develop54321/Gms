<?php

declare(strict_types=1);

namespace components\pay_method;

class FrekassaService
{
    private int $fkId;
    private string $fkKey;


    public function __construct(
        int $fkId,
        string $fkKey
    )
    {
        $this->fkId = $fkId;
        $this->fkKey = $fkKey;
    }

    public function createPayment(
        float $price,
        int $payId,
        string $sign
    ): string{

        $baseUrl = 'http://www.free-kassa.ru/merchant/cash.php';


        $queryParams = http_build_query([
            'm' => $this->fkId,
            'oa' => $price,
            'o' => $payId,
            's' => $sign
        ]);

        return $baseUrl . '?' . $queryParams;
    }

    public function getSign(
        float $amount,
        int $payId
    ): string
    {

        return md5($this->fkId . ":" . $amount . ":" . $this->fkKey . ":" . $payId);
    }

}