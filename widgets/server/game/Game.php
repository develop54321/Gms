<?php

namespace widgets\server\game;

use core\View;
use core\WidgetsInterface;

class Game implements WidgetsInterface
{

    public static function run($params = null){


        echo $params;
    }
}