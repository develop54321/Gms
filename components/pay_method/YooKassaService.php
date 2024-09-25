<?php

namespace components\pay_method;

use YooKassa\Client;
use YooKassa\Common\Exceptions\ApiConnectionException;
use YooKassa\Common\Exceptions\ApiException;
use YooKassa\Common\Exceptions\AuthorizeException;
use YooKassa\Common\Exceptions\BadApiRequestException;
use YooKassa\Common\Exceptions\ExtensionNotFoundException;
use YooKassa\Common\Exceptions\ForbiddenException;
use YooKassa\Common\Exceptions\InternalServerError;
use YooKassa\Common\Exceptions\NotFoundException;
use YooKassa\Common\Exceptions\ResponseProcessingException;
use YooKassa\Common\Exceptions\TooManyRequestsException;
use YooKassa\Common\Exceptions\UnauthorizedException;

class YooKassaService
{

    private const SHOP_ID = 448594;
    //private const SECRET_KEY_TEST = "test_o_EfvesnAvvM37fvoo0ZLyMyPUnuAGOYOOpEY9-Sy7Y";
    private const SECRET_KEY = "live_T7aE36rVTE6XDqmQP9CxL0MQTjVOA6WgoxG9qbNJ_UA";

    /**
     * @throws NotFoundException
     * @throws ResponseProcessingException
     * @throws ApiException
     * @throws BadApiRequestException
     * @throws ExtensionNotFoundException
     * @throws AuthorizeException
     * @throws InternalServerError
     * @throws ForbiddenException
     * @throws TooManyRequestsException
     * @throws UnauthorizedException
     * @throws ApiConnectionException
     */
    public function createPayment(float $price,
                                  string $description,
                                  string $payLogGuid,
                                  string $returnUrl
    ): array
    {
        $client = new Client();
        $client->setAuth(self::SHOP_ID, self::SECRET_KEY);

        $idempotenceKey = uniqid('', true);
        $response = $client->createPayment(
            array(
                'amount' => array(
                    'value' => $price,
                    'currency' => 'RUB',
                ),
                'confirmation' => array(
                    'type' => 'redirect',
                    'locale' => "ru_RU",
                    'return_url' => $returnUrl
                ),
                'metadata' => [
                    "pay_log_guid" => $payLogGuid
                ],
                'description' => $description
            ),
            $idempotenceKey
        );


        return [
            "guid" => $response->getId(),
            "url" => $response->getConfirmation()->getConfirmationUrl()
        ];

    }

    public function getPaymentInfo(string $paymentGuid): ?\YooKassa\Model\Payment\PaymentInterface
    {
        $client = new Client();
        $client->setAuth(self::SHOP_ID, self::SECRET_KEY);

        return $client->getPaymentInfo($paymentGuid);
    }

}