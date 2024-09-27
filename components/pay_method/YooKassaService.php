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

final class YooKassaService
{

    public function __construct(
        int $shopId,
        string $secretKey
    )
    {
        $this->shopId = $shopId;
        $this->secretKey = $secretKey;
    }

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
                                  string $payLogId,
                                  string $returnUrl
    ): array
    {
        $client = new Client();
        $client->setAuth($this->shopId, $this->secretKey);

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
                    "pay_log_id" => $payLogId
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
        $client->setAuth($this->shopId, $this->secretKey);

        return $client->getPaymentInfo($paymentGuid);
    }

}