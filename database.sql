-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 07 2019 г., 12:27
-- Версия сервера: 5.6.37
-- Версия PHP: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `mon`
--

-- --------------------------------------------------------

--
-- Структура таблицы `ga_backup`
--

CREATE TABLE `ga_backup` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `date_create` int(11) NOT NULL,
  `hash` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `ga_comments`
--

CREATE TABLE `ga_comments` (
  `id` int(11) NOT NULL,
  `moderation` decimal(1,0) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_server` int(11) NOT NULL,
  `text` text NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_comments`
--

INSERT INTO `ga_comments` (`id`, `moderation`, `id_user`, `id_server`, `text`, `date_create`) VALUES
(1, '1', 1, 5, 'Классный сервер :) всем совету её (0)_(о) Классный сервер :) всем совету её (0)_(о) Классный сервер :) всем совету её (0)_(о) Классный сервер :) всем совету её (0)_(о) Классный сервер :) всем совету её (0)_(о) Классный сервер :) всем совету её (0)_(о)', 1545974295),
(17, '0', 1, 16, 'Хороший сервер)', 1554201712);

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
(1, 'cs', 'Counter Strike 1.6', '1'),
(2, 'csgo', 'Counter-Strike: Global Offensive', '1'),
(3, 'css', 'Counter Strike Sourse', '1'),
(4, 'tf2', 'Team Fortress 2', '1'),
(5, 'ld2', 'Left 4 Dead 2', '1');

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

--
-- Дамп данных таблицы `ga_logs_vote`
--

INSERT INTO `ga_logs_vote` (`id`, `ip`, `cookie`, `date_create`) VALUES
(5, '127.0.0.1', 'votePlus17', 1530712346),
(6, '127.0.0.1', 'votePlus10', 1530712419),
(7, '127.0.0.1', 'votePlus15', 1530712422),
(8, '127.0.0.1', 'votePlus21', 1530712598),
(9, '127.0.0.1', 'votePlus6', 1530712654),
(10, '127.0.0.1', 'votePlus4', 1530712751),
(11, '127.0.0.1', 'votePlus3', 1530712781),
(12, '127.0.0.1', 'votePlus5', 1530712819),
(13, '127.0.0.1', 'votePlus13', 1530712833),
(14, '127.0.0.1', 'votePlus9', 1530712841),
(15, '127.0.0.1', 'votePlus2', 1530791310),
(16, '127.0.0.1', 'votePlus9', 1530875084),
(17, '85.26.165.107', 'votePlus5', 1532166431),
(18, '85.26.165.107', 'votePlus9', 1532166437),
(19, '85.26.165.107', 'votePlus3', 1532166444),
(20, '85.26.165.107', 'votePlus12', 1532166448),
(21, '85.26.165.107', 'votePlus1', 1532167512),
(22, '217.118.93.85', 'votePlus4', 1532340328),
(23, '217.118.93.156', 'votePlus2', 1532934982),
(24, '217.118.93.156', 'votePlus2', 1532934983),
(25, '217.118.93.156', 'votePlus2', 1532934995),
(26, '217.118.93.156', 'votePlus2', 1532934995),
(27, '217.118.93.156', 'votePlus4', 1532935146),
(28, '217.118.93.156', 'votePlus4', 1532935153),
(29, '217.118.93.156', 'votePlus5', 1532935178),
(30, '217.118.93.156', 'votePlus3', 1532935187),
(31, '217.118.93.156', 'votePlus3', 1532942679),
(32, '217.118.93.156', 'votePlus1', 1532942744),
(33, '217.118.93.156', 'votePlus5', 1532952822),
(34, '217.118.93.171', 'votePlus15', 1532967583),
(35, '176.222.164.178', 'votePlus15', 1532971184),
(36, '176.222.164.178', 'votePlus15', 1532971186),
(37, '176.222.164.178', 'votePlus15', 1532971186),
(38, '176.222.164.178', 'votePlus15', 1532971186),
(39, '176.222.164.178', 'votePlus15', 1532971186),
(40, '176.222.164.178', 'votePlus4', 1532971205),
(41, '176.222.164.178', 'votePlus9', 1532971206),
(42, '85.26.232.204', 'votePlus5', 1533045346),
(43, '85.26.234.64', 'votePlus21', 1533198889),
(44, '85.26.234.1', 'votePlus5', 1533552183),
(45, '85.26.234.1', 'votePlus5', 1533552184),
(46, '85.26.234.1', 'votePlus3', 1533552186),
(47, '85.26.234.45', 'votePlus1', 1534508209),
(48, '85.26.234.45', 'votePlus1', 1534508217),
(49, '94.41.18.228', 'votePlus3', 1534693766),
(50, '94.41.18.228', 'votePlus5', 1534698254),
(51, '94.41.18.228', 'votePlus16', 1534699288),
(52, '94.41.18.228', 'votePlus22', 1534765035),
(53, '94.41.18.228', 'votePlus3', 1534775942),
(54, '94.41.18.228', 'votePlus21', 1534782923),
(55, '94.41.18.228', 'votePlus12', 1534782960),
(56, '94.41.18.228', 'votePlus13', 1534783044),
(57, '94.41.18.228', 'votePlus13', 1534783044),
(58, '94.41.18.228', 'votePlus26', 1534783050),
(59, '188.17.189.146', 'votePlus4', 1534783863),
(60, '5.166.123.21', 'votePlus28', 1534855295),
(61, '83.149.21.84', 'votePlus4', 1535098692),
(62, '83.149.21.84', 'votePlus17', 1535098838),
(63, '83.149.21.84', 'votePlus26', 1535098893),
(64, '', 'votePlus22', 1535098945),
(65, '', 'votePlus12', 1535098966),
(66, '', 'votePlus16', 1535098974),
(67, '85.26.164.104', 'votePlus4', 1535640891),
(68, '85.26.164.104', 'votePlus5', 1535641681),
(69, '178.46.76.51', 'votePlus4', 1535738103),
(70, '95.165.174.162', 'votePlus20', 1535891633),
(71, '95.165.174.162', 'votePlus20', 1535891634),
(72, '46.191.130.241', 'votePlus3', 1535907503),
(73, '46.191.130.241', 'votePlus20', 1535907508),
(74, '46.191.130.241', 'votePlus16', 1535907513),
(75, '46.191.130.241', 'votePlus21', 1535910539),
(76, '94.125.95.46', 'votePlus3', 1535951024),
(77, '94.125.95.46', 'votePlus3', 1535951025),
(78, '94.125.95.46', 'votePlus25', 1536121511),
(79, '94.125.95.46', 'votePlus22', 1536123273),
(80, '77.111.247.10', 'votePlus21', 1536158895),
(81, '145.255.2.13', 'votePlus16', 1536174056),
(82, '85.26.164.112', 'votePlus3', 1536204434),
(83, '85.26.164.112', 'votePlus3', 1536204438),
(84, '85.26.164.112', 'votePlus4', 1536204439),
(85, '85.26.164.112', 'votePlus5', 1536204446),
(86, '85.26.164.112', 'votePlus15', 1536204467),
(87, '94.125.95.46', 'votePlus20', 1536319608),
(88, '94.125.95.46', 'votePlus20', 1536319612),
(89, '94.125.95.46', 'votePlus20', 1536319612),
(90, '94.125.95.46', 'votePlus23', 1536319701),
(91, '85.26.165.185', 'votePlus5', 1536483136),
(92, '188.17.175.90', 'votePlus4', 1536499417),
(93, '176.121.224.227', 'votePlus19', 1536527134),
(94, '176.121.224.227', 'votePlus19', 1536527136),
(95, '94.41.242.237', 'votePlus3', 1536848586),
(96, '94.41.242.237', 'votePlus4', 1536849087),
(97, '94.125.95.46', 'votePlus15', 1537251446),
(98, '94.125.95.46', 'votePlus21', 1537261922),
(99, '94.125.95.46', 'votePlus25', 1537267615),
(100, '94.125.95.46', 'votePlus21', 1537267629),
(101, '94.41.242.237', 'votePlus25', 1537471450),
(102, '94.125.95.46', 'votePlus3', 1537512103),
(103, '94.125.95.46', 'votePlus16', 1537512107),
(104, '94.125.95.46', 'votePlus4', 1537512294),
(105, '94.125.95.46', 'votePlus22', 1537515663),
(106, '85.26.165.184', 'votePlus4', 1538994834),
(107, '85.26.235.214', 'votePlus9', 1539422604),
(108, '85.26.235.214', 'votePlus12', 1539424190),
(109, '85.26.235.214', 'votePlus23', 1539424193),
(110, '10.20.68.236', 'votePlus13', 1539424830),
(111, '85.26.235.214', 'votePlus22', 1539436293),
(112, '85.26.235.214', 'votePlus16', 1539436296),
(113, '85.26.235.214', 'votePlus4', 1539436299),
(114, '94.125.95.46', 'votePlus25', 1539769361),
(115, '94.125.95.46', 'votePlus21', 1541138474),
(116, '94.125.95.46', 'votePlus79', 1544173617),
(117, '194.54.160.80', 'votePlus21', 1544265317),
(118, '194.54.160.80', 'votePlus23', 1544530892),
(119, '94.125.95.46', 'votePlus23', 1544605571),
(120, '94.125.95.46', 'votePlus2', 1544606979),
(121, '194.154.74.106', 'votePlus28', 1544953677),
(122, '94.125.95.46', 'votePlus23', 1545911312),
(123, '94.125.95.46', 'votePlus1', 1545911943),
(124, '94.125.95.46', 'votePlus13', 1545914570),
(125, '94.125.95.46', 'votePlus28', 1545972714),
(126, '94.125.95.46', 'votePlus10', 1545972736),
(127, '94.125.95.46', 'votePlus37', 1545972748),
(128, '94.125.95.46', 'votePlus23', 1547035545),
(129, '94.125.95.46', 'votePlus13', 1547094024),
(130, '31.13.144.123', 'votePlus9', 1548080224),
(131, '94.125.95.46', 'votePlus23', 1548841459),
(132, '188.237.228.107', 'votePlus12', 1550170837),
(133, '217.118.93.90', 'votePlus13', 1550482080),
(134, '5.76.29.7', 'votePlus29', 1551002356),
(135, '31.13.144.107', 'votePlus4', 1554202699);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pages`
--

CREATE TABLE `ga_pages` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `date_create` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_pages`
--

INSERT INTO `ga_pages` (`id`, `title`, `text`, `date_create`) VALUES
(1, 'Контакты', 'Наша группа вконтакте: <b>vk.com/art_gaisin</b><br/>\r\nПочта: <b>support@gms.art-gaisin.ru</b> asdasd', 0),
(2, 'Пользовательское соглашение', '<p><strong>Пользовательское соглашение</strong></p>\r\n\r\n<p>Настоящее Соглашение определяет условия использования Пользователями материалов и сервисов сайта&nbsp;gms.art-gaisin.ru&nbsp; &nbsp; &nbsp; &nbsp; (далее&nbsp;&mdash; &laquo;Сайт&raquo;).</p>\r\n\r\n<p><strong>1.Общие условия</strong></p>\r\n\r\n<p>1.1. Использование материалов и сервисов Сайта регулируется нормами действующего законодательства Российской Федерации.</p>\r\n\r\n<p>1.2. Настоящее Соглашение является публичной офертой. Получая доступ к материалам Сайта Пользователь считается присоединившимся к настоящему Соглашению.</p>\r\n\r\n<p>1.3. Администрация Сайта вправе в любое время в одностороннем порядке изменять условия настоящего Соглашения. Такие изменения вступают в силу по истечении 3 (Трех) дней с момента размещения новой версии Соглашения на сайте. При несогласии Пользователя с внесенными изменениями он обязан отказаться от доступа к Сайту, прекратить использование материалов и сервисов Сайта.</p>\r\n\r\n<p><strong>2. Обязательства Пользователя</strong></p>\r\n\r\n<p>2.1. Пользователь соглашается не предпринимать действий, которые могут рассматриваться как нарушающие российское законодательство или нормы международного права, в том числе в сфере&nbsp;интеллектуальной собственности,&nbsp;<u>авторских&nbsp;</u>и/или&nbsp;<u>смежных правах</u>, а также любых действий, которые приводят или могут привести к нарушению нормальной работы Сайта и сервисов Сайта.</p>\r\n\r\n<p>2.2. Использование материалов Сайта без согласия&nbsp;правообладателей&nbsp;не допускается (статья 1270&nbsp;Г.К РФ). Для правомерного использования материалов Сайта необходимо заключение&nbsp;<u>лицензионных договоров</u>&nbsp;(получение лицензий) от Правообладателей.</p>\r\n\r\n<p>2.3. При&nbsp;цитировании&nbsp;материалов Сайта, включая охраняемые авторские произведения, ссылка на Сайт обязательна (подпункт 1 пункта 1 статьи 1274&nbsp;Г.К РФ).</p>\r\n\r\n<p>2.4. Комментарии и иные записи Пользователя на Сайте не должны вступать в противоречие с требованиями законодательства Российской Федерации и общепринятых норм морали и нравственности.</p>\r\n\r\n<p>2.5. Пользователь предупрежден о том, что Администрация Сайта не несет ответственности за посещение и использование им внешних ресурсов, ссылки на которые могут содержаться на сайте.</p>\r\n\r\n<p>2.6. Пользователь согласен с тем, что Администрация Сайта не несет ответственности и не имеет прямых или косвенных обязательств перед Пользователем в связи с любыми возможными или возникшими потерями или убытками, связанными с любым содержанием Сайта,&nbsp;<u>регистрацией авторских прав</u>&nbsp;и сведениями о такой регистрации, товарами или услугами, доступными на или полученными через внешние сайты или ресурсы либо иные контакты Пользователя, в которые он вступил, используя размещенную на Сайте информацию или ссылки на внешние ресурсы.</p>\r\n\r\n<p>2.7. Пользователь принимает положение о том, что все материалы и сервисы Сайта или любая их часть могут сопровождаться рекламой. Пользователь согласен с тем, что Администрация Сайта не несет какой-либо ответственности и не имеет каких-либо обязательств в связи с такой рекламой.</p>\r\n\r\n<p><strong>3. Прочие условия</strong></p>\r\n\r\n<p>3.1. Все возможные споры, вытекающие из настоящего Соглашения или связанные с ним, подлежат разрешению в соответствии с действующим законодательством Российской Федерации.</p>\r\n\r\n<p>3.2. Ничто в Соглашении не может пониматься как установление между Пользователем и Администрации Сайта агентских отношений, отношений товарищества, отношений по совместной деятельности, отношений личного найма, либо каких-то иных отношений, прямо не предусмотренных Соглашением.</p>\r\n\r\n<p>3.3. Признание судом какого-либо положения Соглашения недействительным или не подлежащим принудительному исполнению не влечет недействительности иных положений Соглашения.</p>\r\n\r\n<p>3.4. Бездействие со стороны Администрации Сайта в случае нарушения кем-либо из Пользователей положений Соглашения не лишает Администрацию Сайта права предпринять позднее соответствующие действия в защиту своих интересов и&nbsp;защиту авторских прав&nbsp;на охраняемые в соответствии с законодательством материалы Сайта.</p>\r\n\r\n<p><strong>Пользователь подтверждает, что ознакомлен со всеми пунктами настоящего Соглашения и безусловно принимает их.</strong></p>\r\n', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pay_logs`
--

CREATE TABLE `ga_pay_logs` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `id_user` int(11) NOT NULL,
  `date_create` int(100) NOT NULL,
  `pay_methods` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_pay_logs`
--

INSERT INTO `ga_pay_logs` (`id`, `content`, `id_user`, `date_create`, `pay_methods`, `status`) VALUES
(136, '{\"id_services\":1,\"type_pay\":\"payServices\",\"price\":\"1\",\"type\":\"top\",\"place\":5,\"id_server\":89}', 0, 1552441192, 'unitpay', 'paid'),
(137, '{\"id_services\":3,\"type_pay\":\"payServices\",\"price\":\"1\",\"type\":\"color\",\"color\":\"red\",\"id_server\":4}', 0, 1554202384, 'robokassa', 'paid');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_pay_methods`
--

CREATE TABLE `ga_pay_methods` (
  `id` int(11) NOT NULL,
  `status` decimal(10,0) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `typeCode` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_pay_methods`
--

INSERT INTO `ga_pay_methods` (`id`, `status`, `name`, `content`, `typeCode`) VALUES
(1, '0', 'Robokassa', '', 'robokassa'),
(2, '0', 'UnitPay', '{\"public_key\":\"133411-e686b\",\"secret_key\":\"338b3429cbe857ca0f53e03e8697892a\"}', 'unitpay');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_servers`
--

CREATE TABLE `ga_servers` (
  `id` int(11) NOT NULL,
  `status` decimal(10,0) NOT NULL,
  `moderation` decimal(10,0) NOT NULL,
  `id_user` decimal(11,0) NOT NULL,
  `game` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `port` varchar(255) NOT NULL,
  `hostname` varchar(300) NOT NULL,
  `map` varchar(300) NOT NULL,
  `players` int(11) NOT NULL,
  `max_players` int(11) NOT NULL,
  `rating` decimal(10,0) NOT NULL,
  `top_enabled` decimal(10,0) NOT NULL,
  `vip_enabled` decimal(10,0) NOT NULL,
  `color_enabled` varchar(255) NOT NULL,
  `date_add` int(11) NOT NULL,
  `top_expired_date` int(11) NOT NULL,
  `vip_expired_date` int(11) NOT NULL,
  `color_expired_date` int(1) NOT NULL,
  `boost` decimal(10,0) NOT NULL,
  `boost_position` decimal(10,0) NOT NULL,
  `country` varchar(64) NOT NULL,
  `ban` decimal(10,0) NOT NULL,
  `ban_couse` varchar(300) NOT NULL,
  `verification_rand` int(11) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_servers`
--

INSERT INTO `ga_servers` (`id`, `status`, `moderation`, `id_user`, `game`, `ip`, `port`, `hostname`, `map`, `players`, `max_players`, `rating`, `top_enabled`, `vip_enabled`, `color_enabled`, `date_add`, `top_expired_date`, `vip_expired_date`, `color_expired_date`, `boost`, `boost_position`, `country`, `ban`, `ban_couse`, `verification_rand`, `description`) VALUES
(35, '0', '1', '0', 'cs', '195.69.187.155', '28405', 'Новый сервер хостинга evo-host.ru', 'de_dust2_2x2', 0, 10, '0', '0', '0', '', 1538131844, 0, 0, 0, '1', '1538131844', 'UA', '0', '', 0, ''),
(37, '1', '1', '1', 'ld2', '46.174.48.86', '27015', 'CORE-SS :: Coop-24', 'c6m2_bedlam', 24, 24, '1', '0', '0', '', 1538135837, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(38, '0', '1', '1', 'csgo', '5.189.232.26', '27021', 'New Server', 'de_dust2', 0, 20, '1100', '0', '0', '', 1538331003, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(78, '0', '1', '0', 'cs', '194.87.146.36', '27016', '', '', 0, 0, '0', '0', '0', '', 1539163677, 0, 0, 0, '7', '1539163678', 'RU', '0', '', 0, ''),
(80, '0', '1', '0', 'cs', '109.248.229.41', '27015', '', '', 0, 0, '0', '0', '0', '', 1547365797, 0, 0, 0, '0', '0', 'RU', '0', '', 0, 'War3mod '),
(81, '1', '1', '0', 'cs', '46.174.52.14', '27220', 'INDEPENDENT PUBLIC 18+', 'cs_mansion', 14, 20, '0', '0', '0', '', 1548221022, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(82, '1', '1', '0', 'cs', '194.67.213.125', '27015', 'ПЕРВЫЙ НЕЗАВИСИМЫЙ ©', 'de_dust2_2x2', 0, 17, '0', '0', '0', '', 1548221058, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(83, '1', '1', '0', 'cs', '188.127.229.132', '27006', 'Последний выстрел за тобой 18+', 'cs_italy_2x2', 7, 32, '0', '0', '0', '', 1548954888, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(84, '0', '1', '0', 'cs', '185.162.142.76', '27015', '', '', 0, 0, '0', '0', '0', '', 1550170806, 0, 0, 0, '0', '0', 'MD', '0', '', 0, ''),
(85, '1', '1', '0', 'cs', '46.174.52.26', '27258', 'Блатной[Public+DM]', '$2000$', 1, 32, '0', '0', '0', '', 1550294582, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(86, '1', '1', '0', 'cs', '5.178.87.235', '27038', 'PSIHOTROPIC | ТВОЙ ПАБЛИК [PT]', 'de_dust2_2x2', 11, 32, '0', '0', '0', '', 1550481910, 0, 0, 0, '0', '0', 'RU', '0', '', 0, ''),
(87, '1', '1', '6', 'cs', '185.181.51.101', '27015', 'JackDaniels[MD] | Gaming Public [FRAGARI.RO]', 'fy_snow', 2, 32, '0', '0', '0', '', 1551538187, 0, 0, 0, '0', '0', 'MD', '0', '', 0, 'super server'),
(88, '1', '1', '0', 'cs', '151.80.113.111', '27015', 'Emirates-Gaming | Public 24/7', 'de_dust2', 21, 32, '0', '0', '0', '', 1551904282, 0, 0, 0, '0', '0', 'FR', '0', '', 0, 'Best Server in Pakistan Region'),
(89, '1', '1', '0', 'cs', '94.198.51.162', '27272', 'D_N_E_P_R  #1 [ 18+ ] UA', 'de_nuke', 0, 24, '0', '5', '0', '', 1552441060, 1557625205, 0, 0, '0', '0', 'RU', '0', '', 0, 'IP- 94.198.51.162:27272 : Разработка Заходи стреляй \r\nТебе однозначно у нас понравится, потому что: \r\n1. У нас замечательная администрация. \r\n2. Прекрасные, дружные игроки. \r\n3. Веселая атмосфера на сервере. \r\n4. Бесплатная VIP-ка всем, достигшим звания \"Генерал-майор\". \r\n5. Бесплатная VIP-ка девушкам. \r\n6. Круглосуточный онлайн.');

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
  `params` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_services`
--

INSERT INTO `ga_services` (`id`, `name`, `type`, `period`, `price`, `params`) VALUES
(1, 'TOP на 30 дней', 'top', 30, 1, ''),
(2, 'VIP на 30 дней', 'vip', 30, 1, ''),
(3, 'Выделение цветом 30 дней', 'color', 30, 1, '{\"red\":\"\\u041a\\u0440\\u0430\\u0441\\u043d\\u044b\\u0439\",\"blue\":\"\\u0421\\u0438\\u043d\\u0438\\u0439\",\"black\":\"\\u0427\\u0435\\u0440\\u043d\\u044b\\u0439\",\"white\":\"\\u0411\\u0435\\u043b\\u044b\\u0439\"}'),
(4, 'Boost 1 круг', 'boost', 1, 1, ''),
(6, '100 Голосов для сервера', 'votes', 100, 1, ''),
(7, 'Разбан сервера с бана', 'razz', 0, 1, '');

-- --------------------------------------------------------

--
-- Структура таблицы `ga_settings`
--

CREATE TABLE `ga_settings` (
  `id` int(11) NOT NULL,
  `status_site` decimal(10,0) NOT NULL,
  `last_update_servers` decimal(10,0) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_settings`
--

INSERT INTO `ga_settings` (`id`, `status_site`, `last_update_servers`, `content`) VALUES
(1, '1', '1554201788', '{\"global_settings\":{\"site_name\":\"Gms - \\u0432\\u0435\\u0431 \\u0434\\u0432\\u0438\\u0436\\u043e\\u043a\",\"auto_add_server\":\"1\",\"count_servers_top\":\"10\",\"count_servers_main\":\"30\",\"count_servers_vip\":\"10\",\"count_servers_boost\":\"30\",\"cron_key\":\"123\",\"auto_backup_database\":\"0\"},\"comments\":{\"guest_allow\":\"0\",\"moderation\":\"0\"}}');

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
  `hash` varchar(300) NOT NULL,
  `balance` decimal(11,0) NOT NULL,
  `img` varchar(300) NOT NULL,
  `date_reg` int(11) NOT NULL,
  `params` text NOT NULL,
  `api_login` varchar(255) NOT NULL,
  `reset_code` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `ga_users`
--

INSERT INTO `ga_users` (`id`, `lastname`, `firstname`, `role`, `password`, `email`, `hash`, `balance`, `img`, `date_reg`, `params`, `api_login`, `reset_code`) VALUES
(1, 'Иван', 'Иванов', 'admin', 'c514c91e4ed341f263e458d44b3bb0a7', 'demo@yandex.ru', 'c4ca4238a0b923820dcc509a6f75849b', '0', '/public/img/avatar.png', 0, '{\"key_api\":\"\",\"discount_api\":\"\"}', '', '9c58da3f0418ebdb53c02615f9ab7282');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `ga_backup`
--
ALTER TABLE `ga_backup`
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
-- Индексы таблицы `ga_users`
--
ALTER TABLE `ga_users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `ga_backup`
--
ALTER TABLE `ga_backup`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `ga_comments`
--
ALTER TABLE `ga_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT для таблицы `ga_games`
--
ALTER TABLE `ga_games`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT для таблицы `ga_logs_vote`
--
ALTER TABLE `ga_logs_vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=136;
--
-- AUTO_INCREMENT для таблицы `ga_pages`
--
ALTER TABLE `ga_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `ga_pay_logs`
--
ALTER TABLE `ga_pay_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=138;
--
-- AUTO_INCREMENT для таблицы `ga_pay_methods`
--
ALTER TABLE `ga_pay_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `ga_servers`
--
ALTER TABLE `ga_servers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;
--
-- AUTO_INCREMENT для таблицы `ga_services`
--
ALTER TABLE `ga_services`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `ga_settings`
--
ALTER TABLE `ga_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `ga_users`
--
ALTER TABLE `ga_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
