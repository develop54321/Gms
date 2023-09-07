<?php

namespace controllers;

use core\BaseController;

class PageController extends BaseController
{


    public function index($id)
    {
        $getPageContent = $this->db->prepare('SELECT * FROM ga_pages WHERE id = :id');
        $getPageContent->execute(array(':id' => $id));
        $getPageContent = $getPageContent->fetch();

        if (!$getPageContent)  parent::ShowError(404, "Страница не найдена!");


        $title = $getPageContent['title'];


        $content = $this->view->renderPartial("page/index", ['data' => $getPageContent]);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

}