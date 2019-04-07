<?php
/*
 @name: Gms - Game Monitoring System
 @author: art-gaisin.ru
 @date: 07.04.2019
 @version: 1.0
*/ 

// Development Mode
/*
ini_set('error_reporting', E_ALL);
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
*/

define("ROOT_DIR", __DIR__ ."/");
define("BACKUP_DIR", realpath("../")."/");

require_once "config.php";
require_once "start.php";
$Route = new Route();

