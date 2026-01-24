<?php

namespace controllers\control;

use components\Pagination;
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
            $port = (int)$_POST['port'];
            $queryPort = $_POST['query_port'];
            $rating = $_POST['rating'];
            $host = $_POST['host'];
            $description = $_POST['description'];


            $banCause = null;
            $nowTime = time();

            $ban = $_POST['ban'];
            if ($ban === 1) $banCause = $_POST['ban_cause'];

            $sql = "UPDATE ga_servers SET 
                      status = :status, 
                      moderation =:moderation, 
                      game = :game,
                      ip = :ip, 
                      host = :host, 
                      description = :description, 
                      port = :port, 
                      query_port = :query_port, 
                      rating = :rating,
                      ban = :ban, 
                      ban_couse = :ban_couse,
                      ban_date = :ban_date
                  WHERE id= :id";

            $update = $this->db->prepare($sql);
            $update->bindParam(':status', $status);
            $update->bindParam(':moderation', $moderation);
            $update->bindParam(':game', $game);
            $update->bindParam(':ip', $ip);
            $update->bindParam(':host', $host);
            $update->bindParam(':description', $description);
            $update->bindParam(':port', $port);
            $update->bindParam(':query_port', $queryPort);
            $update->bindParam(':rating', $rating);
            $update->bindParam(':ban', $ban);
            $update->bindParam(':ban_couse', $banCause);
            $update->bindParam(':ban_date', $nowTime);
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

    public function editServices()
    {

        if (!parent::isAjax()) {
            parent::ShowError(404, "Страница не найдена!");
        }

        $id = isset($_GET['id']) ? (int)$_GET['id'] : 0;

        $stmt = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
        $stmt->execute([':id' => $id]);
        $server = $stmt->fetch();

        if (!$server) {
             parent::ShowError(404, "Страница не найдена!");
        }

        $currentDate = strtotime(date('Y-m-d'));
        $services = [
            'top'       => ['label' => 'TOP услуги'],
            'vip'       => ['label' => 'VIP услуги'],
            'gamemenu'  => ['label' => 'GameMenu услуги'],
            'color'     => ['label' => 'услуги выделения цветом'],
        ];


        foreach ($services as $key => &$service) {
            $enabledKey = "{$key}_enabled";
            $expiredKey = "{$key}_expired_date";

            $enabled = isset($_POST[$enabledKey]) ? (int)$_POST[$enabledKey] : null;
            $expired = !empty($_POST[$expiredKey]) ? strtotime($_POST[$expiredKey]) : null;

            if ($enabled === 0) {
                $expired = null;
            }

            // Если включена — проверяем корректность даты
            if ($enabled && $expired < $currentDate) {
                $answer['status'] = "error";
                $answer['error'] = "Ошибка: дата окончания {$service['label']} не может быть раньше текущей.";
                exit(json_encode($answer));
            }



            if ($enabled === 0) $enabled = null;

            $service['enabled'] = $enabled;
            $service['expired'] = $expired;
        }


        // Активация буста
        $boostPeriod = !empty($_POST['boost']) ? $_POST['boost'] : null;
        if ($boostPeriod) {
            $this->activationBoost($id, $boostPeriod, $server);
        }


        // Обновление данных в БД
        $sql = "
        UPDATE ga_servers SET 
            top_enabled = :top_enabled, 
            top_expired_date = :top_expired_date, 
            vip_enabled = :vip_enabled, 
            vip_expired_date = :vip_expired_date, 
            gamemenu_enabled = :gamemenu_enabled, 
            gamemenu_expired_date = :gamemenu_expired_date, 
            color_enabled = :color_enabled, 
            color_expired_date = :color_expired_date, 
            boost = :boost,
            ban = :ban,
            ban_couse = :ban_couse,
            ban_date = :ban_date
        WHERE id = :id";

        $stmt = $this->db->prepare($sql);
        $stmt->execute([
            ':top_enabled'             => $services['top']['enabled'],
            ':top_expired_date'        => $services['top']['expired'],
            ':vip_enabled'             => $services['vip']['enabled'],
            ':vip_expired_date'        => $services['vip']['expired'],
            ':gamemenu_enabled'        => $services['gamemenu']['enabled'],
            ':gamemenu_expired_date'   => $services['gamemenu']['expired'],
            ':color_enabled'           => $services['color']['enabled'],
            ':color_expired_date'      => $services['color']['expired'],
            ':boost'                   => $boostPeriod,
            ':ban'                     => $_POST['ban'] ?? 0,
            ':ban_couse'               => $_POST['ban_couse'] ?? '',
            ':ban_date'                => $_POST['ban_date'] ?? null,
            ':id'                      => $id
        ]);

        $answer['status'] = "success";
        $answer['success'] = "Услуги успешно изменены";
        exit(json_encode($answer));


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
