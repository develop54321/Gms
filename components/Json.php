<?php

namespace components;

class Json
{
    public static function jsonEncode($param){
        return json_encode($param, JSON_UNESCAPED_UNICODE);
    }

    public static function jsonDecode($param){
        return json_decode($param, true);
    }
}