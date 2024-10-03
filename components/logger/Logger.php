<?php

namespace components\logger;

use core\Database;
use PDO;

class Logger
{
    private $db;
    public function __construct()
    {
        $this->db = new Database();
    }

    public function writeDatabase($message)
    {

        $sql = 'INSERT INTO ga_system_logs (text, date_create) VALUES (:text, :date_create)';
        $stmt = $this->db->prepare($sql);

        $stmt->bindValue(':text', $message, PDO::PARAM_STR);
        $stmt->bindValue(':date_create', time(), PDO::PARAM_STR);

        $stmt->execute();
    }
}