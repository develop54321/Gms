#!/bin/bash
VERSION = "2.0"
echo "Добро пожаловать в автоустановщик GMS"

echo "Шаг 1/4."
read -p 'Введите Email администратора: ' adminEmail
read -p 'Введите Пароль администратора: ' adminPassword
echo ""
#
#touch config_dist.php
#>config_dist.php
#echo -n > config_dist.php
#printf '' > config_dist.php

function readMysqlData(){
  read -p 'Сервер: ' host_mysql
  read -p 'База данных: ' data_base_mysql
  read -p 'Пользователь: ' user_mysql
}

function connect_mysql(){
  echo "Шаг 2/4."
  echo "Установка соединения с базой данных"
readMysqlData
while ! mysql -h $host_mysql -u $user_mysql -p $data_base_mysql -e";" ; do
      echo "Не удалось установить соединения с Mysql сервером, попробуйте ещё раз"
      readMysqlData
done
}
connect_mysql

function generate_config() {
    
}