<?php

namespace controllers\control;


use components\Pagination;
use components\User;
use core\BaseController;
use PDO;

class UsersController extends AbstractController
{

    public function search()
    {
        $title = "Поиск пользователя";

        if (isset($_POST['query'])) {
            $query = $_POST['query'];


            $getUsers = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email ');
            $getUsers->bindValue(":email", $query);
            $getUsers->execute();
            $getUsers = $getUsers->fetchAll();

            $content = $this->view->renderPartial("users/index", ['users' => $getUsers, 'action' => 'search']);
        }

        $this->view->render("main", ['content' => $content, 'title' => $title]);
    }


    public function index()
    {
        $title = "Пользователи";


        $countUsers = $this->db->query('SELECT * FROM ga_users');
        $countUsers = $countUsers->rowCount();


        $pagination = new Pagination();
        $per_page = 15;
        $result = $pagination->create(array('per_page' => $per_page, 'count' => $countUsers));

        $getUsers = $this->db->query('SELECT * FROM ga_users ORDER BY id DESC LIMIT ' . $result['start'] . ', ' . $per_page . '');
        $getUsers = $getUsers->fetchAll();

        $pagination_html = $result['ViewPagination'];

        $content = $this->view->renderPartial("users/index", [
            'users' => $getUsers,
            'pagination_html' => $pagination_html
        ]);

        $this->view->render("main", ['content' => $content, 'title' => $title]);


    }

    public function remove()
    {
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_users WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();

        }


    }


    public function edit()
    {
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';

        $title = "Изменение пользователя #$id";

        $getInfoUser = $this->db->prepare('SELECT * FROM ga_users WHERE id = :id');
        $getInfoUser->execute(array(':id' => $id));
        $getInfoUser = $getInfoUser->fetch();
        if (empty($getInfoUser)) parent::ShowError(404, "Страница не найдена!");


        if (parent::isAjax()) {

            $firstname = $_POST['firstname'];
            $lastname = $_POST['lastname'];
            $email = $_POST['email'];
            $password = $_POST['password'];
            $role = $_POST['role'];
            $balance = (int)$_POST['balance'];

            if (isset($_POST['api_login'])) $api_login = $_POST['api_login']; else $api_login = '';

            $params = '';
            if (isset($_POST['api'])) {
                $api = $_POST['api'];
                $params = json_encode(['key_api' => $api['key'], 'discount_api' => $api['discount']]);
            }


            $sql = "UPDATE ga_users SET firstname = :firstname, lastname = :lastname, email = :email, role = :role, balance = :balance, params = :params, api_login = :api_login WHERE id = :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':firstname', $firstname);
            $update->bindParam(':lastname', $lastname);
            $update->bindParam(':email', $email);
            $update->bindParam(':role', $role);
            $update->bindParam(':balance', $balance);
            $update->bindParam(':api_login', $api_login);
            $update->bindParam(':params', $params);
            $update->bindParam(':id', $id);
            $update->execute();

            if (!empty($password)) {
                $password = password_hash($password, PASSWORD_DEFAULT);
                $sql = "UPDATE ga_users SET password = :password WHERE id = :id";
                $update = $this->db->prepare($sql);
                $update->bindParam(':password', $password);
                $update->bindParam(':id', $id);
                $update->execute();
            }

            $answer['status'] = "success";
            $answer['success'] = "Пользователь успешно изменен";
            exit(json_encode($answer));

        } else {

            $api_params = $getInfoUser['params'] ? json_decode($getInfoUser['params'], true) : ['discount_api' => null, 'key_api' => null];
            $content = $this->view->renderPartial("users/edit", ['data' => $getInfoUser, 'api_params' => $api_params]);

            $this->view->render("main", ['content' => $content, 'title' => $title]);

        }
    }

}
