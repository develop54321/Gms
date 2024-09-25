ALTER TABLE `ga_comments` CHANGE `id_user` `id_user` INT(11) NULL;

ALTER TABLE `ga_pages` ADD `count_visited` INT(11) NOT NULL AFTER `date_create`;

INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`) VALUES ('5', '0', 'ЮKassa', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'yookassa')