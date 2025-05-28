<?php

namespace controllers\control;

use components\Pagination;
use PDO;

class PagesController extends AbstractController
{
    public function index()
    {
        $title = "Страницы";

        $countComments = $this->db->query('SELECT * FROM ga_pages');
        $count = $countComments->rowCount();


        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));

        $getComments = $this->db->query('SELECT * FROM ga_pages ORDER BY id DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getComments = $getComments->fetchAll();

        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("pages/index", [
            'comments' => $getComments,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }

    public function add()
    {
        $title = "Добавление страницы";
        if (parent::isAjax()) {
            $titlePage = $_POST['title'];
            $text = $_POST['text'];

            $this->db->exec("INSERT INTO ga_pages (title, text, date_create) 
            VALUES('$titlePage', '$text', '" . time() . "')");


            $answer['status'] = "success";
            $answer['success'] = "Страница успешно добавлена";
            exit(json_encode($answer));

        } else {


            $content = $this->view->renderPartial("pages/add", []);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function edit()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Изменение страницы #$id";

        $getInfoPage = $this->db->prepare('SELECT * FROM ga_pages WHERE id = :id');
        $getInfoPage->execute(array(':id' => $id));
        $getInfoPage = $getInfoPage->fetch();
        if (empty($getInfoPage)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {

            $titlePage = $_POST['title'];
            $text = $_POST['text'];


            $sql = "UPDATE ga_pages SET title = :title, text =:text WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':title', $titlePage);
            $update->bindParam(':text', $text);
            $update->bindParam(':id', $id);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Страница успешно изменена";
            exit(json_encode($answer));

        } else {


            $content = $this->view->renderPartial("pages/edit", ['data' => $getInfoPage]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_pages WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }


    }


}