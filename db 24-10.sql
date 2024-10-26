/*
SQLyog Community v13.1.5  (64 bit)
MySQL - 8.0.33 : Database - snaptures
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`snaptures` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `snaptures`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add comment',7,'add_comment'),
(26,'Can change comment',7,'change_comment'),
(27,'Can delete comment',7,'delete_comment'),
(28,'Can view comment',7,'view_comment'),
(29,'Can add login',8,'add_login'),
(30,'Can change login',8,'change_login'),
(31,'Can delete login',8,'delete_login'),
(32,'Can view login',8,'view_login'),
(33,'Can add user',9,'add_user'),
(34,'Can change user',9,'change_user'),
(35,'Can delete user',9,'delete_user'),
(36,'Can view user',9,'view_user'),
(37,'Can add report',10,'add_report'),
(38,'Can change report',10,'change_report'),
(39,'Can delete report',10,'delete_report'),
(40,'Can view report',10,'view_report'),
(41,'Can add post',11,'add_post'),
(42,'Can change post',11,'change_post'),
(43,'Can delete post',11,'delete_post'),
(44,'Can view post',11,'view_post'),
(45,'Can add like',12,'add_like'),
(46,'Can change like',12,'change_like'),
(47,'Can delete like',12,'delete_like'),
(48,'Can view like',12,'view_like'),
(49,'Can add follow_request',13,'add_follow_request'),
(50,'Can change follow_request',13,'change_follow_request'),
(51,'Can delete follow_request',13,'delete_follow_request'),
(52,'Can view follow_request',13,'view_follow_request'),
(53,'Can add feedback',14,'add_feedback'),
(54,'Can change feedback',14,'change_feedback'),
(55,'Can delete feedback',14,'delete_feedback'),
(56,'Can view feedback',14,'view_feedback'),
(57,'Can add complaint',15,'add_complaint'),
(58,'Can change complaint',15,'change_complaint'),
(59,'Can delete complaint',15,'delete_complaint'),
(60,'Can view complaint',15,'view_complaint'),
(61,'Can add chat',16,'add_chat'),
(62,'Can change chat',16,'change_chat'),
(63,'Can delete chat',16,'delete_chat'),
(64,'Can view chat',16,'view_chat'),
(65,'Can add disike',17,'add_disike'),
(66,'Can change disike',17,'change_disike'),
(67,'Can delete disike',17,'delete_disike'),
(68,'Can view disike',17,'view_disike');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(16,'myapp','chat'),
(7,'myapp','comment'),
(15,'myapp','complaint'),
(17,'myapp','disike'),
(14,'myapp','feedback'),
(13,'myapp','follow_request'),
(12,'myapp','like'),
(8,'myapp','login'),
(11,'myapp','post'),
(10,'myapp','report'),
(9,'myapp','user'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2024-10-24 04:51:58.615635'),
(2,'auth','0001_initial','2024-10-24 04:51:58.947816'),
(3,'admin','0001_initial','2024-10-24 04:51:59.037413'),
(4,'admin','0002_logentry_remove_auto_add','2024-10-24 04:51:59.044470'),
(5,'admin','0003_logentry_add_action_flag_choices','2024-10-24 04:51:59.049486'),
(6,'contenttypes','0002_remove_content_type_name','2024-10-24 04:51:59.097546'),
(7,'auth','0002_alter_permission_name_max_length','2024-10-24 04:51:59.135980'),
(8,'auth','0003_alter_user_email_max_length','2024-10-24 04:51:59.151778'),
(9,'auth','0004_alter_user_username_opts','2024-10-24 04:51:59.158744'),
(10,'auth','0005_alter_user_last_login_null','2024-10-24 04:51:59.195898'),
(11,'auth','0006_require_contenttypes_0002','2024-10-24 04:51:59.197387'),
(12,'auth','0007_alter_validators_add_error_messages','2024-10-24 04:51:59.204490'),
(13,'auth','0008_alter_user_username_max_length','2024-10-24 04:51:59.234343'),
(14,'auth','0009_alter_user_last_name_max_length','2024-10-24 04:51:59.272760'),
(15,'auth','0010_alter_group_name_max_length','2024-10-24 04:51:59.286207'),
(16,'auth','0011_update_proxy_permissions','2024-10-24 04:51:59.293350'),
(17,'auth','0012_alter_user_first_name_max_length','2024-10-24 04:51:59.337094'),
(18,'myapp','0001_initial','2024-10-24 04:51:59.932502'),
(19,'myapp','0002_auto_20241024_1021','2024-10-24 04:52:00.066825'),
(20,'sessions','0001_initial','2024-10-24 04:52:00.090847'),
(21,'myapp','0003_like_type','2024-10-24 04:55:32.894975');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('4a7hn9u381usqmeoxqdzyvin5f803j5s','.eJyrVsrJTFGyMtJRSkzOL80rUbIy01FKgjKBosn5uVCOgY5SQT5CTWlxahFIp5Kxko5SXmo5mFULANeTF_U:1t3r7T:wSNvkSLu6yjntTNw8lMUTRWsDoXu0zdNCglTinkU0Sc','2024-11-07 06:14:51.548660');

/*Table structure for table `myapp_chat` */

DROP TABLE IF EXISTS `myapp_chat`;

CREATE TABLE `myapp_chat` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `message` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `FROMID_id` bigint NOT NULL,
  `TOID_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_chat_FROMID_id_c34a39e8_fk_myapp_login_id` (`FROMID_id`),
  KEY `myapp_chat_TOID_id_c3a45261_fk_myapp_login_id` (`TOID_id`),
  CONSTRAINT `myapp_chat_FROMID_id_c34a39e8_fk_myapp_login_id` FOREIGN KEY (`FROMID_id`) REFERENCES `myapp_login` (`id`),
  CONSTRAINT `myapp_chat_TOID_id_c3a45261_fk_myapp_login_id` FOREIGN KEY (`TOID_id`) REFERENCES `myapp_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_chat` */

insert  into `myapp_chat`(`id`,`message`,`date`,`FROMID_id`,`TOID_id`) values 
(1,'hi','2024-10-24',3,3),
(2,'hlo','2024-10-24',2,3),
(3,'dd','2024-10-24',2,3),
(4,'ok','2024-10-24',3,2),
(5,'are','2024-10-24',2,3);

/*Table structure for table `myapp_comment` */

DROP TABLE IF EXISTS `myapp_comment`;

CREATE TABLE `myapp_comment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `comment` varchar(100) NOT NULL,
  `status` varchar(300) NOT NULL,
  `POST_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_comment_POST_id_19abca8e_fk_myapp_post_id` (`POST_id`),
  KEY `myapp_comment_USER_id_a1f116be_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_comment_POST_id_19abca8e_fk_myapp_post_id` FOREIGN KEY (`POST_id`) REFERENCES `myapp_post` (`id`),
  CONSTRAINT `myapp_comment_USER_id_a1f116be_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_comment` */

insert  into `myapp_comment`(`id`,`date`,`comment`,`status`,`POST_id`,`USER_id`) values 
(1,'2024-10-24','good','',1,1),
(2,'2024-10-24','fdsf','',1,1),
(3,'2024-10-24','sdsff','',1,1),
(4,'2024-10-24','dsfdsdf','',1,1);

/*Table structure for table `myapp_complaint` */

DROP TABLE IF EXISTS `myapp_complaint`;

CREATE TABLE `myapp_complaint` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `complaint` varchar(400) NOT NULL,
  `reply` varchar(300) NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_complaint_USER_id_21ed0b20_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_complaint_USER_id_21ed0b20_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_complaint` */

/*Table structure for table `myapp_disike` */

DROP TABLE IF EXISTS `myapp_disike`;

CREATE TABLE `myapp_disike` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `status` varchar(300) NOT NULL,
  `total` varchar(300) NOT NULL,
  `POST_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_disike_POST_id_95cfd37d_fk_myapp_post_id` (`POST_id`),
  KEY `myapp_disike_USER_id_82c487ed_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_disike_POST_id_95cfd37d_fk_myapp_post_id` FOREIGN KEY (`POST_id`) REFERENCES `myapp_post` (`id`),
  CONSTRAINT `myapp_disike_USER_id_82c487ed_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_disike` */

insert  into `myapp_disike`(`id`,`date`,`status`,`total`,`POST_id`,`USER_id`) values 
(28,'2024-10-24 05:34:07','disliked','',1,2);

/*Table structure for table `myapp_feedback` */

DROP TABLE IF EXISTS `myapp_feedback`;

CREATE TABLE `myapp_feedback` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `rating` varchar(400) NOT NULL,
  `feedback` varchar(300) NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_feedback_USER_id_fce7ccff_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_feedback_USER_id_fce7ccff_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_feedback` */

/*Table structure for table `myapp_follow_request` */

DROP TABLE IF EXISTS `myapp_follow_request`;

CREATE TABLE `myapp_follow_request` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `status` varchar(300) NOT NULL,
  `FROM_id` bigint NOT NULL,
  `TO_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_follow_request_FROM_id_6ff98ec0_fk_myapp_user_id` (`FROM_id`),
  KEY `myapp_follow_request_TO_id_ae54e3db_fk_myapp_user_id` (`TO_id`),
  CONSTRAINT `myapp_follow_request_FROM_id_6ff98ec0_fk_myapp_user_id` FOREIGN KEY (`FROM_id`) REFERENCES `myapp_user` (`id`),
  CONSTRAINT `myapp_follow_request_TO_id_ae54e3db_fk_myapp_user_id` FOREIGN KEY (`TO_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_follow_request` */

insert  into `myapp_follow_request`(`id`,`date`,`status`,`FROM_id`,`TO_id`) values 
(1,'2024-10-24','friend',1,2),
(2,'2024-10-24','friend',2,1);

/*Table structure for table `myapp_like` */

DROP TABLE IF EXISTS `myapp_like`;

CREATE TABLE `myapp_like` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `status` varchar(300) NOT NULL,
  `total` varchar(300) NOT NULL,
  `POST_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  `type` varchar(300) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_like_POST_id_35c47a4b_fk_myapp_post_id` (`POST_id`),
  KEY `myapp_like_USER_id_0ce4c07b_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_like_POST_id_35c47a4b_fk_myapp_post_id` FOREIGN KEY (`POST_id`) REFERENCES `myapp_post` (`id`),
  CONSTRAINT `myapp_like_USER_id_0ce4c07b_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_like` */

insert  into `myapp_like`(`id`,`date`,`status`,`total`,`POST_id`,`USER_id`,`type`) values 
(25,'2024-10-24 05:34:22','liked','',1,2,''),
(32,'2024-10-24 05:44:26','liked','',1,1,''),
(33,'2024-10-24 05:48:28','liked','',2,1,'');

/*Table structure for table `myapp_login` */

DROP TABLE IF EXISTS `myapp_login`;

CREATE TABLE `myapp_login` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_login` */

insert  into `myapp_login`(`id`,`username`,`password`,`type`) values 
(1,'admin@gmail.com','admin','admin'),
(2,'messi@gmail.com','12345678','user'),
(3,'user@gmail.com','12345678','user');

/*Table structure for table `myapp_post` */

DROP TABLE IF EXISTS `myapp_post`;

CREATE TABLE `myapp_post` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `file` varchar(100) NOT NULL,
  `title` varchar(300) NOT NULL,
  `USER_id` bigint NOT NULL,
  `type` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_post_USER_id_9c641699_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_post_USER_id_9c641699_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_post` */

insert  into `myapp_post`(`id`,`date`,`file`,`title`,`USER_id`,`type`) values 
(1,'2024-10-24 10:24:31.523871','/media/2024-10-24-10-24-31','wher am i',1,'image'),
(2,'2024-10-24 11:18:25.516186','/media/2024-10-24-11-18-25','where',1,'image'),
(3,'2024-10-24 11:18:47.195045','/media/2024-10-24-11-18-47','welcome',1,'image'),
(4,'2024-10-24 11:20:01.004062','/media/2024-10-24-11-20-01','shortterm',2,'image'),
(5,'2024-10-24 11:20:23.677792','/media/2024-10-24-11-20-23','life',2,'image'),
(6,'2024-10-24 11:20:44.413254','/media/2024-10-24-11-20-44','lakes',2,'image');

/*Table structure for table `myapp_report` */

DROP TABLE IF EXISTS `myapp_report`;

CREATE TABLE `myapp_report` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` varchar(100) NOT NULL,
  `status` varchar(300) NOT NULL,
  `COMMENT_id` bigint NOT NULL,
  `USER_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_report_COMMENT_id_39448100_fk_myapp_comment_id` (`COMMENT_id`),
  KEY `myapp_report_USER_id_549bae6e_fk_myapp_user_id` (`USER_id`),
  CONSTRAINT `myapp_report_COMMENT_id_39448100_fk_myapp_comment_id` FOREIGN KEY (`COMMENT_id`) REFERENCES `myapp_comment` (`id`),
  CONSTRAINT `myapp_report_USER_id_549bae6e_fk_myapp_user_id` FOREIGN KEY (`USER_id`) REFERENCES `myapp_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_report` */

insert  into `myapp_report`(`id`,`date`,`status`,`COMMENT_id`,`USER_id`) values 
(3,'2024-10-24','Reported',4,1),
(4,'2024-10-24','Reported',3,1),
(5,'2024-10-24','Reported',3,1),
(6,'2024-10-24','Reported',2,1),
(7,'2024-10-24','Reported',1,1),
(8,'2024-10-24','Reported',4,1);

/*Table structure for table `myapp_user` */

DROP TABLE IF EXISTS `myapp_user`;

CREATE TABLE `myapp_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `place` varchar(100) NOT NULL,
  `posts` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `photo` varchar(400) NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `myapp_user_LOGIN_id_da832ded_fk_myapp_login_id` (`LOGIN_id`),
  CONSTRAINT `myapp_user_LOGIN_id_da832ded_fk_myapp_login_id` FOREIGN KEY (`LOGIN_id`) REFERENCES `myapp_login` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `myapp_user` */

insert  into `myapp_user`(`id`,`name`,`place`,`posts`,`email`,`phone`,`photo`,`LOGIN_id`) values 
(1,'messi','argentina','miami','messi@gmail.com','9874561230','/media/2024-10-24-10-23-24.jpg',2),
(2,'user','clt','kozhikode','user@gmail.com','933208215','/media/2024-10-24-10-24-04.jpg',3);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
