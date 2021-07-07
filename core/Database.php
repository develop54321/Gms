<?php

namespace core;

use PDO;
use PDOException;

class Database extends PDO
{
    public function __construct()
    {
        try {
            parent::__construct('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8', DB_USER, DB_PASSWORD, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

        } catch (PDOException $e) {
            throw new \Exception($e->getMessage());

        }
    }

}