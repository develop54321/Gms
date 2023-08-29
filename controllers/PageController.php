<?php

namespace controllers;

use core\BaseController;

class PageController extends BaseController
{


    public function actionIndex()
    {
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();


        if (isset($_GET['id'])) $id = (int)$_GET['id'];
        else parent::ShowError(404, "Страница не найдена!");

        $getPageContent = $this->db->prepare('SELECT * FROM ga_pages WHERE id = :id');
        $getPageContent->execute(array(':id' => $id));
        $getPageContent = $getPageContent->fetch();


        $title = $getPageContent['title'];


        $content = $this->view->renderPartial("page/index", ['data' => $getPageContent]);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

}