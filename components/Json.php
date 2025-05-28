<?php

namespace components;

class Json
{
    public static function encode($param){
        return json_encode($param, JSON_UNESCAPED_UNICODE);
    }

    public static function decode($param){
        return json_decode($param, true);
    }
}