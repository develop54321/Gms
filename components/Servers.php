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

}