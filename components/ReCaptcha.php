<?php

namespace components;

class ReCaptcha
{
    private $recaptcha;
    private $system;

    public function __construct()
    {
        $this->recaptcha = new \ReCaptcha\ReCaptcha(RECAPTCHA_SECRET_KEY);
        $this->system = new System();
    }

    public function verify($gRecaptchaResponse){
        $resp = $this->recaptcha->setExpectedHostname('gms.loc')
            ->setScoreThreshold(0.8)
            ->verify($gRecaptchaResponse, $this->system->getIp());

        if ($resp->isSuccess()) {
           return true;
        } else {
            return $this->handleErrors($resp->getErrorCodes());
        }
    }

    private function handleErrors($errors): string{
        return $errors[0];
    }

}