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
       $this->view = new View("template");

       $this->accessCheck();
   }

   private function accessCheck()
   {

       $user = new User();
       if (!$user->isAuth()) {
           parent::ShowError(404, "Страница не найдена!");
       } else {
           $getUserProfile = $user->getProfile();
           if ($getUserProfile['role'] != 'admin') parent::ShowError(404, "Страница не найдена!");
       }
   }
}