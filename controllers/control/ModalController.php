<?php

namespace controllers\control;

class ModalController extends AbstractController
{
    public function index()
    {
        if (parent::isAjax()) {
            $action = $_POST['action'];
            switch ($action) {
                case "answer":
                    $param = $_POST['param'];
                    $type = $_POST['type'];

                    return $this->view->render("modals/answerModal", ['param' => $param, 'type' => $type]);
                    break;
                default:

                    break;
            }
        }
    }

}