ALTER TABLE `ga_servers` DROP `befirst_enabled`;

ALTER TABLE `ga_servers` CHANGE `top_enabled` `top_enabled` INT(11) NULL DEFAULT NULL, CHANGE `vip_enabled` `vip_enabled` INT(11) NULL DEFAULT NULL, CHANGE `color_enabled` `color_enabled` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, CHANGE `gamemenu_enabled` `gamemenu_enabled` INT(11) NULL DEFAULT NULL, CHANGE `boost` `boost` INT(11) NULL DEFAULT NULL, CHANGE `boost_position` `boost_position` INT(11) NULL DEFAULT NULL;

ALTER TABLE `ga_users` ADD `reset_code_created_at` INT(11) NULL DEFAULT NULL AFTER `reset_code`;