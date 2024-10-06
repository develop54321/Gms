<?php

class DatabaseManager {
    private $dsn;
    private $user;
    private $password;
    private $connection;

    public function __construct($host, $dbname, $user, $password) {
        $this->dsn = "mysql:host=$host;dbname=$dbname";
        $this->user = $user;
        $this->password = $password;
    }

    public function connect() {
        try {
            $this->connection = new PDO($this->dsn, $this->user, $this->password, [
                PDO::ATTR_TIMEOUT => 5,
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            ]);
        } catch (PDOException $e) {
            throw new Exception("Ошибка подключения к базе данных: " . $e->getMessage());
        }
    }

    public function applyMigration($migrationFile) {
        try {
            $sql = file_get_contents($migrationFile);
            $this->connection->exec($sql);
        } catch (Exception $e) {
            throw new Exception("Ошибка при выполнении миграции: " . $e->getMessage());
        }
    }
}