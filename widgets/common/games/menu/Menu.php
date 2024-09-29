<?php

namespace widgets\common\games\menu;

use core\Database;
use core\View;
use core\WidgetsInterface;

class Menu implements WidgetsInterface
{

    public static function run($params = null){
        $db = new Database();

        $getGames = $db->prepare('SELECT id, game, code FROM ga_games WHERE status = :status');
        $getGames->execute([':status' => 1]);
        $getGames = $getGames->fetchAll();



        $view = new View("widgets");
        $view->render('common/games/menu/views/index', [
            "games" => $getGames
        ]);
    }
}