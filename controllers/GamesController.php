<?php

namespace controllers;

use components\Pagination;
use components\Servers;
use core\BaseController;

class GamesController extends BaseController
{
    public function view($code)
    {
        $getGame = $this->db->prepare('SELECT id, code, game FROM ga_games WHERE code = :code');
        $getGame->execute([':code' => $code]);
        $getGame = $getGame->fetch();


        if (!$getGame) parent::ShowError(404, "Страница не найдена!");

        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);
        $title = $settings['global_settings']['site_name'] . " :: " . $getGame['game'];

        $topServers = [];
        for ($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++) {
            $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
            $isPlace->execute(array(':top_enabled' => $i));
            if ($isPlace->rowCount() != '0') {
                $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                $getInfoServer->execute(array(':top_enabled' => $i));
                $getInfoServer = $getInfoServer->fetch();


                $img_map = Servers::getImagePath($getInfoServer['map'], $getInfoServer['game']);


                $topServers[] = [
                    'id' => $getInfoServer['id'],
                    'ip' => $getInfoServer['ip'],
                    'port' => $getInfoServer['port'],
                    'hostname' => $getInfoServer['hostname'],
                    'img_map' => $img_map,
                    'map' => $getInfoServer['map'],
                    'players' => $getInfoServer['players'],
                    'max_players' => $getInfoServer['max_players'],
                    'color_enabled' => $getInfoServer['color_enabled'],
                    'status' => $getInfoServer['status']
                ];
            } else {
                $img_map = '/public/img/no_map.png';
                $topServers[] = [
                    'id' => '',
                    'hostname' => 'Место свободно',
                    'ip' => '127.0.1',
                    'port' => 27015,
                    'img_map' => $img_map,
                    'map' => null,
                    'players' => 0,
                    'max_players' => 0,
                    'color_enabled' => null,
                    'status' => 0
                ];
            }

        }

        $game = $getGame['code'];
        $sort = "and game = :game";
        $sort_where = array(':status' => 1, ':ban' => 0, ':game' => $game);
        $countServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ban = :ban and status = :status and game = :game');
        $countServers->execute(array(':ban' => 1, ':status' => 0, ':game' => $game));

        $count = $countServers->rowCount();

        $pagination = new Pagination();
        $per_page = $settings['global_settings']['count_servers_main'];
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));


        $getServers = $this->db->prepare('SELECT * FROM ga_servers WHERE status = :status and ban = :ban ' . $sort . ' and hostname != "" ORDER BY vip_enabled DESC, rating DESC, players DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getServers->execute($sort_where);
        $getServers = $getServers->fetchAll();


        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("servers_top", ['topServers' => $topServers, 'settings' => $settings]);
        $content .= $this->view->renderPartial("servers_list", ['servers' => $getServers,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

}