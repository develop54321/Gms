<?php
/*
 @name: Gms - Game Monitoring System
 @description: auto installer
 @author: https://vk.com/web2424
 @date: 11.09.2020
 @version: 1.2
*/

// Development Mode

/*ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);*/



if(!file_exists("config.php")) header("Location: /install");

define("ROOT_DIR", __DIR__ ."/");
define("BACKUP_DIR", realpath("../")."/");

require_once "config.php";
require_once "start.php";
$Route = new Route();

