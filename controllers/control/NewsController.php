<?php

namespace controllers\control;

use components\Pagination;
use components\User;
use core\BaseController;
use PDO;

class NewsController extends AbstractController
{


    public function index()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }
        $getUserProfile = $user->getProfile();
        if ($getUserProfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");

        $title = "Новости";


        $countComments = $this->db->query('SELECT * FROM ga_news');
        $count = $countComments->rowCount();


        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));

        $getNews = $this->db->query('SELECT * FROM ga_news ORDER BY id DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getNews = $getNews->fetchAll();


        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("news/index", [
            'news' => $getNews,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);

    }

    public function add()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }

        $getUserProfile = $user->getProfile();
        if ($getUserProfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");

        $title = "Новый пост";


        if (parent::isAjax()) {

            $titlePage = $_POST['title'];
            $text = $_POST['text'];


            $this->db->exec("INSERT INTO ga_news (title, text, date_create) 
            VALUES('$titlePage', '$text', '" . time() . "')");


            $answer['status'] = "success";
            $answer['success'] = "Пост успешно опубликован";
            exit(json_encode($answer));

        } else {


            $content = $this->view->renderPartial("news/add", []);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function edit()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Изменение поста #$id";

        $getInfoPost = $this->db->prepare('SELECT * FROM ga_news WHERE id = :id');
        $getInfoPost->execute(array(':id' => $id));
        $getInfoPost = $getInfoPost->fetch();
        if (empty($getInfoPost)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {

            $titlePage = $_POST['title'];
            $text = $_POST['text'];
            $dateCreate = strtotime($_POST['date_create']);


            $sql = "UPDATE ga_news SET title = :title, text = :text, date_create = :date_create WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':title', $titlePage);
            $update->bindParam(':text', $text);
            $update->bindParam(':date_create', $dateCreate);
            $update->bindParam(':id', $id);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Пост успешно изменен";
            exit(json_encode($answer));

        } else {


            $content = $this->view->renderPartial("news/edit", ['data' => $getInfoPost]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_news WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

        }

        parent::ShowError(400, "Bad request!");

    }


}