<?php

namespace components;

use core\BaseController;

class Control extends BaseController
{
    function isAuth(): bool
    {
        session_start();
        if (isset($_SESSION['email']) && isset($_SESSION['hash'])) {
            $hash = $_SESSION['hash'];
            $email = $_SESSION['email'];
            $checkHash = $this->db->prepare('SELECT * FROM ga_users WHERE email = :email and hash = :hash');
            $checkHash->execute(array(':email' => $email, ':hash' => $hash));
            if ($checkHash->rowCount() > 0) {
                return true;
            } else return false;
        } else {
            return false;
        }

    }

}