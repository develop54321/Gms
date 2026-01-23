<?php
declare(strict_types=1);

/*
 |---------------------------------------------------------
 | Game Monitoring System Installer (один файл)
 |---------------------------------------------------------
*/

const MIN_PHP_VERSION = '7.4';
const REQUIRED_EXTENSIONS = ['intl', 'gd', 'curl', 'mbstring'];
const CONFIG_FILE = 'config.php';
const DUMP_FILE = 'dump.sql';
const VERSION = '3.1.5';

if (file_exists(CONFIG_FILE)) {
    exit('CMS уже установлена');
}

$step = filter_input(INPUT_POST, 'step') ?? 'license';
$errorText = null;

function e(string $value): string
{
    return htmlspecialchars($value, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function phpVersionError(): ?string
{
    return version_compare(PHP_VERSION, MIN_PHP_VERSION, '<')
            ? 'Требуется PHP версии ' . MIN_PHP_VERSION . ' и выше'
            : null;
}

function checkExtensions(): array
{
    $result = [];
    foreach (REQUIRED_EXTENSIONS as $ext) {
        $result[$ext] = extension_loaded($ext);
    }
    return $result;
}

// Обработка базы данных
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $step === 'database_check') {

    $dbHost = trim((string)filter_input(INPUT_POST, 'db_host'));
    $dbUser = trim((string)filter_input(INPUT_POST, 'db_user'));
    $dbPass = (string)filter_input(INPUT_POST, 'db_password');
    $dbName = trim((string)filter_input(INPUT_POST, 'db_name'));

    try {
        if (!file_exists(DUMP_FILE)) {
            throw new RuntimeException('Файл dump.sql не найден');
        }

        $dsn = sprintf(
                'mysql:host=%s;dbname=%s;charset=utf8mb4',
                $dbHost,
                $dbName
        );

        $pdo = new PDO($dsn, $dbUser, $dbPass, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_TIMEOUT => 5,
        ]);

        $pdo->exec(file_get_contents(DUMP_FILE));

        $scheme = $_SERVER['REQUEST_SCHEME'] ?? 'http';
        $host = $_SERVER['HTTP_HOST'] ?? '';
        $baseUrl = $scheme . '://' . $host;

        $config = <<<PHP
<?php
declare(strict_types=1);

const BASE_URL = '{$baseUrl}';
const DB_HOST = '{$dbHost}';
const DB_USER = '{$dbUser}';
const DB_PASSWORD = '{$dbPass}';
const DB_NAME = '{$dbName}';
const TMPL_DIR = 'template/default2';
const VERSION = '" . VERSION . "';

PHP;

        file_put_contents(__DIR__ . '/' . CONFIG_FILE, $config, LOCK_EX);


        $step = 'finish';

    } catch (Throwable $e) {
        $errorText = $e->getMessage();
        $step = 'database';
    }
}

$phpError = phpVersionError();
$extensions = checkExtensions();
?>
<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Установка GMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; font-family: "Inter", sans-serif; }
        .installer-container { max-width: 780px; margin: 40px auto; background: #fff; border-radius: 0.5rem; padding: 2rem; box-shadow: 0 0 15px rgba(0,0,0,0.05); }
        h1 { font-weight: 600; font-size: 1.8rem; }
        .license-box { max-height: 300px; overflow-y: auto; border: 1px solid #dee2e6; padding: 1rem; background: #f9f9f9; border-radius: 0.25rem; }
        .progress { height: 1.5rem; margin-bottom: 2rem; }
        .footer { text-align: center; font-size: 0.875rem; margin-top: 2rem; color: #6c757d; }
        .footer a { text-decoration: none; }
        table.table td { vertical-align: middle; }
    </style>
</head>
<body>
<div class="installer-container">

    <?php
    $stepsMap = ['license' => 25, 'requiredExtension' => 50, 'database' => 75, 'finish' => 100];
    $progress = $stepsMap[$step] ?? 0;
    ?>
    <div class="progress mb-4">
        <div class="progress-bar bg-success" role="progressbar" style="width: <?= $progress ?>%;" aria-valuenow="<?= $progress ?>" aria-valuemin="0" aria-valuemax="100"></div>
    </div>

    <?php if ($step === 'license'): ?>
        <h1 class="mb-3">Добро пожаловать в установщик <b>GMS</b></h1>
        <p>Перед установкой ознакомьтесь с лицензионным соглашением:</p>
        <div class="license-box mb-3">
            <?= file_exists("LICENSE.MD") ? nl2br(e(file_get_contents("LICENSE.MD"))) : "Файл лицензии не найден."; ?>
        </div>
        <form method="post">
            <input type="hidden" name="step" value="requiredExtension">
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" id="agreeLicense" required>
                <label class="form-check-label" for="agreeLicense">
                    Я принимаю условия лицензионного соглашения
                </label>
            </div>
            <button type="submit" class="btn btn-primary">Продолжить</button>
        </form>
    <?php endif; ?>

    <?php if ($step === 'requiredExtension'): ?>
        <h1 class="mb-3">Проверка системных требований</h1>
        <?php if ($phpError): ?>
            <div class="alert alert-danger"><?= e($phpError) ?></div>
        <?php endif; ?>
        <form method="post">
            <input type="hidden" name="step" value="database">
            <table class="table table-bordered">
                <?php foreach ($extensions as $ext => $loaded): ?>
                    <tr>
                        <td><?= $loaded ? '<span class="text-success">✔ Расширение: '.e($ext).'</span>' : '<span class="text-danger">✖ Расширение: '.e($ext).'</span>' ?></td>
                    </tr>
                <?php endforeach; ?>
            </table>
            <button type="submit" class="btn btn-primary" <?= in_array(false, $extensions, true) || $phpError ? 'disabled' : '' ?>>Продолжить</button>
        </form>
    <?php endif; ?>

    <?php if ($step === 'database' || $step === 'database_check'): ?>
        <h1 class="mb-3">Настройка базы данных</h1>
        <?php if ($errorText): ?>
            <div class="alert alert-danger"><?= e($errorText) ?></div>
        <?php endif; ?>
        <form method="post">
            <input type="hidden" name="step" value="database_check">
            <table class="table table-bordered">
                <tr>
                    <td>Хост базы данных</td>
                    <td><input type="text" name="db_host" class="form-control form-control-sm" required value="localhost"></td>
                </tr>
                <tr>
                    <td>Пользователь</td>
                    <td><input type="text" name="db_user" class="form-control form-control-sm" required></td>
                </tr>
                <tr>
                    <td>Пароль</td>
                    <td><input type="password" name="db_password" class="form-control form-control-sm"></td>
                </tr>
                <tr>
                    <td>Имя базы данных</td>
                    <td><input type="text" name="db_name" class="form-control form-control-sm" required></td>
                </tr>
            </table>
            <button type="submit" class="btn btn-primary">Установить</button>
        </form>
    <?php endif; ?>

    <?php if ($step === 'finish'): ?>
        <h1 class="mb-3 text-success">Установка завершена!</h1>
        <p>Вы успешно установили <b>Game Monitoring System</b>.</p>
        <a href="/control" class="btn btn-success">Войти в панель управления</a>
        <p class="mt-3">Документация: <a href="https://game-ms.ru" target="_blank">game-ms.ru</a></p>
    <?php endif; ?>

    <div class="footer">
        <a href="https://game-ms.ru" target="_blank">Сайт проекта</a>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
