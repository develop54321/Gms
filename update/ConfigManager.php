<?php

namespace update;

class ConfigManager {
    private $configFile;
    private $versionPattern = '/const VERSION =\s*([0-9.]+);/';

    public function __construct($configFile) {
        $this->configFile = $configFile;
    }

    public function getConfigContent() {
        return file_get_contents($this->configFile);
    }

    public function getCurrentVersion() {
        $content = $this->getConfigContent();
        preg_match($this->versionPattern, $content, $matches);
        return $matches[1] ?? null;
    }

    public function updateVersion($newVersion) {
        $content = $this->getConfigContent();
        $newContent = preg_replace($this->versionPattern, "const VERSION = $newVersion;", $content);
        return file_put_contents($this->configFile, $newContent) !== false;
    }
}

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

class UpdateSystem {
    private $version;
    private $migrationFile;
    private $configManager;
    private $dbManager;
    private $step = "start";
    private $errorText = '';

    public function __construct($version, $migrationFile, ConfigManager $configManager, DatabaseManager $dbManager) {
        $this->version = $version;
        $this->migrationFile = $migrationFile;
        $this->configManager = $configManager;
        $this->dbManager = $dbManager;
    }

    public function checkForUpdates() {
        $currentVersion = $this->configManager->getCurrentVersion();
        if (!version_compare($this->version, $currentVersion, '>')) {
            exit("Для вашей системы нет доступных обновлений");
        }
        return $currentVersion;
    }

    public function applyUpdate() {
        try {
            $this->dbManager->connect();
            $this->dbManager->applyMigration("migrations/" . $this->migrationFile);

            if (!$this->configManager->updateVersion($this->version)) {
                throw new Exception("Ошибка записи в конфигурационный файл.");
            }

            $this->step = "finish";
        } catch (Exception $e) {
            $this->errorText = $e->getMessage();
        }
    }

    public function getStep() {
        return $this->step;
    }

    public function getErrorText() {
        return $this->errorText;
    }
}

// Основной скрипт
$version = 3.1;
$migrationFile = "update_version_3_1.sql";
$configFile = 'config.php';

$configManager = new ConfigManager($configFile);
$dbManager = new DatabaseManager(DB_HOST, DB_NAME, DB_USER, DB_PASSWORD);
$updateSystem = new UpdateSystem($version, $migrationFile, $configManager, $dbManager);

$currentVersion = $updateSystem->checkForUpdates();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $updateSystem->applyUpdate();
}

$step = $updateSystem->getStep();
$errorText = $updateSystem->getErrorText();

?>
