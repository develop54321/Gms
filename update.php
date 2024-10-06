<?php

// Основной скрипт
use update\ConfigManager;
use update\DatabaseManager;
use update\UpdateSystem;

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

<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">z
    <title>Обновления GMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
</head>
<style>
    body {
        background-color: #f2f7fc;
    }
    .content {
        background-color: #fff;
        border: 1px solid #dadada;
        max-width: 660px;
        margin: 2em auto;
        padding: 1.2em 0.8em;
        border-radius: 0.3em;
    }
</style>
<body>
<div class="content">
    <?php if ($step === "start"): ?>
        <form method="post">
            <input type="hidden" name="step" value="database">
            <h4 class="mb-3">Добро пожаловать в установщик <b>Game Monitoring System</b></h4>

            <?php if (!empty($errorText)): ?>
                <div class="alert alert-danger">
                    <p><?php echo $errorText; ?></p>
                </div>
            <?php endif; ?>

            <div class="alert alert-info">
                <p>Перед началом обновления рекомендуется создать резервную копию базы данных и файлов.</p>
            </div>
            <p>Проверка системных требований</p>
            <table class="table table-bordered">
                <tr>
                    <td>Текущая версия</td>
                    <td><?php echo $currentVersion; ?></td>
                </tr>
                <tr>
                    <td>Доступно к обновлению</td>
                    <td><?php echo $version; ?></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <button class="btn btn-primary btn-sm" onclick="return confirm('Вы уверены, что хотите продолжить обновление? Это действие необратимо.')">Обновить</button>
                    </td>
                </tr>
            </table>
        </form>
    <?php endif ?>

    <?php if ($step === "finish"): ?>
        <div>
            <h4 class="pb-2">Благодарим за установку нашего продукта</h4>
            <p>Пожалуйста нажмите кнопку "Войти", чтобы попасть в систему управления.</p>
            <a class="btn btn-primary" href="/control">Войти</a>
        </div>
        <p>
            Документацию по работе с движком, Вы можете найти на сайте:<br/>
            <a href="https://game-ms.ru">game-ms.ru</a>
        </p>
    <?php endif; ?>

    <footer class="text-center">
        <a href="https://game-ms.ru" target="_blank">Сайт проекта</a>
    </footer>

    <script>
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "https://game-ms.ru/api.html");
        const body = JSON.stringify({ host: window.location.host });
        xhr.onload = () => {
            if (xhr.readyState === 4 && xhr.status === 201) {
                console.log(JSON.parse(xhr.responseText));
            } else {
                console.log(`Error: ${xhr.status}`);
            }
        };
        xhr.send(body);
    </script>
</div>
</body>
</html>
