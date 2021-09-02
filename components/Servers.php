<?php

namespace components;

class Servers
{
    public static function getImagePath($map_name, $game){
        $pathimg_map = 'public/img/maps/'.$game.'/'.$map_name.'.jpg';
        if(file_exists($pathimg_map)){
            $img_map = '/'.$pathimg_map;
        }else{
            $img_map = '/public/img/no_map.png';
        }

        return $img_map;
    }

}