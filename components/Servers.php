<?php

namespace components;

class Servers
{
    public static function getImagePath($map_name, $game){
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