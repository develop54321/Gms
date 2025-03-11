<?php

namespace controllers\control;

use components\Pagination;
use components\User;
use core\BaseController;
use PDO;

class ServersController extends AbstractController
{
    private const PER_PAGE = 20;

    public function search()
    {
        $title = "Поиск сервера";


        $filter = [];
        $sql = '';

        if (isset($_GET['address']) && $_GET['address'] != '') {
            $address = strip_tags($_GET['address']);
            $filter['address'] = $address;
            $query = explode(":", $address);
            if (!isset($query[1])) $query[1] = null;
            $sql .= "WHERE ip = '" . $query[0] . "' and port = '" . $query[1] . "'";
        } else $filter['address'] = '';


        if (isset($_GET['status']) && $_GET['status'] != '') {
            $filter['status'] = $_GET['status'];
            $moderation = strip_tags($_GET['status']);
            if (stristr($sql, "WHERE") == false) {
                $sql .= "WHERE moderation = '$moderation'";
            } else $sql .= " AND moderation = '$moderation'";
        } else $filter['status'] = '';

        $countServers = $this->db->query("SELECT * FROM ga_servers $sql");
        $count = $countServers->rowCount();

        $filter['count'] = $count;

        $pagination = new Pagination();
        $per_page = self::PER_PAGE;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count, 'no_rgp' => ''));

        $getServers = $this->db->query("SELECT * FROM ga_servers $sql ORDER BY vip_enabled DESC, rating DESC, players DESC LIMIT " . $result['start'] . ", " . $per_page . "");
        $getServers = $getServers->fetchAll();


        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("servers/index", [
            'pagination_html' => $pagination_html,
            'filter' => $filter,
            'servers' => $getServers
        ]);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }


    public function index()
    {


        $title = "Сервера";


        $filter = [];

        $filter['address'] = '';
        $filter['status'] = '';


        $countServers = $this->db->prepare('SELECT * FROM ga_servers WHERE status = :status');
        $countServers->execute(array(':status' => 1));
        $count = $countServers->rowCount();


        $pagination = new Pagination();
        $per_page = self::PER_PAGE;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));

        $getServers = $this->db->query('SELECT * FROM ga_servers LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getServers = $getServers->fetchAll();
        $filter['count'] = count($getServers);

        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("servers/index", [
            'filter' => $filter,
            'servers' => $getServers,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }


    public function edit()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $settings = json_decode($settings['content'], true);

        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Изменение сервера #$id";

        $getInfoServerS = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $getInfoServerS->execute(array(':id' => $id));
        $getInfoServerS = $getInfoServerS->fetch();
        if (empty($getInfoServerS)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {
            $status = (int)$_POST['status'];
            $moderation = (int)$_POST['moderation'];
            $game = $_POST['game'];
            $ip = $_POST['ip'];
            $port = $_POST['port'];
            $rating = $_POST['rating'];
            $delite_services = $_POST['delite_services'];
            if ($delite_services == 0) {
                $top_expired_date = 0;
                $top_enabled = $_POST['top_enabled'];
                if ($top_enabled != 0) $top_expired_date = strtotime($_POST['top_expired_date']);


                $gamemenu_expired_date = 0;
                $gamemenu_enabled = $_POST['gamemenu_enabled'];
                if ($gamemenu_enabled != 0) $gamemenu_expired_date = strtotime($_POST['gamemenu_expired_date']);

                //  $vip_expired_date = 0;
                //   $vip_enabled = $_POST['vip_enabled'];
                //  if ($vip_enabled != 0) $vip_expired_date = strtotime(date('Y-m-d', strtotime($_POST['vip_expired_date'])));





                if ($_POST['vip_enabled'] == "0"){
                    $vip_enabled = 0;
                    $vip_expired_date = 0;
                }else{

                    $vip_enabled = $_POST['vip_enabled'];
                    $vip_expired_date = strtotime(date('Y-m-d', strtotime($_POST['vip_expired_date'])));
                }

                if ($_POST['color_enabled'] === null or $_POST['color_enabled'] === ""){
                    $color_enabled = 0;
                    $color_expired_date = 0;
                }else{
                    $color_enabled = $_POST['color_enabled'];
                    $color_expired_date = strtotime(date('Y-m-d', strtotime($_POST['color_expired_date'])));
                }





                if (!empty($_POST['boost'])) {
                    $period = $_POST['boost'];
                    $this->activationBoost($id, $period, $getInfoServerS);
                }
            } else {
                $top_enabled = 0;
                $top_expired_date = 0;
                $period = 0;
                $vip_enabled = 0;
                $vip_expired_date = 0;
                $gamemenu_enabled = 0;
                $gamemenu_expired_date = 0;
                $color_enabled = 0;
                $color_expired_date = 0;
            }
            $ban = $_POST['ban'];
            if ($ban == 1) {
                $ban_couse = $_POST['ban_couse'];
                $ban_date = time();
            } else {
                $ban_couse = null;
                $ban_date = null;
            }

            $sql = "UPDATE ga_servers SET status = :status, moderation =:moderation, game = :game, ip = :ip, port = :port, rating = :rating, top_enabled = :top_enabled, top_expired_date = :top_expired_date, boost = :boost, vip_enabled = :vip_enabled, vip_expired_date = :vip_expired_date, gamemenu_enabled = :gamemenu_enabled, gamemenu_expired_date = :gamemenu_expired_date, color_enabled = :color_enabled, color_expired_date = :color_expired_date, ban = :ban, ban_couse = :ban_couse, ban_date = :ban_date WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':status', $status);
            $update->bindParam(':moderation', $moderation);
            $update->bindParam(':game', $game);
            $update->bindParam(':ip', $ip);
            $update->bindParam(':port', $port);
            $update->bindParam(':rating', $rating);
            $update->bindParam(':top_enabled', $top_enabled);
            $update->bindParam(':top_expired_date', $top_expired_date);
            $update->bindParam(':boost', $period);
            $update->bindParam(':vip_enabled', $vip_enabled);
            $update->bindParam(':vip_expired_date', $vip_expired_date);
            $update->bindParam(':gamemenu_enabled', $gamemenu_enabled);
            $update->bindParam(':gamemenu_expired_date', $gamemenu_expired_date);
            $update->bindParam(':color_enabled', $color_enabled);
            $update->bindParam(':color_expired_date', $color_expired_date);
            $update->bindParam(':ban', $ban);
            $update->bindParam(':ban_couse', $ban_couse);
            $update->bindParam(':ban_date', $ban_date);
            $update->bindParam(':id', $id);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Сервер успешно изменен";
            exit(json_encode($answer));

        } else {

            $getGames = $this->db->query('SELECT * FROM ga_games WHERE status ="1"');
            $getGames = $getGames->fetchAll();


            $topPlaces = [];
            for ($i = 1; $i <= $settings['global_settings']['count_servers_top']; $i++) {
                $isPlace = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                $isPlace->execute(array(':top_enabled' => $i));
                if ($isPlace->rowCount() != '0') {
                    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE top_enabled = :top_enabled');
                    $getInfoServer->execute(array(':top_enabled' => $i));
                    $getInfoServer = $getInfoServer->fetch();

                    if ($getInfoServerS['top_enabled'] == $i) {
                        $currentServer = true;
                    } else {
                        $currentServer = false;
                    }

                    $topPlaces[] = ['id' => $i, 'status' => 1, 'currentServer' => $currentServer];
                } else {
                    $topPlaces[] = ['id' => $i, 'status' => 0, 'currentServer' => false];
                }

            }


            $content = $this->view->renderPartial("servers/edit", ['topPlaces' => $topPlaces, 'data' => $getInfoServerS, 'games' => $getGames]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_servers WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }


    }


    private function activationBoost($id, $period, $getInfoServer)
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();

        if ($getInfoServer['boost'] != '0') {

            $this->db->query("UPDATE ga_servers SET boost = $period WHERE id = '" . $id . "'");

        } else {

            $countBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost');
            $countBoostServers->execute(array(':boost' => 0));
            $countBoostServers = $countBoostServers->rowCount();

            $getBoostServers = $this->db->prepare('SELECT id, hostname, boost FROM ga_servers WHERE boost != :boost ORDER BY boost_position ASC');
            $getBoostServers->execute(array(':boost' => 0));
            $getBoostServers = $getBoostServers->fetchAll();

            if ($countBoostServers == $settings['count_servers_boost']) {
                foreach ($getBoostServers as $row) {
                    if ($row['boost'] == '1') {
                        $zero = 0;
                        $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
                        $update = $this->db->prepare($sql);
                        $update->bindParam(':boost', $zero);
                        $update->bindParam(':boost_position', $zero);
                        $update->bindParam(':id', $row['id']);
                        $update->execute();
                        break;
                    } else {
                        $boost_position = time() + 1;
                        $this->db->query("UPDATE ga_servers SET boost = boost-1, boost_position = $boost_position WHERE id = '" . $row['id'] . "'");
                    }
                }

                $boost_position = time();
                $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':boost', $period);
                $update->bindParam(':boost_position', $boost_position);
                $update->bindParam(':id', $id);
                $update->execute();
            } else {

                $boost_position = time();
                $sql = "UPDATE ga_servers SET boost = :boost, boost_position = :boost_position WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':boost', $period);
                $update->bindParam(':boost_position', $boost_position);
                $update->bindParam(':id', $id);
                $update->execute();
            }
        }
    }

}
