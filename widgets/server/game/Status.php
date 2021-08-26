<?php
namespace widgets\server\game;

use core\BaseController;
use core\View;
use core\WidgetsInterface;

class Status implements WidgetsInterface
{

    public static function run($params = null){

        $view = new View("widgets");
        $view->render('server/game/views/index', ['game' => $params]);
    }
}