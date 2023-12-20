<?php

namespace core;

use PDO;
use PDOException;

class Database extends PDO
{
    /**
     * @throws \Exception
     */
    public function __construct()
    {
        if (class_exists('pdo_mysql', false)) {
            throw new \Exception("PDO MYSQL driver is not available, please install this module");
        }

        try {
            parent::__construct('mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=utf8', DB_USER, DB_PASSWORD, [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);

        } catch (PDOException $e) {
            throw new \Exception($e->getMessage());

        }
    }

}