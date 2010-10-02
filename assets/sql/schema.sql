CREATE TABLE IF NOT EXISTS `member` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(256) collate utf8_unicode_ci NOT NULL,
  `email` varchar(256) collate utf8_unicode_ci NOT NULL,
  `passwd` varchar(256) collate utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;


CREATE TABLE IF NOT EXISTS `twitter` (
  `id` int(11) NOT NULL auto_increment,
  `member_id` int(11) NOT NULL,
  `access_token` varchar(255) NOT NULL,
  `access_token_secret` varchar(255) NOT NULL,
  `user_id` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL,
  `screen_name` varchar(255) character set utf8 collate utf8_unicode_ci NOT NULL,
  `status` smallint(2) NOT NULL default '2',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `account` (`access_token`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`),
  KEY `member_id` (`member_id`),
  KEY `status` (`status`),
  KEY `screen_name` (`screen_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;
