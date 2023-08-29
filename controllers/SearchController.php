<?php

namespace controllers;

use core\BaseController;

class SearchController extends BaseController
{

    public function actionIndex()
    {

        $title = "Поиск сервера";
        $query = '';

        if (isset($_POST['query'])) $query = $_POST['query'];
        $query = explode(":", $query);
        if (!isset($query[1])) $query[1] = null;

        $getInfoServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
        $getInfoServers->bindValue(":ip", $query[0]);
        $getInfoServers->bindValue(":port", $query[1]);
        $getInfoServers->execute();
        $getServers = $getInfoServers->fetchAll();

        $content = $this->view->renderPartial("search", ['servers' => $getServers]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
}
    
