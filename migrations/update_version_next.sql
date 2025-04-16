ALTER TABLE `ga_settings` ADD `params_mail` TEXT NULL AFTER `content`;

CREATE TABLE `ga_queue` (`id` INT(11) NOT NULL AUTO_INCREMENT , `status` VARCHAR(255) NOT NULL , `attempt` INT(11) NOT NULL , `max_attempt` INT(11) NOT NULL , `message` TEXT NOT NULL , PRIMARY KEY (`id`)) ENGINE = InnoDB;

ALTER TABLE `ga_services` ADD `text` TEXT NULL AFTER `params`;

ALTER TABLE `ga_pay_methods` ADD `text` TEXT NULL AFTER `typeCode`;

ALTER TABLE `ga_queue` ADD `date_create` INT(11) NOT NULL AFTER `message`;

ALTER TABLE `ga_users` ADD `reset_code_created_at` INT(11) NULL AFTER `reset_code`;

UPDATE `ga_pay_methods` SET `name` = 'ЮMoney' WHERE `ga_pay_methods`.`id` = 4

UPDATE `ga_services` SET `name` = 'Буст 1 круг' WHERE `ga_services`.`id` = 10;


DELETE FROM `ga_pay_methods` WHERE `ga_pay_methods`.`id` = 1


INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`, `text`) VALUES ('6', '0', 'Lava', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'lava', NULL)

DELETE FROM `ga_pay_methods` WHERE `ga_pay_methods`.`id` = 2;

ALTER TABLE `ga_servers` ADD `verification_rand_expired_at` INT(11) NULL AFTER `verification_rand`;

ALTER TABLE `ga_pay_methods` ADD `icon_path` VARCHAR(255) NULL AFTER `text`;