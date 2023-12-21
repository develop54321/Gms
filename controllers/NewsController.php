<?php

namespace controllers;


use core\BaseController;

class NewsController extends BaseController
{
    public function index()
    {
        $title = "Новости";



        $getNews = $this->db->query('SELECT * FROM ga_news ORDER BY id DESC');
        $getNews = $getNews->fetchAll();


        $content = $this->view->renderPartial("news/index", ['news' => $getNews]);




        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

}