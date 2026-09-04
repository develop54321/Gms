-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Хост: gms-db:3306
-- Время создания: Янв 23 2026 г., 12:05
-- Версия сервера: 5.7.44
-- Версия PHP: 8.3.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `app_db`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ga_code_colors`
--

CREATE TABLE `ga_code_colors` (
  `id` int(11) NOT NULL,
  `code` varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'none',
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `activ` int(11) DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `ga_code_colors`
--

INSERT INTO `ga_code_colors` (`id`, `code`, `name`, `activ`) VALUES
(1, 'red', 'Красный', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_comments`
--

CREATE TABLE `ga_comments` (
  `id` int(11) NOT NULL,
  `moderation` decimal(1,0) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `id_server` int(11) NOT NULL,
  `text` text NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_games`
--

CREATE TABLE `ga_games` (
  `id` int(11) NOT NULL,
  `code` varchar(255) NOT NULL,
  `game` varchar(255) NOT NULL,
  `status` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_games`
--

INSERT INTO `ga_games` (`id`, `code`, `game`, `status`) VALUES
(1, 'cs', 'Counter Strike 1.6', 1),
(2, 'csgo', 'Counter-Strike: Global Offensive', 1),
(3, 'css', 'Counter Strike Sourse', 1),
(4, 'tf2', 'Team Fortress 2', 1),
(5, 'ld2', 'Left 4 Dead 2', 1),
(6, 'rust', 'Rust', 1),
(7, 'samp', 'San Andreas Multiplayer', 1),
(8, 'mta', 'Multi Theft Auto', 1),
(9, 'csgo2', 'Counter-Strike 2', 1),
(10, 'arma_3', 'Arma 3', 1),
(11, 'mta', 'Mta', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_logs_vote`
--

CREATE TABLE `ga_logs_vote` (
  `id` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `cookie` varchar(255) NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_news`
--

CREATE TABLE `ga_news` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_news`
--

INSERT INTO `ga_news` (`id`, `title`, `text`, `date_create`) VALUES
(1, 'Добро пожаловать', 'Добро пожаловать', 1748445316);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pages`
--

CREATE TABLE `ga_pages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `date_create` int(11) NOT NULL,
  `count_visited` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_pages`
--

INSERT INTO `ga_pages` (`id`, `title`, `text`, `date_create`, `count_visited`) VALUES
(1, 'Контакты', 'Группа вк: <b>https://vk.com/dev_gamems</b><br/>\r\nПочта: <b>support@game-ms.ru</b>', 0, 73),
(2, 'Пользовательское соглашение', '<p><strong>Пользовательское соглашение</strong></p>\r\n\r\n<p>Настоящее Соглашение определяет условия использования Пользователями материалов и сервисов сайта game-ms.ru        (далее — «Сайт»).</p>\r\n\r\n<p><strong>1.Общие условия</strong></p>\r\n\r\n<p>1.1. Использование материалов и сервисов Сайта регулируется нормами действующего законодательства Российской Федерации.</p>\r\n\r\n<p>1.2. Настоящее Соглашение является публичной офертой. Получая доступ к материалам Сайта Пользователь считается присоединившимся к настоящему Соглашению.</p>\r\n\r\n<p>1.3. Администрация Сайта вправе в любое время в одностороннем порядке изменять условия настоящего Соглашения. Такие изменения вступают в силу по истечении 3 (Трех) дней с момента размещения новой версии Соглашения на сайте. При несогласии Пользователя с внесенными изменениями он обязан отказаться от доступа к Сайту, прекратить использование материалов и сервисов Сайта.</p>\r\n\r\n<p><strong>2. Обязательства Пользователя</strong></p>\r\n\r\n<p>2.1. Пользователь соглашается не предпринимать действий, которые могут рассматриваться как нарушающие российское законодательство или нормы международного права, в том числе в сфере интеллектуальной собственности, <u>авторских </u>и/или <u>смежных правах</u>, а также любых действий, которые приводят или могут привести к нарушению нормальной работы Сайта и сервисов Сайта.</p>\r\n\r\n<p>2.2. Использование материалов Сайта без согласия правообладателей не допускается (статья 1270 Г.К РФ). Для правомерного использования материалов Сайта необходимо заключение <u>лицензионных договоров</u> (получение лицензий) от Правообладателей.</p>\r\n\r\n<p>2.3. При цитировании материалов Сайта, включая охраняемые авторские произведения, ссылка на Сайт обязательна (подпункт 1 пункта 1 статьи 1274 Г.К РФ).</p>\r\n\r\n<p>2.4. Комментарии и иные записи Пользователя на Сайте не должны вступать в противоречие с требованиями законодательства Российской Федерации и общепринятых норм морали и нравственности.</p>\r\n\r\n<p>2.5. Пользователь предупрежден о том, что Администрация Сайта не несет ответственности за посещение и использование им внешних ресурсов, ссылки на которые могут содержаться на сайте.</p>\r\n\r\n<p>2.6. Пользователь согласен с тем, что Администрация Сайта не несет ответственности и не имеет прямых или косвенных обязательств перед Пользователем в связи с любыми возможными или возникшими потерями или убытками, связанными с любым содержанием Сайта, <u>регистрацией авторских прав</u> и сведениями о такой регистрации, товарами или услугами, доступными на или полученными через внешние сайты или ресурсы либо иные контакты Пользователя, в которые он вступил, используя размещенную на Сайте информацию или ссылки на внешние ресурсы.</p>\r\n\r\n<p>2.7. Пользователь принимает положение о том, что все материалы и сервисы Сайта или любая их часть могут сопровождаться рекламой. Пользователь согласен с тем, что Администрация Сайта не несет какой-либо ответственности и не имеет каких-либо обязательств в связи с такой рекламой.</p>\r\n\r\n<p><strong>3. Прочие условия</strong></p>\r\n\r\n<p>3.1. Все возможные споры, вытекающие из настоящего Соглашения или связанные с ним, подлежат разрешению в соответствии с действующим законодательством Российской Федерации.</p>\r\n\r\n<p>3.2. Ничто в Соглашении не может пониматься как установление между Пользователем и Администрации Сайта агентских отношений, отношений товарищества, отношений по совместной деятельности, отношений личного найма, либо каких-то иных отношений, прямо не предусмотренных Соглашением.</p>\r\n\r\n<p>3.3. Признание судом какого-либо положения Соглашения недействительным или не подлежащим принудительному исполнению не влечет недействительности иных положений Соглашения.</p>\r\n\r\n<p>3.4. Бездействие со стороны Администрации Сайта в случае нарушения кем-либо из Пользователей положений Соглашения не лишает Администрацию Сайта права предпринять позднее соответствующие действия в защиту своих интересов и защиту авторских прав на охраняемые в соответствии с законодательством материалы Сайта.</p>\r\n\r\n<p><strong>Пользователь подтверждает, что ознакомлен со всеми пунктами настоящего Соглашения и безусловно принимает их.</strong></p>\r\n', 0, 4),
(3, 'Условия договора', 'Условия договора', 1767785921, 5),
(4, 'Политика конфиденциальности', 'Настоящая Политика конфиденциальности описывает порядок обработки и защиты персональных данных пользователей сайта.\n\n1. Общие положения\n\nИспользуя данный сайт, вы соглашаетесь с условиями настоящей Политики конфиденциальности. Если вы не согласны с условиями, пожалуйста, прекратите использование сайта.\n\n2. Какие данные мы собираем\n\nСайт может собирать следующую информацию:\n\nтехнические данные (IP-адрес, тип браузера, устройство);\n\nданные, передаваемые автоматически с помощью файлов cookie;\n\nинформацию, которую пользователь предоставляет добровольно (например, через формы обратной связи).\n\n3. Использование файлов cookie\n\nФайлы cookie используются для:\n\nкорректной работы сайта;\n\nулучшения пользовательского опыта;\n\nанализа посещаемости и поведения пользователей на сайте.\n\nВы можете отключить использование cookie в настройках вашего браузера.\n\n4. Цели обработки данных\n\nСобранные данные используются исключительно для:\n\nобеспечения работы сайта;\n\nулучшения качества сервиса;\n\nсвязи с пользователем при необходимости.\n\n5. Передача данных третьим лицам\n\nАдминистрация сайта не передает персональные данные третьим лицам, за исключением случаев, предусмотренных законодательством.\n\n6. Защита данных\n\nМы принимаем разумные меры для защиты персональной информации пользователей от утраты, неправомерного доступа и раскрытия.\n\n7. Изменения политики\n\nАдминистрация сайта имеет право вносить изменения в настоящую Политику конфиденциальности без предварительного уведомления. Актуальная версия всегда доступна на данной странице.\n\n8. Контактная информация\n\nПо всем вопросам, связанным с обработкой персональных данных, вы можете связаться с администрацией сайта через контактные данные, указанные на сайте.', 1768469235, 0),
(5, 'Политика конфиденциальности', 'Настоящая Политика конфиденциальности описывает порядок обработки и защиты персональных данных пользователей сайта.\r\n\r\n1. Общие положения\r\n\r\nИспользуя данный сайт, вы соглашаетесь с условиями настоящей Политики конфиденциальности. Если вы не согласны с условиями, пожалуйста, прекратите использование сайта.\r\n\r\n2. Какие данные мы собираем\r\n\r\nСайт может собирать следующую информацию:\r\n\r\nтехнические данные (IP-адрес, тип браузера, устройство);\r\n\r\nданные, передаваемые автоматически с помощью файлов cookie;\r\n\r\nинформацию, которую пользователь предоставляет добровольно (например, через формы обратной связи).\r\n\r\n3. Использование файлов cookie\r\n\r\nФайлы cookie используются для:\r\n\r\nкорректной работы сайта;\r\n\r\nулучшения пользовательского опыта;\r\n\r\nанализа посещаемости и поведения пользователей на сайте.\r\n\r\nВы можете отключить использование cookie в настройках вашего браузера.\r\n\r\n4. Цели обработки данных\r\n\r\nСобранные данные используются исключительно для:\r\n\r\nобеспечения работы сайта;\r\n\r\nулучшения качества сервиса;\r\n\r\nсвязи с пользователем при необходимости.\r\n\r\n5. Передача данных третьим лицам\r\n\r\nАдминистрация сайта не передает персональные данные третьим лицам, за исключением случаев, предусмотренных законодательством.\r\n\r\n6. Защита данных\r\n\r\nМы принимаем разумные меры для защиты персональной информации пользователей от утраты, неправомерного доступа и раскрытия.\r\n\r\n7. Изменения политики\r\n\r\nАдминистрация сайта имеет право вносить изменения в настоящую Политику конфиденциальности без предварительного уведомления. Актуальная версия всегда доступна на данной странице.\r\n\r\n8. Контактная информация\r\n\r\nПо всем вопросам, связанным с обработкой персональных данных, вы можете связаться с администрацией сайта через контактные данные, указанные на сайте.', 1768469235, 9);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pay_logs`
--

CREATE TABLE `ga_pay_logs` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `date_create` int(11) NOT NULL,
  `pay_methods` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `bill_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pay_methods`
--

CREATE TABLE `ga_pay_methods` (
  `id` int(11) NOT NULL,
  `status` decimal(10,0) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `typeCode` varchar(255) NOT NULL,
  `text` text,
  `icon_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_pay_methods`
--

INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`, `text`, `icon_path`) VALUES
(3, 0, 'Free-Kassa', '{\"fk_id\":\"\",\"fk_key1\":\"\",\"fk_key2\":\"\"}', 'freekassa', NULL, '/public/img/pay_methods/free-kassa.png'),
(4, 0, 'ЮMoney', '{\"receiver\":\"\",\"secret_key\":\"\"}', 'yoomoney', NULL, '/public/img/pay_methods/yoomoney.png'),
(5, 0, 'ЮKassa', '', 'yookassa', NULL, '/public/img/pay_methods/yookassa.png'),
(6, 0, 'Lava', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'lava', NULL, '/public/img/pay_methods/lava.png');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_promo_codes`
--

CREATE TABLE `ga_promo_codes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `amount` decimal(11,0) NOT NULL,
  `max_activations` int(11) DEFAULT NULL,
  `activations_count` int(11) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `expires_at` int(11) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `date_add` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_promo_code_activations`
--

CREATE TABLE `ga_promo_code_activations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_promo` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `amount` decimal(11,0) NOT NULL,
  `date_add` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `promo_user` (`id_promo`,`id_user`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_queue`
--

CREATE TABLE `ga_queue` (
  `id` int(11) NOT NULL,
  `status` varchar(255) NOT NULL,
  `attempt` int(11) NOT NULL,
  `max_attempt` int(11) NOT NULL,
  `message` text NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_servers`
--

CREATE TABLE `ga_servers` (
  `id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `moderation` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `game` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `port` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hostname` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `map` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `players` int(11) DEFAULT NULL,
  `max_players` int(11) DEFAULT NULL,
  `rating` int(11) NOT NULL DEFAULT '0',
  `top_enabled` int(11) DEFAULT NULL,
  `vip_enabled` int(11) DEFAULT NULL,
  `color_enabled` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gamemenu_enabled` int(11) DEFAULT NULL,
  `date_add` int(11) NOT NULL,
  `top_expired_date` int(11) DEFAULT NULL,
  `vip_expired_date` int(11) DEFAULT NULL,
  `color_expired_date` int(11) DEFAULT NULL,
  `gamemenu_expired_date` int(11) DEFAULT NULL,
  `boost` int(11) DEFAULT NULL,
  `boost_position` int(11) DEFAULT NULL,
  `country` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ban` int(11) DEFAULT '0',
  `ban_couse` varchar(300) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ban_date` int(11) DEFAULT NULL,
  `verification_rand` int(11) DEFAULT NULL,
  `verification_rand_expired_at` int(11) DEFAULT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci,
  `query_port` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_update_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_services`
--

CREATE TABLE `ga_services` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `period` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `params` text NOT NULL,
  `text` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_services`
--

INSERT INTO `ga_services` (`id`, `name`, `type`, `period`, `price`, `params`, `text`) VALUES
(2, 'TOP на 30 дней', 'top', 30, 1, '', NULL),
(4, 'VIP на 30 дней', 'vip', 30, 1, '', NULL),
(5, 'Выделение цветом 30 дней', 'color', 30, 1, '', NULL),
(6, 'Gamemenu на 30 дней', 'gamemenu', 30, 100, '', NULL),
(7, '100 Голосов для сервера', 'votes', 100, 1, '', NULL),
(8, 'Разбан сервера с бана', 'razz', 0, 1, '', NULL),
(10, 'Буст 1 круг', 'boost', 1, 15, '', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_settings`
--

CREATE TABLE `ga_settings` (
  `id` int(11) NOT NULL,
  `status_site` decimal(10,0) NOT NULL,
  `last_update_servers` decimal(10,0) NOT NULL,
  `content` text NOT NULL,
  `params_mail` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_settings`
--

INSERT INTO `ga_settings` (`id`, `status_site`, `last_update_servers`, `content`, `params_mail`) VALUES
(1, 1, 1769084898, '{\"global_settings\":{\"count_servers_main\":25,\"count_servers_top\":6,\"count_servers_vip\":25,\"count_servers_boost\":25,\"count_servers_color\":10,\"count_servers_gamemenu\":10,\"site_name\":\"Gms - веб движок\",\"expired_time_payment\":1,\"auto_add_server\":1,\"top_on\":1,\"boost_on\":1,\"vip_on\":1,\"color_on\":1,\"gamemenu_on\":0,\"votes_on\":1},\"comments\":{\"guest_allow\":1,\"moderation\":0}}', '{\"type\":\"smtp\",\"from\":\"\",\"smtp_server\":\"\",\"smtp_port\":\"\",\"encrypt\":\"none\",\"smtp_username\":\"\",\"smtp_password\":\"\",\"auto_tls\":false}');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_system_logs`
--

CREATE TABLE `ga_system_logs` (
  `id` int(11) NOT NULL COMMENT '11',
  `text` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_users`
--

CREATE TABLE `ga_users` (
  `id` int(11) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `password` varchar(300) NOT NULL,
  `email` varchar(300) NOT NULL,
  `hash` varchar(300) DEFAULT NULL,
  `balance` decimal(11,0) NOT NULL DEFAULT '0',
  `img` varchar(300) DEFAULT '/public/img/avatar.png',
  `date_reg` int(11) NOT NULL,
  `params` text,
  `api_login` varchar(255) DEFAULT NULL,
  `reset_code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_users`
--

INSERT INTO `ga_users` (`id`, `lastname`, `firstname`, `role`, `password`, `email`, `hash`, `balance`, `img`, `date_reg`, `params`, `api_login`, `reset_code`) VALUES
(4, 'System', 'Admin', 'admin', '$2y$10$.KSuIcEm95S.TFQg4CBik.EzUtQMMoC3Qa5wMylxfefKHRPtxXUZ2', 'admin@game-ms.ru', 'a87ff679a2f3e71d9181a67b7542122c', 0, '/public/img/avatar.png	', 1629893904, '{\"key_api\":\"\",\"discount_api\":\"\"}', '', NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `mslog`
--

CREATE TABLE `mslog` (
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

--
-- Дамп данных таблицы `mslog`
--

INSERT INTO `mslog` (`timeyear`, `timemonth`, `timeday`, `timehour`, `timeminute`, `timesecond`, `ip`, `port`, `type`) VALUES
('1', '1', '1', '1', '1', '1', '1', '1', '1'),
('2024', '09', '29', '15:00', '1', '1', '127.0.0.1', '2025', '1');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ga_code_colors`
--
ALTER TABLE `ga_code_colors`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_comments`
--
ALTER TABLE `ga_comments`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_games`
--
ALTER TABLE `ga_games`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_logs_vote`
--
ALTER TABLE `ga_logs_vote`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_news`
--
ALTER TABLE `ga_news`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_pages`
--
ALTER TABLE `ga_pages`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_pay_logs`
--
ALTER TABLE `ga_pay_logs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_pay_methods`
--
ALTER TABLE `ga_pay_methods`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_queue`
--
ALTER TABLE `ga_queue`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_servers`
--
ALTER TABLE `ga_servers`
  ADD PRIMARY KEY (`id`);
ALTER TABLE `ga_servers` ADD FULLTEXT KEY `hostname` (`hostname`,`map`);

--
-- Индексы таблицы `ga_services`
--
ALTER TABLE `ga_services`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_settings`
--
ALTER TABLE `ga_settings`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_system_logs`
--
ALTER TABLE `ga_system_logs`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ga_users`
--
ALTER TABLE `ga_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ga_code_colors`
--
ALTER TABLE `ga_code_colors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_comments`
--
ALTER TABLE `ga_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `ga_games`
--
ALTER TABLE `ga_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `ga_logs_vote`
--
ALTER TABLE `ga_logs_vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `ga_news`
--
ALTER TABLE `ga_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_pages`
--
ALTER TABLE `ga_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `ga_pay_logs`
--
ALTER TABLE `ga_pay_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ga_pay_methods`
--
ALTER TABLE `ga_pay_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `ga_queue`
--
ALTER TABLE `ga_queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_servers`
--
ALTER TABLE `ga_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `ga_services`
--
ALTER TABLE `ga_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `ga_settings`
--
ALTER TABLE `ga_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_system_logs`
--
ALTER TABLE `ga_system_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '11';

--
-- AUTO_INCREMENT для таблицы `ga_users`
--
ALTER TABLE `ga_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_services_periods`
--

CREATE TABLE `ga_services_periods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_service` int(11) NOT NULL,
  `period` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_service` (`id_service`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
