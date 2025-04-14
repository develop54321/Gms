<?php

namespace components;

use core\BaseController;

class System extends BaseController
{

    function getIp()
    {
        if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
            $ip = $_SERVER['HTTP_CLIENT_IP'];
        } elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
            $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
        } else {
            $ip = $_SERVER['REMOTE_ADDR'];
        }
        return $ip;
    }

    function getCountry($ip)
    {
        $result = array('country' => '', 'city' => '');

        if (filter_var($ip, FILTER_VALIDATE_IP)) $ip = $ip;
        elseif (filter_var($ip, FILTER_VALIDATE_IP)) $ip = $ip;
        else $ip = $ip;
        $ip_data = @json_decode(file_get_contents("http://www.geoplugin.net/json.gp?ip=" . $ip));
        if ($ip_data && $ip_data->geoplugin_countryName != null) $result = $ip_data->geoplugin_countryCode;
        return $result;
    }

    public function getUrl()
    {
        $url = 'http' . ((isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') ? 's' : '') . '://';
        return $url . $_SERVER['SERVER_NAME'];
    }

    // Add function showbar
    public function showbar($players, $maxplayers): string
    {
        if ($maxplayers > 0) {
            $full_off = round(($players / $maxplayers) * 100);
        } else {
            $full_off = 0;
        }
        switch ($full_off) {
            case $full_off <= 40:
                $full_off_color = 'success';
                break;
            case $full_off <= 80:
                $full_off_color = 'warning';
                break;
            case $full_off <= 100:
                $full_off_color = 'danger';
                break;
            default:
                $full_off_color = 'success';
                break;
        }
        return $full_off . '%';
    }



    public function generateCharacter($number): string
    {
        $arr = array('a', 'b', 'c', 'd', 'e', 'f',
            'g', 'h', 'i', 'j', 'k', 'l',
            'm', 'n', 'o', 'p', 'r', 's',
            't', 'u', 'v', 'x', 'y', 'z',
            'A', 'B', 'C', 'D', 'E', 'F',
            'G', 'H', 'I', 'J', 'K', 'L',
            'M', 'N', 'O', 'P', 'R', 'S',
            'T', 'U', 'V', 'X', 'Y', 'Z',
            '1', '2', '3', '4', '5', '6',
            '7', '8', '9', '0', '.', ',',
            '(', ')', '[', ']', '!', '?',
            '&', '^', '%', '@', '*', '$',
            '<', '>', '/', '|', '+', '-',
            '{', '}', '`', '~');

        $pass = "";
        for ($i = 0; $i < $number; $i++) {

            $index = rand(0, count($arr) - 1);
            $pass .= $arr[$index];
        }
        return $pass;
    }

    public function generateRandomNumbers(int $limit): string
    {
        $randomDigits = '';

        for ($i = 0; $i < $limit; $i++) {
            $randomDigits .= rand(0, 9);
        }

        return $randomDigits;
    }

    public function generateCaptcha()
    {
        $randomnr = mt_rand(11111, 99999);
        $_SESSION['captcha'] = md5($randomnr);


        $im = imagecreatetruecolor(140, 38);


        $white = imagecolorallocate($im, 255, 255, 255);
        $grey = imagecolorallocate($im, 128, 128, 128);
        $black = imagecolorallocate($im, 0, 0, 0);

        imagefilledrectangle($im, 0, 0, 200, 35, $black);

        $font =  ROOT_DIR. 'public/fonts/captcha.ttf';

        imagettftext($im, 33, 0, 0, 35, $grey, $font, $randomnr);

        imagettftext($im, 33, 0, 0, 35, $white, $font, $randomnr);

        header("Expires: Wed, 1 Jan 1997 00:00:00 GMT");
        header("Last-Modified: " . gmdate("D, d M Y H:i:s") . " GMT");
        header("Cache-Control: no-store, no-cache, must-revalidate");
        header("Cache-Control: post-check=0, pre-check=0", false);
        header("Pragma: no-cache");


        imagegif($im);
        imagedestroy($im);
    }


}