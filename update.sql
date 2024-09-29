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
