<?php

namespace controllers;


use core\BaseController;

class NewsController extends BaseController
{
    public function actionIndex()
    {
        $title = "Новости";


        $content = $this->view->renderPartial("news/index", []);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

}