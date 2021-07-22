<?php
/*
 @name: Gms - Game Monitoring System
 @description: auto installer
 @author: https://vk.com/web2424
 @date: 22.07.2021
 @version: 2.0
*/

use core\Route;

ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);

require_once 'vendor/autoload.php';
const ROOT_DIR = __DIR__ . "/";
define("BACKUP_DIR", realpath("../")."/");
require_once "config.php";
$Route = new Route();
$Route->start();


