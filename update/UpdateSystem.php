<?php

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