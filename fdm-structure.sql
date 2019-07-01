/*
 Navicat MySQL Data Transfer

 Source Server         : local
 Source Server Type    : MySQL
 Source Server Version : 80016
 Source Host           : localhost:3306
 Source Schema         : fdm

 Target Server Type    : MySQL
 Target Server Version : 80016
 File Encoding         : 65001

 Date: 23/06/2019 10:36:03
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for AspNetRoles
-- ----------------------------
DROP TABLE IF EXISTS `AspNetRoles`;
CREATE TABLE `AspNetRoles` (
  `Id` varchar(128) NOT NULL,
  `Name` varchar(256) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for AspNetUserClaims
-- ----------------------------
DROP TABLE IF EXISTS `AspNetUserClaims`;
CREATE TABLE `AspNetUserClaims` (
  `Id` int(11) NOT NULL,
  `UserId` varchar(128) NOT NULL,
  `ClaimType` longtext,
  `ClaimValue` longtext,
  PRIMARY KEY (`Id`),
  KEY `IX_UserId` (`UserId`),
  CONSTRAINT `FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for AspNetUserLogins
-- ----------------------------
DROP TABLE IF EXISTS `AspNetUserLogins`;
CREATE TABLE `AspNetUserLogins` (
  `LoginProvider` varchar(128) NOT NULL,
  `ProviderKey` varchar(128) NOT NULL,
  `UserId` varchar(128) NOT NULL,
  PRIMARY KEY (`LoginProvider`,`ProviderKey`,`UserId`),
  KEY `IX_UserId` (`UserId`),
  CONSTRAINT `FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for AspNetUserRoles
-- ----------------------------
DROP TABLE IF EXISTS `AspNetUserRoles`;
CREATE TABLE `AspNetUserRoles` (
  `UserId` varchar(128) NOT NULL,
  `RoleId` varchar(128) NOT NULL,
  PRIMARY KEY (`UserId`,`RoleId`),
  KEY `IX_RoleId` (`RoleId`),
  KEY `IX_UserId` (`UserId`),
  CONSTRAINT `FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `aspnetroles` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId` FOREIGN KEY (`UserId`) REFERENCES `aspnetusers` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for AspNetUsers
-- ----------------------------
DROP TABLE IF EXISTS `AspNetUsers`;
CREATE TABLE `AspNetUsers` (
  `Id` varchar(128) NOT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `EmailConfirmed` int(1) NOT NULL,
  `PasswordHash` varchar(512) DEFAULT NULL,
  `SecurityStamp` varchar(512) DEFAULT NULL,
  `PhoneNumber` varchar(128) DEFAULT NULL,
  `PhoneNumberConfirmed` int(1) NOT NULL,
  `TwoFactorEnabled` int(1) NOT NULL,
  `LockoutEndDateUtc` datetime DEFAULT NULL,
  `LockoutEnabled` int(1) NOT NULL,
  `AccessFailedCount` int(11) NOT NULL,
  `UserName` varchar(256) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for rb_cundang_department
-- ----------------------------
DROP TABLE IF EXISTS `rb_cundang_department`;
CREATE TABLE `rb_cundang_department` (
  `id` int(11) NOT NULL,
  `cundang_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for rb_job_user
-- ----------------------------
DROP TABLE IF EXISTS `rb_job_user`;
CREATE TABLE `rb_job_user` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rb_job_user_tb_person_info` (`user_id`),
  KEY `FK_rb_job_user_tb_job_info` (`job_id`),
  CONSTRAINT `FK_rb_job_user_tb_job_info` FOREIGN KEY (`job_id`) REFERENCES `tb_job_info` (`id`),
  CONSTRAINT `FK_rb_job_user_tb_person_info` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for rb_step_department
-- ----------------------------
DROP TABLE IF EXISTS `rb_step_department`;
CREATE TABLE `rb_step_department` (
  `id` int(11) NOT NULL,
  `step_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rb_step_department_tb_department_info` (`department_id`),
  KEY `FK_rb_step_department_tb_step_info` (`step_id`),
  CONSTRAINT `FK_rb_step_department_tb_department_info` FOREIGN KEY (`department_id`) REFERENCES `tb_department_info` (`id`),
  CONSTRAINT `FK_rb_step_department_tb_step_info` FOREIGN KEY (`step_id`) REFERENCES `tb_step_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for rb_step_job
-- ----------------------------
DROP TABLE IF EXISTS `rb_step_job`;
CREATE TABLE `rb_step_job` (
  `id` int(11) NOT NULL,
  `step_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `specification` varchar(255) DEFAULT NULL,
  `pdf_link` varchar(255) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_rb_step_job_tb_job_info` (`job_id`),
  KEY `FK_rb_step_job_tb_step_info` (`step_id`),
  CONSTRAINT `FK_rb_step_job_tb_job_info` FOREIGN KEY (`job_id`) REFERENCES `tb_job_info` (`id`),
  CONSTRAINT `FK_rb_step_job_tb_step_info` FOREIGN KEY (`step_id`) REFERENCES `tb_step_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_department_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_department_info`;
CREATE TABLE `tb_department_info` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(60) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_form_attachment
-- ----------------------------
DROP TABLE IF EXISTS `tb_form_attachment`;
CREATE TABLE `tb_form_attachment` (
  `id` int(11) NOT NULL,
  `procedure_id` int(11) NOT NULL,
  `code` varchar(60) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `thumbnail_link` varchar(255) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tb_form_attachment_tb_procedure_info` (`procedure_id`),
  CONSTRAINT `FK_tb_form_attachment_tb_procedure_info` FOREIGN KEY (`procedure_id`) REFERENCES `tb_procedure_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_form_cundang
-- ----------------------------
DROP TABLE IF EXISTS `tb_form_cundang`;
CREATE TABLE `tb_form_cundang` (
  `id` int(11) NOT NULL,
  `procedure_id` int(11) NOT NULL,
  `code` varchar(60) NOT NULL,
  `name` longtext NOT NULL,
  `link` varchar(255) DEFAULT NULL,
  `thumbnail_link` varchar(255) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `version` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_job_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_job_info`;
CREATE TABLE `tb_job_info` (
  `id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `code` varchar(60) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tb_job_info_tb_department_info` (`department_id`),
  CONSTRAINT `FK_tb_job_info_tb_department_info` FOREIGN KEY (`department_id`) REFERENCES `tb_department_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_local_auth
-- ----------------------------
DROP TABLE IF EXISTS `tb_local_auth`;
CREATE TABLE `tb_local_auth` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `username` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tb_local_auth_tb_person_info` (`user_id`),
  CONSTRAINT `FK_tb_local_auth_tb_person_info` FOREIGN KEY (`user_id`) REFERENCES `tb_person_info` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_manual_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_manual_info`;
CREATE TABLE `tb_manual_info` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(60) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  `pdf_link` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_person_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_person_info`;
CREATE TABLE `tb_person_info` (
  `user_id` int(11) NOT NULL,
  `gender` varchar(2) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phonenumber` varchar(20) DEFAULT NULL,
  `profile_img` text,
  `status` int(11) DEFAULT NULL,
  `user_type` int(11) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  `post_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `FK_tb_person_info_tb_department_info` (`department_id`),
  KEY `FK_tb_person_info_tb_post_info` (`post_id`),
  CONSTRAINT `FK_tb_person_info_tb_department_info` FOREIGN KEY (`department_id`) REFERENCES `tb_department_info` (`id`),
  CONSTRAINT `FK_tb_person_info_tb_post_info` FOREIGN KEY (`post_id`) REFERENCES `tb_post_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_post_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_post_info`;
CREATE TABLE `tb_post_info` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(60) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_tb_post_info_tb_department_info` (`department_id`),
  CONSTRAINT `FK_tb_post_info_tb_department_info` FOREIGN KEY (`department_id`) REFERENCES `tb_department_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_procedure_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_procedure_info`;
CREATE TABLE `tb_procedure_info` (
  `id` int(11) NOT NULL,
  `code` varchar(60) NOT NULL,
  `name` varchar(255) NOT NULL,
  `time_created` datetime NOT NULL,
  `time_updated` datetime NOT NULL,
  `status` int(11) NOT NULL,
  `version` varchar(20) DEFAULT NULL,
  `shiyongfanwei` varchar(255) DEFAULT NULL,
  `liuchengtu` varchar(255) DEFAULT NULL,
  `pdf_link` varchar(255) DEFAULT NULL,
  `manual_id` int(11) NOT NULL,
  `by1` varchar(255) DEFAULT NULL,
  `by2` varchar(255) DEFAULT NULL,
  `by3` varchar(255) DEFAULT NULL,
  `by4` varchar(255) DEFAULT NULL,
  `by5` varchar(255) DEFAULT NULL,
  `bytext` longtext,
  `bylongtext` longtext,
  `department_id` int(11) DEFAULT NULL,
  `mingcishuyu` text,
  `yiju` text,
  `mudi` text,
  PRIMARY KEY (`id`),
  KEY `FK_tb_procedure_info_tb_department_info` (`department_id`),
  KEY `FK_tb_procedure_info_tb_manual_info` (`manual_id`),
  CONSTRAINT `FK_tb_procedure_info_tb_department_info` FOREIGN KEY (`department_id`) REFERENCES `tb_department_info` (`id`),
  CONSTRAINT `FK_tb_procedure_info_tb_manual_info` FOREIGN KEY (`manual_id`) REFERENCES `tb_manual_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Table structure for tb_step_info
-- ----------------------------
DROP TABLE IF EXISTS `tb_step_info`;
CREATE TABLE `tb_step_info` (
  `id` int(11) NOT NULL,
  `procedure_id` int(11) NOT NULL,
  `code` varchar(60) NOT NULL,
  `description` longtext NOT NULL,
  `department_id` int(11) DEFAULT NULL,
  `time_created` datetime DEFAULT NULL,
  `time_updated` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `version` varchar(20) DEFAULT NULL,
  `by1` varchar(255) DEFAULT NULL,
  `by2` varchar(255) DEFAULT NULL,
  `by3` varchar(255) DEFAULT NULL,
  `by4` varchar(255) DEFAULT NULL,
  `by5` varchar(255) DEFAULT NULL,
  `bytext` longtext,
  `bylongtext` longtext,
  PRIMARY KEY (`id`),
  KEY `FK_tb_step_info_tb_procedure_info` (`procedure_id`),
  CONSTRAINT `FK_tb_step_info_tb_procedure_info` FOREIGN KEY (`procedure_id`) REFERENCES `tb_procedure_info` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SET FOREIGN_KEY_CHECKS = 1;
