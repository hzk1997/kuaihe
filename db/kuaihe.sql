/*
Navicat MySQL Data Transfer

Source Server         : mySQL
Source Server Version : 50560
Source Host           : localhost:3306
Source Database       : kuaihe

Target Server Type    : MYSQL
Target Server Version : 50560
File Encoding         : 65001

Date: 2018-12-04 12:38:28
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of auth_group
-- ----------------------------

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_0e939a4f` (`group_id`),
  KEY `auth_group_permissions_8373b171` (`permission_id`),
  CONSTRAINT `auth_group_permissi_permission_id_23962d04_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_58c48ba9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of auth_group_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_417f1b1c` (`content_type_id`),
  CONSTRAINT `auth_permissi_content_type_id_51277a81_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
INSERT INTO `auth_permission` VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO `auth_permission` VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO `auth_permission` VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO `auth_permission` VALUES ('4', 'Can add permission', '2', 'add_permission');
INSERT INTO `auth_permission` VALUES ('5', 'Can change permission', '2', 'change_permission');
INSERT INTO `auth_permission` VALUES ('6', 'Can delete permission', '2', 'delete_permission');
INSERT INTO `auth_permission` VALUES ('7', 'Can add group', '3', 'add_group');
INSERT INTO `auth_permission` VALUES ('8', 'Can change group', '3', 'change_group');
INSERT INTO `auth_permission` VALUES ('9', 'Can delete group', '3', 'delete_group');
INSERT INTO `auth_permission` VALUES ('10', 'Can add content type', '4', 'add_contenttype');
INSERT INTO `auth_permission` VALUES ('11', 'Can change content type', '4', 'change_contenttype');
INSERT INTO `auth_permission` VALUES ('12', 'Can delete content type', '4', 'delete_contenttype');
INSERT INTO `auth_permission` VALUES ('13', 'Can add session', '5', 'add_session');
INSERT INTO `auth_permission` VALUES ('14', 'Can change session', '5', 'change_session');
INSERT INTO `auth_permission` VALUES ('15', 'Can delete session', '5', 'delete_session');

-- ----------------------------
-- Table structure for df_address
-- ----------------------------
DROP TABLE IF EXISTS `df_address`;
CREATE TABLE `df_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `addr` varchar(256) NOT NULL,
  `zip_code` varchar(6) DEFAULT NULL,
  `phone` varchar(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_address_e8701ad4` (`user_id`),
  CONSTRAINT `df_address_user_id_6878ce42_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_address
-- ----------------------------

-- ----------------------------
-- Table structure for df_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_goods`;
CREATE TABLE `df_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `detail` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_goods
-- ----------------------------

-- ----------------------------
-- Table structure for df_goods_image
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_image`;
CREATE TABLE `df_goods_image` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_image_22ad5bca` (`sku_id`),
  CONSTRAINT `df_goods_image_sku_id_eacfb01_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_goods_image
-- ----------------------------

-- ----------------------------
-- Table structure for df_goods_sku
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_sku`;
CREATE TABLE `df_goods_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `desc` varchar(256) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `unite` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  `stock` int(11) NOT NULL,
  `sales` int(11) NOT NULL,
  `status` smallint(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_goods_sku_6753b66e` (`goods_id`),
  KEY `df_goods_sku_94757cae` (`type_id`),
  CONSTRAINT `df_goods_sku_type_id_41eda677_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`),
  CONSTRAINT `df_goods_sku_goods_id_28b2537a_fk_df_goods_id` FOREIGN KEY (`goods_id`) REFERENCES `df_goods` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_goods_sku
-- ----------------------------

-- ----------------------------
-- Table structure for df_goods_type
-- ----------------------------
DROP TABLE IF EXISTS `df_goods_type`;
CREATE TABLE `df_goods_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `logo` varchar(20) NOT NULL,
  `image` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_goods_type
-- ----------------------------

-- ----------------------------
-- Table structure for df_index_banner
-- ----------------------------
DROP TABLE IF EXISTS `df_index_banner`;
CREATE TABLE `df_index_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_banner_22ad5bca` (`sku_id`),
  CONSTRAINT `df_index_banner_sku_id_25e871f1_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_index_banner
-- ----------------------------

-- ----------------------------
-- Table structure for df_index_promotion
-- ----------------------------
DROP TABLE IF EXISTS `df_index_promotion`;
CREATE TABLE `df_index_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `name` varchar(20) NOT NULL,
  `url` varchar(256) NOT NULL,
  `image` varchar(100) NOT NULL,
  `index` smallint(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_index_promotion
-- ----------------------------

-- ----------------------------
-- Table structure for df_index_type_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_index_type_goods`;
CREATE TABLE `df_index_type_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `display_type` smallint(6) NOT NULL,
  `index` smallint(6) NOT NULL,
  `sku_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_index_type_goods_22ad5bca` (`sku_id`),
  KEY `df_index_type_goods_94757cae` (`type_id`),
  CONSTRAINT `df_index_type_goods_type_id_7cdd324c_fk_df_goods_type_id` FOREIGN KEY (`type_id`) REFERENCES `df_goods_type` (`id`),
  CONSTRAINT `df_index_type_goods_sku_id_65287640_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_index_type_goods
-- ----------------------------

-- ----------------------------
-- Table structure for df_order_goods
-- ----------------------------
DROP TABLE IF EXISTS `df_order_goods`;
CREATE TABLE `df_order_goods` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `count` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `comment` varchar(256) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `sku_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `df_order_goods_69dfcb07` (`order_id`),
  KEY `df_order_goods_22ad5bca` (`sku_id`),
  CONSTRAINT `df_order_goods_sku_id_625e637c_fk_df_goods_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `df_goods_sku` (`id`),
  CONSTRAINT `df_order_goods_order_id_3b0bf63f_fk_df_order_info_order_id` FOREIGN KEY (`order_id`) REFERENCES `df_order_info` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_order_goods
-- ----------------------------

-- ----------------------------
-- Table structure for df_order_info
-- ----------------------------
DROP TABLE IF EXISTS `df_order_info`;
CREATE TABLE `df_order_info` (
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  `order_id` varchar(128) NOT NULL,
  `pay_method` smallint(6) NOT NULL,
  `total_count` int(11) NOT NULL,
  `total_price` decimal(10,2) NOT NULL,
  `transit_price` decimal(10,2) NOT NULL,
  `order_status` smallint(6) NOT NULL,
  `trade_no` varchar(128) NOT NULL,
  `addr_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `df_order_info_90ccbf41` (`addr_id`),
  KEY `df_order_info_df138c17` (`user_id`),
  CONSTRAINT `df_order_info_user_id_359a86b0_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`),
  CONSTRAINT `df_order_info_addr_id_78df6d40_fk_df_address_id` FOREIGN KEY (`addr_id`) REFERENCES `df_address` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_order_info
-- ----------------------------

-- ----------------------------
-- Table structure for df_user
-- ----------------------------
DROP TABLE IF EXISTS `df_user`;
CREATE TABLE `df_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  `create_time` datetime NOT NULL,
  `update_time` datetime NOT NULL,
  `is_delete` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_user
-- ----------------------------
INSERT INTO `df_user` VALUES ('8', 'pbkdf2_sha256$15000$Tip0k64Gz2ki$ueetjKEv+hfu9CtWWZJxUryYkEHj4mUukHVJnIPhdyk=', '2018-11-30 13:02:26', '0', 'qq111111', '', '', '123123123@qq.com', '0', '0', '2018-11-30 13:02:26', '2018-11-30 13:02:26', '2018-11-30 13:02:26', '0');
INSERT INTO `df_user` VALUES ('9', 'pbkdf2_sha256$15000$q7fuBHDugXG6$CGubgT0wSHapar/XvDH3sWZLQJTH9bAs0zvIGAfOAdI=', '2018-12-01 14:12:23', '0', 'qweqweqwe', '', '', 'asdasdasd@qq.com', '0', '0', '2018-12-01 14:12:23', '2018-12-01 14:12:23', '2018-12-01 14:12:23', '0');
INSERT INTO `df_user` VALUES ('10', 'pbkdf2_sha256$15000$8DMK7CMEkqtr$5Y25VwumaifrGg22W7P/9b2F1r0Ao7CQebwoXVSEkwM=', '2018-12-01 14:22:17', '0', 'qq111', '', '', 'huzhikai9213@gmail.com', '0', '0', '2018-12-01 14:22:17', '2018-12-01 14:22:18', '2018-12-01 14:22:18', '0');
INSERT INTO `df_user` VALUES ('11', 'pbkdf2_sha256$15000$nbfDPajEVGlw$nwOBDU7ROm6fTCLmxJQnppuseHmGqGIDp5gvfhbcYa8=', '2018-12-03 14:21:36', '0', 'huasd', '', '', 'asdasdasd@qq.com', '0', '0', '2018-12-03 14:09:50', '2018-12-03 14:09:51', '2018-12-03 14:09:51', '0');
INSERT INTO `df_user` VALUES ('12', 'pbkdf2_sha256$15000$BVBp1HLExHEx$suybvRC2PtxgC+h2AzfM5SmFp3j4J+Q7ZyWgQ3M+X08=', '2018-12-04 03:48:56', '0', 'www111', '', '', '123123qq@qq.com', '0', '0', '2018-12-04 03:41:18', '2018-12-04 03:41:18', '2018-12-04 03:41:18', '0');

-- ----------------------------
-- Table structure for df_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `df_user_groups`;
CREATE TABLE `df_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `df_user_groups_e8701ad4` (`user_id`),
  KEY `df_user_groups_0e939a4f` (`group_id`),
  CONSTRAINT `df_user_groups_group_id_48aacf6d_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `df_user_groups_user_id_43d221a_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_user_groups
-- ----------------------------

-- ----------------------------
-- Table structure for df_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `df_user_user_permissions`;
CREATE TABLE `df_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `df_user_user_permissions_e8701ad4` (`user_id`),
  KEY `df_user_user_permissions_8373b171` (`permission_id`),
  CONSTRAINT `df_user_user_permis_permission_id_496922c2_fk_auth_permission_id` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `df_user_user_permissions_user_id_4f5124e4_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of df_user_user_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_417f1b1c` (`content_type_id`),
  KEY `django_admin_log_e8701ad4` (`user_id`),
  CONSTRAINT `django_admin_log_user_id_1c5f563_fk_df_user_id` FOREIGN KEY (`user_id`) REFERENCES `df_user` (`id`),
  CONSTRAINT `django_admin__content_type_id_5151027a_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of django_admin_log
-- ----------------------------

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_3ec8c61c_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
INSERT INTO `django_content_type` VALUES ('1', 'log entry', 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES ('2', 'permission', 'auth', 'permission');
INSERT INTO `django_content_type` VALUES ('3', 'group', 'auth', 'group');
INSERT INTO `django_content_type` VALUES ('4', 'content type', 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES ('5', 'session', 'sessions', 'session');

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
INSERT INTO `django_migrations` VALUES ('1', 'contenttypes', '0001_initial', '2018-11-26 03:34:59');
INSERT INTO `django_migrations` VALUES ('2', 'auth', '0001_initial', '2018-11-26 03:35:00');
INSERT INTO `django_migrations` VALUES ('3', 'users', '0001_initial', '2018-11-26 03:35:00');
INSERT INTO `django_migrations` VALUES ('4', 'admin', '0001_initial', '2018-11-26 03:35:00');
INSERT INTO `django_migrations` VALUES ('5', 'goods', '0001_initial', '2018-11-26 03:35:01');
INSERT INTO `django_migrations` VALUES ('6', 'order', '0001_initial', '2018-11-26 03:35:01');
INSERT INTO `django_migrations` VALUES ('7', 'order', '0002_auto_20181126_1134', '2018-11-26 03:35:01');
INSERT INTO `django_migrations` VALUES ('8', 'order', '0003_auto_20181126_1134', '2018-11-26 03:35:02');
INSERT INTO `django_migrations` VALUES ('9', 'sessions', '0001_initial', '2018-11-26 03:35:02');

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_de54fa62` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of django_session
-- ----------------------------
INSERT INTO `django_session` VALUES ('kyplzyaqe67fmyi4o8uvg32wkw5707eb', 'OWIwMmVlMThjNzhlNmY2NmYzZDU4YmMwMTBlMzVjY2Q0Yzc3YmUwODp7Il9hdXRoX3VzZXJfaGFzaCI6ImEyMjY3YzkwYTM0ZTVmN2IzN2I2NTMwMzA0ODYzNDMwZGIxYzA1ZjciLCJfYXV0aF91c2VyX2lkIjoxMiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQifQ==', '2018-12-18 03:48:56');
