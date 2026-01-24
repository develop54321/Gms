<?php

namespace components;

use Exception;

class Servers
{

    public static function getIp(string $host): string
    {
        if (filter_var($host, FILTER_VALIDATE_IP)) {
            return $host;
        }

        if (filter_var($host, FILTER_VALIDATE_DOMAIN, FILTER_FLAG_HOSTNAME)) {
            $ip = gethostbyname($host);
            if ($ip === $host) {
                throw new Exception('Не удалось определить IP-адрес домена');
            }
            return $ip;
        }

        throw new Exception('Неверный IP-адрес или доменное имя');
    }

    public static function getImagePath($map_name, $game): string
    {
        $pathImgMap = 'public/img/maps/'.$game.'/'.$map_name.'.jpg';
        if(file_exists($pathImgMap)){
            $imgMap = '/'.$pathImgMap;
        }else{
            $imgMap = '/public/img/no_map.png';
        }

        return $imgMap;
    }


    public static function parseAddress($value): array
    {
        $explode = explode(":", $value);

        return ["ip" => $explode[0], "port" => $explode[1]];
    }


    public static function hiddenOwnerEmail(string  $value): string
    {
        list($username, $domain) = explode('@', $value);
        $usernameLength = strlen($username);

        $hiddenUsername = str_repeat('*', $usernameLength - 1) . substr($username, -1);

        return $hiddenUsername . '@' . $domain;
    }
}