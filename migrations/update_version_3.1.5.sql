ALTER TABLE `ga_servers` DROP `befirst_enabled`;

ALTER TABLE `ga_servers` CHANGE `top_enabled` `top_enabled` INT(11) NULL DEFAULT NULL, CHANGE `vip_enabled` `vip_enabled` INT(11) NULL DEFAULT NULL, CHANGE `color_enabled` `color_enabled` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL, CHANGE `gamemenu_enabled` `gamemenu_enabled` INT(11) NULL DEFAULT NULL, CHANGE `boost` `boost` INT(11) NULL DEFAULT NULL, CHANGE `boost_position` `boost_position` INT(11) NULL DEFAULT NULL;

INSERT INTO `ga_pages` (`id`, `title`, `text`, `date_create`, `count_visited`) VALUES (NULL, 'Условия договора', 'Условия договора', '1767785921', '1')

ALTER TABLE `ga_servers` ADD `query_port` VARCHAR(255) NULL AFTER `description`;

ALTER TABLE `ga_servers` ADD `last_update_at` INT(11) NULL AFTER `query_port`;

ALTER TABLE `ga_servers` ADD FULLTEXT(`hostname`, `map`);


INSERT INTO `ga_pages` (`id`, `title`, `text`, `date_create`, `count_visited`) VALUES ('5', 'Политика конфиденциальности', 'Настоящая Политика конфиденциальности описывает порядок обработки и защиты персональных данных пользователей сайта.\r\n\r\n1. Общие положения\r\n\r\nИспользуя данный сайт, вы соглашаетесь с условиями настоящей Политики конфиденциальности. Если вы не согласны с условиями, пожалуйста, прекратите использование сайта.\r\n\r\n2. Какие данные мы собираем\r\n\r\nСайт может собирать следующую информацию:\r\n\r\nтехнические данные (IP-адрес, тип браузера, устройство);\r\n\r\nданные, передаваемые автоматически с помощью файлов cookie;\r\n\r\nинформацию, которую пользователь предоставляет добровольно (например, через формы обратной связи).\r\n\r\n3. Использование файлов cookie\r\n\r\nФайлы cookie используются для:\r\n\r\nкорректной работы сайта;\r\n\r\nулучшения пользовательского опыта;\r\n\r\nанализа посещаемости и поведения пользователей на сайте.\r\n\r\nВы можете отключить использование cookie в настройках вашего браузера.\r\n\r\n4. Цели обработки данных\r\n\r\nСобранные данные используются исключительно для:\r\n\r\nобеспечения работы сайта;\r\n\r\nулучшения качества сервиса;\r\n\r\nсвязи с пользователем при необходимости.\r\n\r\n5. Передача данных третьим лицам\r\n\r\nАдминистрация сайта не передает персональные данные третьим лицам, за исключением случаев, предусмотренных законодательством.\r\n\r\n6. Защита данных\r\n\r\nМы принимаем разумные меры для защиты персональной информации пользователей от утраты, неправомерного доступа и раскрытия.\r\n\r\n7. Изменения политики\r\n\r\nАдминистрация сайта имеет право вносить изменения в настоящую Политику конфиденциальности без предварительного уведомления. Актуальная версия всегда доступна на данной странице.\r\n\r\n8. Контактная информация\r\n\r\nПо всем вопросам, связанным с обработкой персональных данных, вы можете связаться с администрацией сайта через контактные данные, указанные на сайте.', '1768469235', '0');

ALTER TABLE `ga_servers` ADD `host` VARCHAR(255) NULL AFTER `ip`;


ALTER TABLE ga_servers DROP INDEX hostname;

ALTER TABLE ga_servers
    CONVERT TO CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

ALTER TABLE ga_servers
    ADD FULLTEXT INDEX hostname (hostname, map);
