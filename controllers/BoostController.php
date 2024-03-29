<?php

namespace controllers;

use core\BaseController;
use components\System;

class BoostController extends BaseController
{


    public function index()
    {
        $title = "Раскрутка";

        $getBoostServers = $this->db->prepare('SELECT * FROM ga_servers WHERE boost != :boost and status = :status ORDER BY boost_position DESC');
        $getBoostServers->execute(array(':boost' => 0, ':status' => 1));
        $getBoostServers = $getBoostServers->fetchAll();


        $content = $this->view->renderPartial("boost", ['boostServers' => $getBoostServers]);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }


}