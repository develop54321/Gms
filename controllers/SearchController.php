<?php

namespace controllers;

use core\BaseController;

class SearchController extends BaseController
{

    public function index()
    {

        $title = "Поиск сервера";
        $query = null;
        $getServers = null;

        if ($this->isPostRequest() && isset($_POST['query'])){
            $query = $_POST['query'];
            $query = explode(":", $query);
            if (!isset($query[1])) $query[1] = null;


            $getInfoServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ip = :ip and port = :port');
            $getInfoServers->execute(array(':ip' => $query[0], ':port' => (int)$query[1]));
            $getServers = $getInfoServers->fetchAll();
        }




        $content = $this->view->renderPartial("search", ['servers' => $getServers, 'query' => $query]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
}

