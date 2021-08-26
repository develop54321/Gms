<?php
namespace widgets\user\status;

use core\BaseController;
use core\View;
use core\WidgetsInterface;

class Status implements WidgetsInterface
{

    public static function run($params = null){

        $view = new View("widgets");
        $view->render('user/status/views/index', ['role' => $params]);
    }
}