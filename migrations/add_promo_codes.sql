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
