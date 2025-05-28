<?php
namespace widgets\server\hostname;

use core\BaseController;
use core\View;
use core\WidgetsInterface;

class Hostname implements WidgetsInterface
{

    public static function run($params = null){
        $view = new View("widgets");
        $view->render('server/hostname/views/index', ['value' => $params]);
    }
}