<?php

namespace widgets\flash;

use core\View;
use core\WidgetsInterface;

class Flash implements WidgetsInterface
{

    public static function run($params = null)
    {
        if (isset($_SESSION['flash'])) {
            $flash = $_SESSION['flash'];
            unset($_SESSION['flash']);


            $view = new View("widgets");
            $view->render('flash/views/index', ['flash' => $flash]);
        }
    }
}