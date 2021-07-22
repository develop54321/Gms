<?php
namespace widgets\servers\status;

use core\BaseController;
use core\View;
use core\WidgetsInterface;

class Status implements WidgetsInterface
{

    public static function run($params = null){

        $view = new View("widgets");
        $view->render('servers/status/views/index', ['game' => $params]);
    }
}