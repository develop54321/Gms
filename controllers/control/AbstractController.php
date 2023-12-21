<?php

namespace controllers\control;

use core\BaseController;
use core\Database;
use core\View;

abstract class AbstractController extends BaseController
{

   public function __construct()
   {
       $this->db = new Database();
       $this->view = new View("template");
   }
}