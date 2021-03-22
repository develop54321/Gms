<?php
/*
 @name: Gms - Game Monitoring System
 @description: auto installer
 @author: https://vk.com/web2424
 @date: 17.08.2020
 @version: 1.1
*/
if(file_exists("../config.php")) exit("Cms is already installed");
define("version", "1.1");


if(!isset($_GET['step'])) $step = 1;
else $step = (int)$_GET['step'];

switch($step){
    case "1":
    include_once("step1.php");
    break;

    case "2":
    if($_POST){
        if(isset($_POST['server'])) $server = $_POST['server']; else exit();
        if(isset($_POST['username'])) $username = $_POST['username']; else exit();
        if(isset($_POST['password'])) $password = $_POST['password']; else exit();
        if(isset($_POST['baseName'])) $baseName = $_POST['baseName']; else exit();
        
        try{
            $dbh = new PDO('mysql:host='.$server.';dbname='.$baseName.'', $username, $password, array(
                PDO::ATTR_PERSISTENT => true
            ));
     
            $file = fopen("../configtmp.php", "w+");
            $current = file_get_contents($file);
            $current .= "<?php"."\n";
            $current .= 'define("DB_HOST", "'.$server.'");'."\n";
            $current .= 'define("DB_USER", "'.$username.'");'."\n";
            $current .= 'define("DB_PASSWORD", "'.$password.'");'."\n";
            $current .= 'define("DB_NAME", "'.$baseName.'");'."\n";
            $current .= 'define("TMPL_DIR", "template");'."\n";
            $current .= "\n";
            $current .= 'define("VERSION", "'.version.'");'."\n";
            fwrite($file, $current);

            header("Location: /install/?step=3");
        }
        catch(PDOException $ex){
            $error = '<div class="alert alert-danger"><b>Ошибка</b>, установки соединения с базой данных, проверьте введенные данные.</div>';
        }
        
        }
    include_once("step2.php");
    break;


    case "3":
    if($_POST){
        if(isset($_POST['email'])) $email = $_POST['email']; else exit();
        if(isset($_POST['password'])) $password = $_POST['password']; else exit();
        if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $error = '<div class="alert alert-danger"><b>Ошибка</b>, не правильно указан Email адрес.</div>';
        }
         

        if(empty($error)){
        $adminHass = md5($password);
        $admiEmail = $email;
        $sql = "INSERT INTO `ga_users` (`id`, `lastname`, `firstname`, `role`, `password`, `email`, `hash`, `balance`, `img`, `date_reg`, `params`, `api_login`, `reset_code`) VALUES
        (1, 'Админ', 'Админ', 'admin', '".$adminHass."', '".$admiEmail."', '', '0', '/public/img/avatar.png', 0, '{\"key_api\":\"\",\"discount_api\":\"\"}', '', '');";
    
        $fileSql = fopen("database.sql", "a+");
        $current = file_get_contents($fileSql);
        fwrite($fileSql, $sql);

        $sqlFile = 'database.sql';
        include_once("../configtmp.php");

    
        $dbh = new PDO('mysql:host='.DB_HOST.';dbname='.DB_NAME.'', DB_USER, DB_PASSWORD, array(
                PDO::ATTR_PERSISTENT => true
        ));

        $res = importSqlFile($dbh, $sqlFile);

        if ($res === false) {
            die('ERROR sql import');
        }
       

        header("Location: /install/?step=4");
        } 
        
    }
    include_once("step3.php");
    
    break;

    case "4":
        $domain = $_SERVER['SERVER_NAME'];
        $hashKey = "NWJkNTUzZDc0ODgzZmVmYzg1NjNlNDViODIwMmVjOGY=";
        if( $curl = curl_init() ) {
            curl_setopt($curl, CURLOPT_URL, 'https://web-24.xyz/counter.php?domain='.$domain.'&hash='.$hashKey);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER,true);
            $out = curl_exec($curl);
            echo $out;
            curl_close($curl);
        }
        include_once("step4.php");
        rename("../configtmp.php", "../config.php");
        break;

    default:
    exit();
}


function importSqlFile($pdo, $sqlFile, $tablePrefix = null, $InFilePath = null)
{
    try {
        
       
        $pdo->setAttribute(\PDO::MYSQL_ATTR_LOCAL_INFILE, true);
        
        $errorDetect = false;
        
        $tmpLine = '';
        

        $lines = file($sqlFile);
        

        foreach ($lines as $line) {

            if (substr($line, 0, 2) == '--' || trim($line) == '') {
                continue;
            }
            

            $line = str_replace(['<<prefix>>', '<<InFilePath>>'], [$tablePrefix, $InFilePath], $line);
            

            $tmpLine .= $line;
            

            if (substr(trim($line), -1, 1) == ';') {
                try {
   
                    $pdo->exec($tmpLine);
                } catch (\PDOException $e) {
                    echo "<br><pre>Error performing Query: '<strong>" . $tmpLine . "</strong>': " . $e->getMessage() . "</pre>\n";
                    $errorDetect = true;
                }
                

                $tmpLine = '';
            }
        }
        

        if ($errorDetect) {
            return false;
        }
        
    } catch (\Exception $e) {
        echo "<br><pre>Exception => " . $e->getMessage() . "</pre>\n";
        return false;
    }
    
    return true;
}


?>