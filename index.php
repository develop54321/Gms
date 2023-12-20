<?php
/*
 @name: Gms - Game Monitoring System v2.1
 @author: https://vk.com/dev_gamems
 @site: https://game-ms.ru
 @version: 2.1
*/

use core\Route;

ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
session_start();
require_once 'vendor/autoload.php';

if (file_exists("config.php") === false){
    exit("config.php not found");
}
const ROOT_DIR = __DIR__ . "/";

require_once "config.php";
$Route = new Route();
$Route->start();


