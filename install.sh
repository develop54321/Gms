#!/bin/bash
VERSION="2.0"
echo "Добро пожаловать в автоустановщик GMS"

  echo "Спасибо за установку!\n"
  echo "Документацией по работе скриптом, Вы можете ознакомиться на сайте: http://gamems.ru/"

function readMysqlData() {
  read -p 'Сервер: ' host_mysql
  read -p 'База данных: ' data_base_mysql
  read -p 'Пользователь: ' user_mysql
  read -p 'Пароль: ' user_password
}

function generate_config() {
  touch config_dist.php
  echo '<?php' >config_dist.php
  echo 'const DB_HOST = "'${host_mysql}'";' >>config_dist.php
  echo 'const DB_USER = "'${user_mysql}'";' >>config_dist.php
  echo 'const DB_PASSWORD = "'${user_password}'";' >>config_dist.php
  echo 'const DB_NAME = "'${data_base_mysql}'";' >>config_dist.php
  echo 'const TMPL_DIR = "template/new-style";' >>config_dist.php
  echo -en '\n' >>config_dist.php
  echo 'const VERSION = "2.0";' >>config_dist.php
}

function import_database() {
  MYSQL_PWD=${user_password} mysql -u $user_mysql $data_base_mysql <dump.sql
  echo "Success Install GMS script"
}

function connect_mysql() {
  echo "Шаг 1/2."
  echo "Установка соединения с базой данных"
  readMysqlData
  while ! MYSQL_PWD=${user_password} mysql -h $host_mysql -u $user_mysql $data_base_mysql -e ";"; do
    echo "Не удалось установить соединения с Mysql сервером, попробуйте ещё раз"
    readMysqlData
  done
  generate_config
  import_database
}

connect_mysql

function success_install() {
  echo "Спасибо за установку!\n"
  echo "Документацией по работе скриптом, Вы можете ознакомиться на сайте: http://gamems.ru/"
}
success_install
