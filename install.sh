#!/bin/bash
VERSION = "2.0"
echo "Добро пожаловать в автоустановщик GMS"

echo "Шаг 1/4."
read -p 'Введите Email администратора: ' admin_email
read -p 'Введите Пароль администратора: ' admin_password
echo ""

function readMysqlData(){
  read -p 'Сервер: ' host_mysql
  read -p 'База данных: ' data_base_mysql
  read -p 'Пользователь: ' user_mysql
  read -p 'Пароль: ' user_password
}

function generate_config() {
touch config_dist.php
echo '<?php' > config_dist.php
echo 'const DB_HOST = "'${host_mysql}'";' >> config_dist.php
echo 'const DB_USER = "'${user_mysql}'";' >> config_dist.php
echo 'const DB_PASSWORD = "'${user_password}'";' >> config_dist.php
echo 'const DB_NAME = "'${data_base_mysql}'";' >> config_dist.php
echo 'const TMPL_DIR = "template/default";' >> config_dist.php
echo -en '\n' >> config_dist.php
echo 'const VERSION = "2.0";' >> config_dist.php

cp dump.sql dump_import.sql
clitime=$(php -r 'echo time();')

echo "INSERT INTO `ga_users` (`id`, '`lastname'`, `firstname`, `role`, `password`, `email`, `hash`, `balance`, `img`, `date_reg`, `params`, `api_login`, `reset_code`) VALUES
(1, 'Админстратор', 'Системы', 'admin', '0192023a7bbd73250516f069df18b500', '${admin_email}', '', '9', NULL, '${clitime}', NULL, NULL, NULL);" >> dump_import.sql
}

function import_database() {
    MYSQL_PWD=${user_password} mysql -u $user_mysql $data_base_mysql < dump_import.sql
    echo "Success Install GMS script"
}

function connect_mysql(){
  echo "Шаг 2/4."
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