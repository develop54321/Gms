<?php
/*
 @name: Gms - Game Monitoring System
 @author: https://vk.com/dev_gamems
 @site: https://game-ms.ru
 @version: 3.1
*/

use core\Route;


//dev mode
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

ini_set('display_errors', 'On');


session_start();
require_once 'vendor/autoload.php';

if (file_exists("config.php") === false){
    header("Location: /install.php");
}
const ROOT_DIR = __DIR__ . "/";

require_once "config.php";
$Route = new Route();
$Route->start();


