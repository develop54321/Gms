<?php

namespace widgets\pay_method;

use core\View;
use core\WidgetsInterface;

final class PatMethod implements WidgetsInterface
{

    public static function run($params)
    {
        $view = new View("widgets");
        $view->render('pay_method/views/index', ['value' => $params]);
    }
}