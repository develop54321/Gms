<?php

declare(strict_types=1);

namespace widgets\dark\user\top_menu;

use components\User;
use core\BaseController;
use core\View;
use core\WidgetsInterface;

class TopMenu implements WidgetsInterface
{
    public static function run($params = null){
        $userData = null;
        $user = new User();
        if ($user->isAuth()){
            $userData = $user->getProfile();
        }

        $view = new View("widgets");
        $view->render('dark/user/top_menu/views/index', ['userData' => $userData]);
    }
}