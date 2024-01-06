<?php

namespace controllers\control;

use components\User;
use core\BaseController;
use core\Database;
use core\View;

abstract class AbstractController extends BaseController
{

   public function __construct()
   {
       $this->db = new Database();
       $this->view = new View(ROOT_DIR."template/control");

       $this->accessCheck();
   }

   private function accessCheck()
   {
       $uri = $_SERVER['REQUEST_URI'];
       $user = new User();
       if (!$user->isAuth()) {
           if ($uri !== "/control/login" and $uri !== "/control/modal"){
                header("Location: /control/login");
           }

       } else {
           $getUserProfile = $user->getProfile();
           if ($getUserProfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");
           if ($uri === "/control/login"){
               header("Location: /control");
           }

       }
   }
}