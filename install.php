<?php
if (file_exists("config.php")) {
    exit("CMS is already installed");
}
$step = "requiredExtension";

$versionRequired = null;
if (version_compare(phpversion(), '7.4', '<')) {
    $versionRequired = "Требуется PHP версии 7.4 и выше";
}

$required_extensions = ['intl', 'gd', 'curl', 'mbstring'];
if (isset($_POST['step'])) {
    $step = $_POST['step'];
}

$errorText = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $step === 'database_check') {
    $db_host = $_POST['db_host'];
    $db_user = $_POST['db_user'];
    $db_password = $_POST['db_password'];
    $db_name = $_POST['db_name'];

    try {
        $dsn = "mysql:host=$db_host;dbname=$db_name";
        $conn = new PDO($dsn, $db_user, $db_password, [
            PDO::ATTR_TIMEOUT => 5,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        ]);
        $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        $dump_file = 'dump.sql';
        $sql = file_get_contents($dump_file);
        $conn->exec($sql);

        $baseUrl = null;

        $pu = parse_url($_SERVER['REQUEST_URI']);
        $baseUrl = $pu["scheme"] . "://" . $pu["host"];

        $config_content = <<<EOD
<?php
const BASE_URL = "$baseUrl";
const DB_HOST = "$db_host";
const DB_USER = "$db_user";
const DB_PASSWORD = "$db_password";
const DB_NAME = "$db_name";
const TMPL_DIR = "template/new-style";
const VERSION = "3.0";
EOD;

        file_put_contents('config.php', $config_content);

        $step = "finish";

    } catch (PDOException $e) {
        $errorText = $e->getMessage();
    }
}

$requiredExtensionsList = [];
foreach ($required_extensions as $extension) {
    if (!extension_loaded($extension)) {
        $requiredExtensionsList[$extension] = false;
    } else {
        $requiredExtensionsList[$extension] = true;
    }
}

?>


<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <title>Установка GMS</title>
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
    <?php if ($step === "requiredExtension"): ?>
        <form method="post">
            <input type="hidden" name="step" value="database">
            <h4 class="mb-3">
                Добро пожаловать в установщик <b>Game Monitoring System</b>
            </h4>
            <p class="p-0 m-0">Проверка системных требований</p>
            <table class="table table-bordered">
                <?php if ($versionRequired): ?>
                    <tr>
                        <td>
                            <span class="text-danger"> <?php echo $versionRequired; ?></span>
                        </td>
                    </tr>
                <?php endif; ?>
                <?php foreach ($requiredExtensionsList as $key => $val): ?>
                    <tr>
                        <td>
                            <?php if ($val): ?>
                                <span class="text-success">Требуется расширение: <?php echo $key; ?></span>
                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40" width="16px" height="16px">
                                    <path fill="#bae0bd" d="M1.707 22.199L4.486 19.42 13.362 28.297 35.514 6.145 38.293 8.924 13.362 33.855z"/>
                                    <path fill="#5e9c76" d="M35.514,6.852l2.072,2.072L13.363,33.148L2.414,22.199l2.072-2.072l8.169,8.169l0.707,0.707 l0.707-0.707L35.514,6.852 M35.514,5.438L13.363,27.59l-8.876-8.876L1,22.199l12.363,12.363L39,8.924L35.514,5.438L35.514,5.438z"/>
                                </svg>
                            <?php else: ?>
                                <span class="text-danger">Требуется расширение: <?php echo $key; ?></span>
                            <?php endif; ?>

                        </td>
                    </tr>
                <?php endforeach; ?>



                <?php if (in_array(0, $requiredExtensionsList)): ?>
                    <tr>
                        <td>
                            <button class="btn btn-primary btn-sm <?php if (!empty($requiredExtensionsList)): ?>disabled<?php endif; ?>">
                                Продолжить
                            </button>
                        </td>
                    </tr>
                <?php else: ?>
                    <tr>
                        <td>
                            <button class="btn btn-primary btn-sm">Продолжить</button>
                        </td>
                    </tr>

                <?php endif; ?>
            </table>
        </form>
    <?php endif ?>



    <?php if ($step === "database" or $step === 'database_check'): ?>
        <form method="post">
            <h4 class="pb-2">
                Сведения о подключении к базе данных
            </h4>
            <?php if ($errorText): ?>
                <div class="alert alert-danger">
                    <p>
                        <?php echo $errorText; ?>
                    </p>
                </div>
            <?php endif; ?>
            <input type="hidden" name="step" value="database_check">
            <table class="table table-bordered">
                <tr>
                    <td>Хост базы данных</td>
                    <td>
                        <input type="text" name="db_host" required class="form-control form-control-sm" value="localhost">
                    </td>
                </tr>

                <tr>
                    <td>Пользователь базы данных</td>
                    <td><input type="text" name="db_user" required class="form-control form-control-sm"></td>
                </tr>

                <tr>
                    <td>Пароль базы данных</td>
                    <td><input type="password" name="db_password" required class="form-control form-control-sm"></td>
                </tr>

                <tr>
                    <td>Название базы данных</td>
                    <td><input type="text" name="db_name" required class="form-control form-control-sm"></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" class="btn btn-primary btn-sm" value="Установить">
                    </td>
                </tr>
            </table>
        </form>
    <?php endif; ?>


    <?php if ($step === "finish"): ?>
        <div>
            <h4 class="pb-2">Благодарим за установку нашего продукта</h4>
            <p>Пожалуйста нажмите кнопку "Войти", чтобы попасть в систему управления.</p>
            <a class="btn btn-primary" href="/control">Войти</a>
        </div>

        <p>
            Документацией по работе с движком, Вы можете ознакомиться на сайте:<br/>
            <a href="https://game-ms.ru">game-ms.ru</a>
        </p>
    <?php endif; ?>

    <footer class="text-center">
        <a href="https://game-ms.ru/" target="_blank">Сайт проекта</a>
    </footer>
    <script>
        const xhr = new XMLHttpRequest();
        xhr.open("POST", "https://game-ms.ru/api.html");
        const body = JSON.stringify({
            host: window.location.host
        });
        xhr.onload = () => {
            if (xhr.readyState == 4 && xhr.status == 201) {
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