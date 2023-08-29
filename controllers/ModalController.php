<?php

namespace controllers;

use core\BaseController;

class ModalController extends BaseController
{


    public function actionIndex()
    {

        if (parent::isAjax()) {
            $action = $_POST['action'];
            switch ($action) {
                case "answer":
                    $param = $_POST['param'];
                    $type = $_POST['type'];

                    return $this->view->render("modals/answerModal", ['param' => $param, 'type' => $type]);
                    break;

                case "serverServices":
                    $id = (int)$_POST['param'];
                    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
                    $getInfoServer->execute(array(':id' => $id));
                    $getInfoServer = $getInfoServer->fetch();

                    return $this->view->render("modals/serverServicesModal", ['data' => $getInfoServer]);
                    break;

                case "vote":
                    $id = (int)$_POST['param'];
                    $type = $_POST['type'];
                    $getInfoServer = $this->db->prepare('SELECT * FROM ga_servers WHERE id = :id');
                    $getInfoServer->execute(array(':id' => $id));
                    $getInfoServer = $getInfoServer->fetch();


                    return $this->view->render("modals/voteModal", ['type' => $type, 'data' => $getInfoServer]);
                    break;


                default:

                    break;
            }
        }


    }


}
     