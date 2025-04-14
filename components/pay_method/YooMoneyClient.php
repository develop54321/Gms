<?php

namespace components\pay_method;

class YooMoneyClient
{
    private $receiver;
    private $price;
    private $payId;

    private $description;

    private const URL = "https://yoomoney.ru/quickpay/confirm.xml";

    public function __construct($receiver, $price, $payId, $description)
    {
        $this->receiver = $receiver;
        $this->price = $price;
        $this->payId = $payId;
        $this->description = $description;
    }

    public function getHtmlForm(): string
    {
        $successUrl = BASE_URL . "/result/success";
        $form = '<form id="paymentForm" method="GET" action="'.self::URL.'" target="_blank">';
        $form .= '<input type="hidden" name="receiver" value="' . $this->receiver . '" />';
        $form .= '<input type="hidden" name="quickpay-form" value="donate" />';
        $form .= '<input type="hidden" name="targets" value="' . $this->description . '" />';
        $form .= '<input type="hidden" name="sum" value="' . $this->price . '" />';
        $form .= '<input type="hidden" name="label" value="' . $this->payId . '" />';
        $form .= '<input type="hidden" name="successURL" value="' . $successUrl . '" />';
        $form .= '</form>';

        return $form;
    }

}