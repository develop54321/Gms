<?php

namespace controllers\control;

use components\User;
use core\BaseController;
use PDO;

class CodecolorsController extends BaseController
{


    public function actionIndex()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }
        $getUserPrfile = $user->getProfile();
        if ($getUserPrfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");
        $title = "Цвета";
        $activcolor = 1;
        $getCodeColors = $this->db->prepare('SELECT * FROM ga_code_colors WHERE activ = :activ');
        $getCodeColors->execute(array(':activ' => $activcolor));
        $getCodeColors = $getCodeColors->fetchAll();
        $content = $this->view->renderPartial("control/codecolors/index", ['CodeColors' => $getCodeColors]);
        $this->view->render("control/main", ['content' => $content, 'title' => $title]);
    }

    public function actionAdd()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }
        $getUserPrfile = $user->getProfile();
        if ($getUserPrfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");
        $getSettings = $this->db->query('SELECT * FROM ga_settings');
        $settings = $getSettings->fetch();
        $title = "Добавление нового цвета";
        if (parent::isAjax()) {
            $activ = strip_tags($_POST['activ']);
            $name = strip_tags($_POST['name']);
            $code = strip_tags($_POST['code']);
            $this->db->exec("INSERT INTO ga_code_colors (name, code, activ) 
			VALUES('$name', '$code', '$activ')");
            $answer['status'] = "success";
            $answer['success'] = "Цвет успешно добавлен";
            exit(json_encode($answer));
        } else {
            $content = $this->view->renderPartial("control/codecolors/add", []);
            $this->view->render("control/main", ['content' => $content, 'title' => $title]);
        }
    }

    public function actionEdit()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }
        $getUserPrfile = $user->getProfile();
        if ($getUserPrfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");
        if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
        $title = "Изменение цвета";
        $getInfoCodeColors = $this->db->prepare('SELECT * FROM ga_code_colors WHERE id = :id');
        $getInfoCodeColors->execute(array(':id' => $id));
        $getInfoCodeColors = $getInfoCodeColors->fetch();
        if (empty($getInfoCodeColors)) parent::ShowError(404, "Страница не найдена!");
        if (parent::isAjax()) {
            $code = $_POST['code'];
            $name = $_POST['name'];
            $activ = $_POST['activ'];
            $sql = "UPDATE ga_code_colors SET code =:code, name = :name, activ = :activ WHERE id= :id";
            $update = $this->db->prepare($sql);
            $update->bindParam(':code', $code);
            $update->bindParam(':name', $name);
            $update->bindParam(':activ', $activ);
            $update->bindParam(':id', $id);
            $update->execute();
            $answer['status'] = "success";
            $answer['success'] = "Цвет успешно изменен";
            exit(json_encode($answer));
        } else {
            $content = $this->view->renderPartial("control/codecolors/edit", ['data' => $getInfoCodeColors]);
            $this->view->render("control/main", ['content' => $content, 'title' => $title]);
        }
    }


    public function actionRemove()
    {
        $user = new User();
        if (!$user->isAuth()) {
            header("Location: /control/index");
        }
        $getUserPrfile = $user->getProfile();
        if ($getUserPrfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");
        if (parent::isAjax()) {
            if (isset($_GET['id'])) $id = (int)$_GET['id']; else $id = '';
            $sql = "DELETE FROM ga_code_colors WHERE id =  :id";
            $stmt = $this->db->prepare($sql);
            $stmt->bindParam(':id', $id, PDO::PARAM_INT);
            $stmt->execute();
        }
    }


}
