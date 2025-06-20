<?php

namespace controllers;

use components\Pagination;
use core\BaseController;

class BanlistController extends BaseController
{
    private const PER_PAGE = 25;
    public function index()
    {
        $title = "Бан лист";

        $sort_where = array(':ban' => 0);

        $queryCount = $this->db->prepare('SELECT * FROM ga_servers WHERE ban != :ban');
        $queryCount->execute($sort_where);
        $count = $queryCount->rowCount();



        $pagination = new Pagination();
        $per_page = self::PER_PAGE;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));



        $getServers = $this->db->prepare('SELECT * FROM ga_servers WHERE ban != :ban LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getServers->execute($sort_where);
        $getServers = $getServers->fetchAll();

        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("banlist", ['servers' => $getServers, 'pagination_html' => $pagination_html]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }
}