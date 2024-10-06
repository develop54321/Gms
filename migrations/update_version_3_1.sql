ALTER TABLE `ga_comments` CHANGE `id_user` `id_user` INT(11) NULL;

ALTER TABLE `ga_pages` ADD `count_visited` INT(11) NOT NULL AFTER `date_create`;

INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`) VALUES ('5', '0', 'ЮKassa', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'yookassa')

CREATE TABLE IF NOT EXISTS `mslog` (
                                       `timeyear` varchar(255) DEFAULT NULL,
    `timemonth` varchar(255) DEFAULT NULL,
    `timeday` varchar(255) DEFAULT NULL,
    `timehour` varchar(255) DEFAULT NULL,
    `timeminute` varchar(255) DEFAULT NULL,
    `timesecond` varchar(255) DEFAULT NULL,
    `ip` varchar(255) DEFAULT NULL,
    `port` varchar(255) DEFAULT NULL,
    `type` varchar(255) DEFAULT NULL
    ) ENGINE=MyISAM DEFAULT CHARSET=utf8;


CREATE TABLE `app_db`.`ga_system_logs` (`id` INT NOT NULL AUTO_INCREMENT COMMENT '11' , `text` TEXT CHARACTER SET utf8 COLLATE utf8_bin NOT NULL , `date_create` INT(11) NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;

INSERT INTO `ga_games` (`id`, `code`, `game`, `status`) VALUES ('10', 'arma_3', 'Arma 3', '0'), ('11', 'mta', 'Mta', '0')