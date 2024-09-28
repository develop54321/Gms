<?php

namespace controllers;

use core\BaseController;

class BanlistController extends BaseController
{
    public function index()
    {
        $title = "Банлист";

        $getBannisterServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ban != :ban');
        $getBannisterServers->execute(array(':ban' => '0'));
        $getBannisterServers = $getBannisterServers->fetchAll();


        $content = $this->view->renderPartial("banlist", ['BannisterServers' => $getBannisterServers]);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
}