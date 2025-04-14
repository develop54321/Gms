<?php

namespace components\pay_method;

use components\Json;
use Exception;
use InvalidArgumentException;
use RuntimeException;

class LavaClient
{
    private const BASE_API_URL = "https://api.lava.ru/business";
    private const CREATE_INVOICE_ENDPOINT = "/invoice/create";
    private const INVOICE_STATUS_ENDPOINT = "/invoice/status";

    private const HTTP_TIMEOUT = 10;
    private const HTTP_MAX_REDIRECTS = 5;

    private string $shopId;
    private string $secretKey;


    public function __construct(
        string $shopId,
        string $secretKey
    )
    {
        if (empty($shopId)) {
            throw new InvalidArgumentException('shopId cannot be empty');
        }


        if (empty($secretKey)) {
            throw new InvalidArgumentException('Secret key cannot be empty');
        }

        $this->shopId = $shopId;
        $this->secretKey = $secretKey;
    }

    private function getSignature(string $data): string
    {
        return hash_hmac('sha256', $data, $this->secretKey);
    }

    /**
     * @throws Exception
     */
    private function makeApiRequest(string $endpoint, array $data): array
    {
        $jsonData = json_encode($data, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new RuntimeException('JSON encode error: ' . json_last_error_msg());
        }

        $curl = curl_init();

        $options = [
            CURLOPT_URL => self::BASE_API_URL . $endpoint,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => self::HTTP_MAX_REDIRECTS,
            CURLOPT_TIMEOUT => self::HTTP_TIMEOUT,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => $jsonData,
            CURLOPT_HTTPHEADER => [
                'Accept: application/json',
                'Content-Type: application/json',
                'Signature: ' . $this->getSignature($jsonData)
            ],
        ];

        curl_setopt_array($curl, $options);

        $response = curl_exec($curl);
        $error = curl_error($curl);
        $httpCode = curl_getinfo($curl, CURLINFO_HTTP_CODE);

        curl_close($curl);

        if ($error) {
            throw new RuntimeException('CURL error: ' . $error);
        }

        if ($httpCode !== 200) {
            throw new Exception("API returned HTTP code: {$httpCode}");
        }

        $decodedResponse = json_decode($response, true);

        if (json_last_error() !== JSON_ERROR_NONE) {
            throw new RuntimeException('JSON decode error: ' . json_last_error_msg());
        }

        return $decodedResponse;
    }

    /**
     * Create payment invoice
     *
     * @param int $price
     * @param int $payId
     * @param string $shop_id
     * @return array API response data
     * @throws Exception
     */
    public function createPayment(
        int $price,
        int $payId
    ): array
    {
        $successUrl = BASE_URL . "/result/success";
        $dataFields = [
            'sum' => $price,
            'orderId' => $payId,
            'shopId' => $this->shopId,
            'successUrl' => $successUrl
        ];

        try {
            $response = $this->makeApiRequest(self::CREATE_INVOICE_ENDPOINT, $dataFields);

            if (!isset($response['status'])) {
                throw new Exception('Invalid API response structure');
            }

            if ($response['status'] !== 200) {
                $errorMsg = $response['message'] ?? 'Unknown error';
                throw new Exception("API error: {$errorMsg}");
            }

            return $response['data'] ?? [];
        } catch (Exception $e) {
            throw new Exception('Payment creation failed: ' . $e->getMessage(), 0, $e);
        }
    }

    /**
     * Get invoice status
     *
     * @param array $data Request data (must contain invoice_id)
     * @return array Invoice status data
     * @throws Exception
     */
    public function getInvoiceStatus(array $data): array
    {
        if (!isset($data['invoice_id'])) {
            throw new InvalidArgumentException('invoice_id is required');
        }

        try {
            $response = $this->makeApiRequest(self::INVOICE_STATUS_ENDPOINT, $data);

            if (!isset($response['status'])) {
                throw new \Exception('Invalid API response structure');
            }

            if ($response['status'] !== 200) {
                $errorMsg = $response['message'] ?? 'Unknown error';
                throw new Exception("API error: {$errorMsg}");
            }

            return $response['data'] ?? [];
        } catch (Exception $e) {
            throw new Exception('Failed to get invoice status: ' . $e->getMessage(), 0, $e);
        }
    }
}
