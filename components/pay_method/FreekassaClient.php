<?php

namespace components\pay_method;

class FreekassaClient
{
    private $fkId;
    private $price;
    private $payId;
    private $signFk;

    public function __construct($fkId, $price, $payId, $signFk)
    {
        $this->fkId = $fkId;
        $this->price = $price;
        $this->payId = $payId;
        $this->signFk = $signFk;
    }

    public function getHtmlForm(): string
    {
        $form = '<form id="paymentForm" method="GET" action="https://pay.fk.money/" target="_blank">';
        $form .= '<input type="hidden" name="m" value="' . $this->fkId . '" />';
        $form .= '<input type="hidden" name="oa" value="' . $this->price . '" />';
        $form .= '<input type="hidden" name="currency" value="RUB" />';
        $form .= '<input type="hidden" name="o" value="' . $this->payId . '" />';
        $form .= '<input type="hidden" name="s" value="' . $this->signFk . '" />';
        $form .= '</form>';

        return $form;
    }

    public function submitForm()
    {
        $js = '<script type="text/javascript">';
        $js .= 'document.getElementById("paymentForm").submit();';
        $js .= '</script>';

        return $js;
    }
}

?>