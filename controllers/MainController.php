<?php

namespace controllers;

use components\Pagination;
use components\Servers;
use components\System;
use core\BaseController;
use PDO;
use xPaw\SourceQuery\SourceQuery;

class MainController extends BaseController
{


    public function captcha()
    {
        $system = new System();
        $system->generateCaptcha();
    }

    public function index()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);
        $title = $settings['global_settings']['site_name'] . " :: Главная";

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

        $sort = '';
        if (isset($_GET['game'])) {
            $game = $_GET['game'];
            $sort = "and game = :game";
            $sort_where = array(':status' => 1, ':ban' => 0, ':game' => $game);
            $countServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ban = :ban and status = :status and game = :game');
            $countServers->execute(array(':ban' => 1, ':status' => 0, ':game' => $game));
        } else {
            $sort_where_count = array(':ban' => 0, ':status' => 1);
            $sort_where = array(':status' => 1, ':ban' => 0);
            $countServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ban = :ban and status = :status');
            $countServers->execute($sort_where_count);

        }
        $count = $countServers->rowCount();

        $pagination = new Pagination();
        $per_page = $settings['global_settings']['count_servers_main'];
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));




        $getServers = $this->db->prepare('SELECT * FROM ga_servers WHERE status = :status and ban = :ban ' . $sort . ' ORDER BY vip_enabled DESC, rating DESC, players DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getServers->execute($sort_where);
        $getServers = $getServers->fetchAll();


        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("servers_top", ['topServers' => $topServers, 'settings' => $settings]);
        $content .= $this->view->renderPartial("servers_list", ['servers' => $getServers,
            'pagination_html' => $pagination_html
        ]);



        $this->view->render("main", ['content' => $content, 'title' => $title]);

    }


    public function stats()
    {

        $count_uq16 = [];

        for ($x = 0; $x <= 6; $x++) {
            $m = date("m", strtotime("-$x day"));
            $m2 = date("Y", strtotime("-$x day"));
            $m3 = date("d", strtotime("-$x day"));


            $stmt = $this->db->prepare("SELECT COUNT(DISTINCT CONCAT(`ip`,':',`port`)) AS `unique` FROM `mslog` WHERE timeyear = :year AND timemonth = :month AND timeday = :day AND type = 'cs'");


            $stmt->bindParam(':year', $m2, PDO::PARAM_STR);
            $stmt->bindParam(':month', $m, PDO::PARAM_STR);
            $stmt->bindParam(':day', $m3, PDO::PARAM_STR);


            $stmt->execute();


            $row = $stmt->fetch(PDO::FETCH_ASSOC);

            $count_uq16[] = $row['unique'];
        }


        $uq_reverse = array_reverse($count_uq16);


        if (!empty($uq_reverse)) {
            $str = "data: [" . implode(", ", $uq_reverse) . "]";

        } else {
            $str = "data: []";
        }


        $content = $this->view->renderPartial("stats", ["str" => $str]);

        $this->view->render("main", ['content' => $content, 'title' => "Статистика мастер сервера"]);
    }
}