<?php

namespace controllers\control;

use components\Pagination;
use components\User;
use core\BaseController;
use PDO;

class CommentsController extends AbstractController
{

    public function search()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }

        $title = "Поиск комментарии";


        $filter = [];
        $sql = '';

        if (isset($_GET['status']) && $_GET['status'] != '') {
            $filter['status'] = $_GET['status'];
            $moderation = strip_tags($_GET['status']);
            if (stristr($sql, "WHERE") == false) {
                $sql .= "WHERE moderation = '$moderation'";
            } else $sql .= " AND moderation = '$moderation'";
        } else $filter['status'] = '';

        $countComments = $this->db->query("SELECT * FROM ga_comments $sql");
        $count = $countComments->rowCount();

        $filter['count'] = $count;

        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count, 'no_rgp' => ''));

        $countComments = $countComments->fetchAll();
        $pagination_html = $result['ViewPagination'];


        $content = $this->view->renderPartial("comments/index", [
            'pagination_html' => $pagination_html,
            'filter' => $filter,
            'comments' => $countComments
        ]);


        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }


    public function index()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }

        $title = "Комментарии";
        $filter = [];

        $filter['address'] = '';
        $filter['status'] = '';

        $countComments = $this->db->query('SELECT * FROM ga_comments');
        $count = $countComments->rowCount();

        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $count));

        $sql = '
            SELECT gc.*, gs.ip, gs.port
            FROM ga_comments gc
            JOIN ga_servers gs ON gc.id_server = gs.id
            ORDER BY gc.id DESC
            LIMIT :start, :per_page';


        $stmt = $this->db->prepare($sql);

        $stmt->bindValue(':start', (int) $result['start'], PDO::PARAM_INT);
        $stmt->bindValue(':per_page', (int) $per_page, PDO::PARAM_INT);
        $stmt->execute();

        $getComments = $stmt->fetchAll(PDO::FETCH_ASSOC);


        $filter['count'] = count($getComments);

        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("comments/index", [
            'filter' => $filter,
            'comments' => $getComments,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }


    public function edit()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }

        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Изменение комментария #$id";

        $getInfoComments = $this->db->prepare('SELECT * FROM ga_comments WHERE id = :id');
        $getInfoComments->execute(array(':id' => $id));
        $getInfoComments = $getInfoComments->fetch();
        if (empty($getInfoComments)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {

            $moderation = (int)$_POST['moderation'];
            $id_user = (int)$_POST['id_user'];
            $id_server = (int)$_POST['id_server'];
            $text = $_POST['text'];

            $sql = "UPDATE ga_comments SET moderation =:moderation, id_user = :id_user, id_server = :id_server, text = :text WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':moderation', $moderation);
            $update->bindParam(':id_user', $id_user);
            $update->bindParam(':id_server', $id_server);
            $update->bindParam(':text', $text);
            $update->bindParam(':id', $id);
            $update->execute();

            $answer['status'] = "success";
            $answer['success'] = "Комментарий успешно изменен";
            exit(json_encode($answer));

        } else {


            $content = $this->view->renderPartial("comments/edit", ['data' => $getInfoComments]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }


    public function moderation()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }

        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
        $moderation = 1;
        $sql = "UPDATE ga_comments SET moderation =:moderation WHERE id= :id";
        $update = $this->db->prepare($sql);
        $update->bindParam(':moderation', $moderation);
        $update->bindParam(':id', $id);
        $update->execute();

        header("Location: /control/comments");


    }

    public function remove()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }


        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_comments WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

        }


    }


}
