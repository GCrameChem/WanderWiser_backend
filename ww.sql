/*
 Navicat Premium Data Transfer

 Source Server         : TestOne
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : yk

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 13/12/2024 15:51:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `act_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动id',
  `actname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `day` int NOT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `display_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '宣传图',
  `booking_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '预定方式',
  `transport` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交通方式',
  `activity_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `recommended_dishes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`act_id`, `day`) USING BTREE,
  INDEX `day_act`(`day` ASC) USING BTREE,
  CONSTRAINT `day_act` FOREIGN KEY (`day`) REFERENCES `dailytrip` (`day`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of activity
-- ----------------------------

-- ----------------------------
-- Table structure for dailytrip
-- ----------------------------
DROP TABLE IF EXISTS `dailytrip`;
CREATE TABLE `dailytrip`  (
  `plan_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '方案编号',
  `day` int NOT NULL COMMENT '日程编号',
  `location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `date` date NULL DEFAULT NULL,
  `weather` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `abstract` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `accomodation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `carry_items` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`plan_id`, `day`) USING BTREE,
  INDEX `plan_day`(`plan_id` ASC) USING BTREE,
  INDEX `day`(`day` ASC) USING BTREE,
  CONSTRAINT `plan_day` FOREIGN KEY (`plan_id`) REFERENCES `tripmanage` (`plan_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of dailytrip
-- ----------------------------

-- ----------------------------
-- Table structure for recommendation
-- ----------------------------
DROP TABLE IF EXISTS `recommendation`;
CREATE TABLE `recommendation`  (
  `recommendation_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `recommendation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `creation_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `feedback_status` enum('accept','reject','ignore') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rating` int NULL DEFAULT NULL COMMENT '值范围：1-5',
  PRIMARY KEY (`recommendation_id`) USING BTREE,
  INDEX `rec_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recommendation
-- ----------------------------

-- ----------------------------
-- Table structure for tripmanage
-- ----------------------------
DROP TABLE IF EXISTS `tripmanage`;
CREATE TABLE `tripmanage`  (
  `plan_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '方案id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `plan_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `days` tinyint NULL DEFAULT NULL,
  PRIMARY KEY (`plan_id`, `user_id`) USING BTREE,
  INDEX `plan_id`(`plan_id` ASC) USING BTREE,
  INDEX `user_trip`(`user_id` ASC) USING BTREE,
  CONSTRAINT `userid1` FOREIGN KEY (`user_id`) REFERENCES `userdata` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of tripmanage
-- ----------------------------

-- ----------------------------
-- Table structure for useraccount
-- ----------------------------
DROP TABLE IF EXISTS `useraccount`;
CREATE TABLE `useraccount`  (
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registration_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_login_time` datetime NULL DEFAULT NULL,
  `user_gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_age` int NULL DEFAULT NULL,
  `personal_profile` json NULL,
  `account_status` enum('activated','disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of useraccount
-- ----------------------------
INSERT INTO `useraccount` VALUES ('25ed8fe4-862a-4fd5-a02e-00fd5cb8d7bb', 'gin', '1234', '2024-12-11 00:15:42', '2024-12-11 00:15:42', 'male', NULL, NULL, 'activated');
INSERT INTO `useraccount` VALUES ('464405e1-31cf-42dd-b907-4d4b7e24edb4', 'gin', '1234', '2024-12-11 00:28:38', '2024-12-11 00:28:38', 'male', NULL, NULL, 'activated');
INSERT INTO `useraccount` VALUES ('4da1cbb7-f966-4a6b-82b0-f2845d13b6ba', 'gin', '1234', '2024-12-11 00:14:15', '2024-12-11 00:14:15', 'male', NULL, NULL, 'activated');
INSERT INTO `useraccount` VALUES ('6389c2e4-414f-43f8-a52e-28968c63ce13', 'gin', '1234', '2024-12-11 00:26:46', '2024-12-11 00:26:46', 'male', NULL, NULL, 'activated');
INSERT INTO `useraccount` VALUES ('762592ae-5f37-4bf8-ac0c-c17a88fcf3d6', 'gin', '1234', '2024-12-10 23:14:50', '2024-12-10 23:14:50', 'male', NULL, NULL, 'activated');
INSERT INTO `useraccount` VALUES ('8515a66b-80f1-4785-8f92-9c054242493d', 'gin', '1234', '2024-12-11 00:16:43', '2024-12-11 00:16:43', 'male', NULL, NULL, 'activated');
INSERT INTO `useraccount` VALUES ('9a79dec0-d960-4d51-b232-0594bb513d0d', 'gin', '1234', '2024-12-11 00:22:27', '2024-12-11 00:22:27', 'male', NULL, NULL, 'activated');

-- ----------------------------
-- Table structure for userdata
-- ----------------------------
DROP TABLE IF EXISTS `userdata`;
CREATE TABLE `userdata`  (
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '唯一区别不同用户的方式',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名(注册与登录时使用',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称(用户界面可显示',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `gender` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '性别\n(仅限男/女',
  `age` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '年龄',
  `school` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '学校',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人描述',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userdata
-- ----------------------------
INSERT INTO `userdata` VALUES ('43acd90c-05d6-4c1f-8acf-897179a1d956', 'gin', NULL, '1234', 'G', '未知', '999', 'SCU', '默认简介');
INSERT INTO `userdata` VALUES ('47d1be6c-b00d-4eee-9043-36fdf2a36c5d', 'gin', 'wangyuhan030913@163.com', '123456', '默认昵称', '未知', '未知', '未知', '默认简介');
INSERT INTO `userdata` VALUES ('7038d900-8773-4312-a8b4-1ff906d6783d', 'gin', NULL, '1234', '默认昵称', '未知', '未知', '未知', '默认简介');
INSERT INTO `userdata` VALUES ('8b350830-4a84-43f5-8797-cc75b65566c9', 'tqq', '2058406739@qq.com', '1207', '默认昵称', '未知', '未知', '未知', '默认简介');
INSERT INTO `userdata` VALUES ('984731e8-b6ad-4b7f-bb56-fa76681dfb01', 'wang', '1802231683@qq.com', '12345', '小涵', '女', '20', '四川大学', '默认简介');
INSERT INTO `userdata` VALUES ('a2e1ca9e-c3a7-422a-b00b-e89ef30e713e', 'y', NULL, 't', '123', '女', '18', '四川大学', 'lalala');

-- ----------------------------
-- Table structure for usermemory
-- ----------------------------
DROP TABLE IF EXISTS `usermemory`;
CREATE TABLE `usermemory`  (
  `memory_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `interaction_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `interaction_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `agent_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `context_info` json NULL,
  `preference_record` json NULL,
  PRIMARY KEY (`memory_id`) USING BTREE,
  UNIQUE INDEX `memory_id_UNIQUE`(`memory_id` ASC) USING BTREE,
  UNIQUE INDEX `user_id_UNIQUE`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of usermemory
-- ----------------------------

-- ----------------------------
-- Table structure for userportrait
-- ----------------------------
DROP TABLE IF EXISTS `userportrait`;
CREATE TABLE `userportrait`  (
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_age` int NULL DEFAULT NULL,
  `birth_day` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `travel_history` json NULL,
  `preferred_travel_season` enum('spring','summer','autumn','winter') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `interests` json NULL,
  `place_residence` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `occupation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `education_level` enum('Elementary school and below','junior high school','high school','college','undergraduate','master''s degree and above') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `budget` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `income_level` enum('low','medium','high') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `consumption_level` enum('low','medium','high') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `relationship` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '社交关系数据（喜欢一个人或与朋友一起出行等）',
  `other_profile` json NULL,
  `click_rate` float NULL DEFAULT NULL COMMENT '用户一个月内的点击率，可针对特定的旅游推荐内容计算',
  `conversion_rate` float NULL DEFAULT NULL COMMENT '用户一个月内的转化率，如从查看推荐到实际预订旅游行程的转化比例',
  `recent_behavior_count` int NULL DEFAULT 0 COMMENT '用户周内特定行为（如搜索旅游目的地、查看旅游攻略等）的次数',
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `user_por` FOREIGN KEY (`user_id`) REFERENCES `userdata` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userportrait
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
