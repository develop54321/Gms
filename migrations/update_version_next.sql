SET @dbname = DATABASE();
SET @tablename = 'ga_settings';
SET @columnname = 'params_mail';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (TABLE_SCHEMA = @dbname)
      AND (TABLE_NAME = @tablename)
      AND (COLUMN_NAME = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE `', @tablename, '` ADD `', @columnname, '` TEXT NULL AFTER `content`;')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

CREATE TABLE IF NOT EXISTS `ga_queue` (
                                          `id` INT(11) NOT NULL AUTO_INCREMENT,
    `status` VARCHAR(255) NOT NULL,
    `attempt` INT(11) NOT NULL,
    `max_attempt` INT(11) NOT NULL,
    `message` TEXT NOT NULL,
    `date_create` INT(11) NOT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE = InnoDB;

SET @tablename = 'ga_services';
SET @columnname = 'text';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (TABLE_SCHEMA = @dbname)
      AND (TABLE_NAME = @tablename)
      AND (COLUMN_NAME = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE `', @tablename, '` ADD `', @columnname, '` TEXT NULL AFTER `params`;')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

SET @tablename = 'ga_pay_methods';
SET @columnname = 'text';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (TABLE_SCHEMA = @dbname)
      AND (TABLE_NAME = @tablename)
      AND (COLUMN_NAME = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE `', @tablename, '` ADD `', @columnname, '` TEXT NULL AFTER `typeCode`;')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

SET @tablename = 'ga_servers';
SET @columnname = 'verification_rand_expired_at';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (TABLE_SCHEMA = @dbname)
      AND (TABLE_NAME = @tablename)
      AND (COLUMN_NAME = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE `', @tablename, '` ADD `', @columnname, '` INT(11) NULL AFTER `verification_rand`;')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

SET @tablename = 'ga_pay_methods';
SET @columnname = 'icon_path';
SET @preparedStatement = (SELECT IF(
  (
    SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS
    WHERE
      (TABLE_SCHEMA = @dbname)
      AND (TABLE_NAME = @tablename)
      AND (COLUMN_NAME = @columnname)
  ) > 0,
  'SELECT 1',
  CONCAT('ALTER TABLE `', @tablename, '` ADD `', @columnname, '` VARCHAR(255) NULL AFTER `text`;')
));
PREPARE alterIfNotExists FROM @preparedStatement;
EXECUTE alterIfNotExists;
DEALLOCATE PREPARE alterIfNotExists;

UPDATE `ga_pay_methods`
SET `name` = 'ЮMoney'
WHERE `id` = 4 AND (`name` != 'ЮMoney' OR `name` IS NULL);

UPDATE `ga_services`
SET `name` = 'Буст 1 круг'
WHERE `id` = 10 AND (`name` != 'Буст 1 круг' OR `name` IS NULL);

DELETE FROM `ga_pay_methods` WHERE `id` = 1;

DELETE FROM `ga_pay_methods` WHERE `id` = 2;

INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`, `text`)
SELECT 6, '0', 'Lava', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'lava', NULL
FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `ga_pay_methods` WHERE `id` = 6);

UPDATE `ga_settings`
SET `params_mail` = '{\"type\":\"smtp\",\"from\":\"\",\"smtp_server\":\"\",\"smtp_port\":\"\",\"encrypt\":\"\",\"smtp_username\":\"\",\"smtp_password\":\"\",\"auto_tls\":false}'
WHERE `id` = 1 AND (`params_mail` IS NULL OR `params_mail` = '');

UPDATE `ga_pay_methods`
SET `icon_path` = '/public/img/pay_methods/free-kassa.png'
WHERE `id` = 3 AND (`icon_path` IS NULL OR `icon_path` != '/public/img/pay_methods/free-kassa.png');

UPDATE `ga_pay_methods`
SET `icon_path` = '/public/img/pay_methods/yoomoney.png'
WHERE `id` = 4 AND (`icon_path` IS NULL OR `icon_path` != '/public/img/pay_methods/yoomoney.png');

UPDATE `ga_pay_methods`
SET `icon_path` = '/public/img/pay_methods/yookassa.png'
WHERE `id` = 5 AND (`icon_path` IS NULL OR `icon_path` != '/public/img/pay_methods/yookassa.png');

UPDATE `ga_pay_methods`
SET `icon_path` = '/public/img/pay_methods/lava.png'
WHERE `id` = 6 AND (`icon_path` IS NULL OR `icon_path` != '/public/img/pay_methods/lava.png');