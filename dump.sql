-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 28 2025 г., 18:16
-- Версия сервера: 8.0.42-0ubuntu0.22.04.1
-- Версия PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `dev777`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ga_code_colors`
--

CREATE TABLE `ga_code_colors` (
  `id` int NOT NULL,
  `code` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL DEFAULT 'none',
  `name` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_unicode_ci NOT NULL,
  `activ` int DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

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
  `id` int NOT NULL,
  `moderation` decimal(1,0) NOT NULL,
  `id_user` int DEFAULT NULL,
  `id_server` int NOT NULL,
  `text` text NOT NULL,
  `date_create` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_games`
--

CREATE TABLE `ga_games` (
  `id` int NOT NULL,
  `code` varchar(255) NOT NULL,
  `game` varchar(255) NOT NULL,
  `status` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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
  `id` int NOT NULL,
  `ip` varchar(255) NOT NULL,
  `cookie` varchar(255) NOT NULL,
  `date_create` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_news`
--

CREATE TABLE `ga_news` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `date_create` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `date_create` int NOT NULL,
  `count_visited` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `ga_pages`
--

INSERT INTO `ga_pages` (`id`, `title`, `text`, `date_create`, `count_visited`) VALUES
(1, 'Контакты', 'Группа вк: <b>https://vk.com/dev_gamems</b><br/>\r\nПочта: <b>support@game-ms.ru</b>', 0, 29),
(2, 'Пользовательское соглашение', '<p><strong>Пользовательское соглашение</strong></p>\r\n\r\n<p>Настоящее Соглашение определяет условия использования Пользователями материалов и сервисов сайта game-ms.ru        (далее — «Сайт»).</p>\r\n\r\n<p><strong>1.Общие условия</strong></p>\r\n\r\n<p>1.1. Использование материалов и сервисов Сайта регулируется нормами действующего законодательства Российской Федерации.</p>\r\n\r\n<p>1.2. Настоящее Соглашение является публичной офертой. Получая доступ к материалам Сайта Пользователь считается присоединившимся к настоящему Соглашению.</p>\r\n\r\n<p>1.3. Администрация Сайта вправе в любое время в одностороннем порядке изменять условия настоящего Соглашения. Такие изменения вступают в силу по истечении 3 (Трех) дней с момента размещения новой версии Соглашения на сайте. При несогласии Пользователя с внесенными изменениями он обязан отказаться от доступа к Сайту, прекратить использование материалов и сервисов Сайта.</p>\r\n\r\n<p><strong>2. Обязательства Пользователя</strong></p>\r\n\r\n<p>2.1. Пользователь соглашается не предпринимать действий, которые могут рассматриваться как нарушающие российское законодательство или нормы международного права, в том числе в сфере интеллектуальной собственности, <u>авторских </u>и/или <u>смежных правах</u>, а также любых действий, которые приводят или могут привести к нарушению нормальной работы Сайта и сервисов Сайта.</p>\r\n\r\n<p>2.2. Использование материалов Сайта без согласия правообладателей не допускается (статья 1270 Г.К РФ). Для правомерного использования материалов Сайта необходимо заключение <u>лицензионных договоров</u> (получение лицензий) от Правообладателей.</p>\r\n\r\n<p>2.3. При цитировании материалов Сайта, включая охраняемые авторские произведения, ссылка на Сайт обязательна (подпункт 1 пункта 1 статьи 1274 Г.К РФ).</p>\r\n\r\n<p>2.4. Комментарии и иные записи Пользователя на Сайте не должны вступать в противоречие с требованиями законодательства Российской Федерации и общепринятых норм морали и нравственности.</p>\r\n\r\n<p>2.5. Пользователь предупрежден о том, что Администрация Сайта не несет ответственности за посещение и использование им внешних ресурсов, ссылки на которые могут содержаться на сайте.</p>\r\n\r\n<p>2.6. Пользователь согласен с тем, что Администрация Сайта не несет ответственности и не имеет прямых или косвенных обязательств перед Пользователем в связи с любыми возможными или возникшими потерями или убытками, связанными с любым содержанием Сайта, <u>регистрацией авторских прав</u> и сведениями о такой регистрации, товарами или услугами, доступными на или полученными через внешние сайты или ресурсы либо иные контакты Пользователя, в которые он вступил, используя размещенную на Сайте информацию или ссылки на внешние ресурсы.</p>\r\n\r\n<p>2.7. Пользователь принимает положение о том, что все материалы и сервисы Сайта или любая их часть могут сопровождаться рекламой. Пользователь согласен с тем, что Администрация Сайта не несет какой-либо ответственности и не имеет каких-либо обязательств в связи с такой рекламой.</p>\r\n\r\n<p><strong>3. Прочие условия</strong></p>\r\n\r\n<p>3.1. Все возможные споры, вытекающие из настоящего Соглашения или связанные с ним, подлежат разрешению в соответствии с действующим законодательством Российской Федерации.</p>\r\n\r\n<p>3.2. Ничто в Соглашении не может пониматься как установление между Пользователем и Администрации Сайта агентских отношений, отношений товарищества, отношений по совместной деятельности, отношений личного найма, либо каких-то иных отношений, прямо не предусмотренных Соглашением.</p>\r\n\r\n<p>3.3. Признание судом какого-либо положения Соглашения недействительным или не подлежащим принудительному исполнению не влечет недействительности иных положений Соглашения.</p>\r\n\r\n<p>3.4. Бездействие со стороны Администрации Сайта в случае нарушения кем-либо из Пользователей положений Соглашения не лишает Администрацию Сайта права предпринять позднее соответствующие действия в защиту своих интересов и защиту авторских прав на охраняемые в соответствии с законодательством материалы Сайта.</p>\r\n\r\n<p><strong>Пользователь подтверждает, что ознакомлен со всеми пунктами настоящего Соглашения и безусловно принимает их.</strong></p>\r\n', 0, 3);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pay_logs`
--

CREATE TABLE `ga_pay_logs` (
  `id` int NOT NULL,
  `content` text NOT NULL,
  `id_user` int DEFAULT NULL,
  `date_create` int NOT NULL,
  `pay_methods` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `bill_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pay_methods`
--

CREATE TABLE `ga_pay_methods` (
  `id` int NOT NULL,
  `status` decimal(10,0) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `typeCode` varchar(255) NOT NULL,
  `text` text,
  `icon_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `ga_pay_methods`
--

INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`, `text`, `icon_path`) VALUES
(3, 0, 'Free-Kassa', '{\"fk_id\":\"\",\"fk_key1\":\"\",\"fk_key2\":\"\"}', 'freekassa', NULL, '/public/img/pay_methods/free-kassa.png'),
(4, 0, 'ЮMoney', '{\"receiver\":\"\",\"secret_key\":\"\"}', 'yoomoney', NULL, '/public/img/pay_methods/yoomoney.png'),
(5, 0, 'ЮKassa', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'yookassa', NULL, '/public/img/pay_methods/yookassa.png'),
(6, 0, 'Lava', '{\"shop_id\":\"\",\"secret_key\":\"\"}', 'lava', NULL, '/public/img/pay_methods/lava.png');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_queue`
--

CREATE TABLE `ga_queue` (
  `id` int NOT NULL,
  `status` varchar(255) NOT NULL,
  `attempt` int NOT NULL,
  `max_attempt` int NOT NULL,
  `message` text NOT NULL,
  `date_create` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_servers`
--

CREATE TABLE `ga_servers` (
  `id` int NOT NULL,
  `status` int NOT NULL,
  `moderation` int NOT NULL,
  `id_user` int NOT NULL,
  `game` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `hostname` varchar(500) DEFAULT NULL,
  `map` varchar(300) DEFAULT NULL,
  `players` int DEFAULT NULL,
  `max_players` int DEFAULT NULL,
  `rating` int NOT NULL DEFAULT '0',
  `befirst_enabled` int DEFAULT '0',
  `top_enabled` int DEFAULT '0',
  `vip_enabled` int DEFAULT '0',
  `color_enabled` varchar(255) DEFAULT '0',
  `gamemenu_enabled` int DEFAULT '0',
  `date_add` int NOT NULL,
  `top_expired_date` int DEFAULT NULL,
  `vip_expired_date` int DEFAULT NULL,
  `color_expired_date` int DEFAULT NULL,
  `gamemenu_expired_date` int DEFAULT NULL,
  `boost` int DEFAULT '0',
  `boost_position` int DEFAULT '0',
  `country` varchar(64) DEFAULT NULL,
  `ban` int DEFAULT '0',
  `ban_couse` varchar(300) DEFAULT NULL,
  `ban_date` int DEFAULT NULL,
  `verification_rand` int DEFAULT NULL,
  `verification_rand_expired_at` int DEFAULT NULL,
  `description` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_services`
--

CREATE TABLE `ga_services` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `period` int NOT NULL,
  `price` int NOT NULL,
  `params` text NOT NULL,
  `text` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

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
  `id` int NOT NULL,
  `status_site` decimal(10,0) NOT NULL,
  `last_update_servers` decimal(10,0) NOT NULL,
  `content` text NOT NULL,
  `params_mail` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `ga_settings`
--

INSERT INTO `ga_settings` (`id`, `status_site`, `last_update_servers`, `content`, `params_mail`) VALUES
(1, 1, 1727929588, '{\"global_settings\":{\"site_name\":\"Gms - \\u0432\\u0435\\u0431 \\u0434\\u0432\\u0438\\u0436\\u043e\\u043a\",\"expired_time_payment\":\"1\",\"auto_add_server\":\"1\",\"count_servers_main\":\"25\",\"count_servers_top\":\"6\",\"count_servers_vip\":\"50\",\"count_servers_boost\":\"30\",\"count_servers_color\":\"20\",\"count_servers_gamemenu\":\"5\",\"top_on\":\"1\",\"boost_on\":\"1\",\"vip_on\":\"1\",\"color_on\":\"1\",\"gamemenu_on\":\"1\",\"votes_on\":\"1\"},\"comments\":{\"guest_allow\":\"1\",\"moderation\":\"0\"}}', '{\"type\":\"smtp\",\"from\":\"\",\"smtp_server\":\"\",\"smtp_port\":\"\",\"encrypt\":\"\",\"smtp_username\":\"\",\"smtp_password\":\"\",\"auto_tls\":false}');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_system_logs`
--

CREATE TABLE `ga_system_logs` (
  `id` int NOT NULL COMMENT '11',
  `text` text CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `date_create` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_users`
--

CREATE TABLE `ga_users` (
  `id` int NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'user',
  `password` varchar(300) NOT NULL,
  `email` varchar(300) NOT NULL,
  `hash` varchar(300) DEFAULT NULL,
  `balance` decimal(11,0) NOT NULL DEFAULT '0',
  `img` varchar(300) DEFAULT '/public/img/avatar.png',
  `date_reg` int NOT NULL,
  `params` text,
  `api_login` varchar(255) DEFAULT NULL,
  `reset_code` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `ga_users`
--

INSERT INTO `ga_users` (`id`, `lastname`, `firstname`, `role`, `password`, `email`, `hash`, `balance`, `img`, `date_reg`, `params`, `api_login`, `reset_code`) VALUES
(4, 'System', 'Admin', 'admin', '$2y$10$.KSuIcEm95S.TFQg4CBik.EzUtQMMoC3Qa5wMylxfefKHRPtxXUZ2', 'admin@game-ms.ru', 'a87ff679a2f3e71d9181a67b7542122c', 1000, '/public/img/avatar.png	', 1629893904, '{\"key_api\":\"\",\"discount_api\":\"\"}', '', NULL);

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_comments`
--
ALTER TABLE `ga_comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `ga_games`
--
ALTER TABLE `ga_games`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `ga_logs_vote`
--
ALTER TABLE `ga_logs_vote`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `ga_news`
--
ALTER TABLE `ga_news`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_pages`
--
ALTER TABLE `ga_pages`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `ga_pay_logs`
--
ALTER TABLE `ga_pay_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT для таблицы `ga_pay_methods`
--
ALTER TABLE `ga_pay_methods`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `ga_queue`
--
ALTER TABLE `ga_queue`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `ga_servers`
--
ALTER TABLE `ga_servers`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `ga_services`
--
ALTER TABLE `ga_services`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT для таблицы `ga_settings`
--
ALTER TABLE `ga_settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `ga_system_logs`
--
ALTER TABLE `ga_system_logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT COMMENT '11', AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT для таблицы `ga_users`
--
ALTER TABLE `ga_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
