/*
 Navicat Premium Dump SQL

 Source Server         : demo
 Source Server Type    : MySQL
 Source Server Version : 80039 (8.0.39)
 Source Host           : localhost:3306
 Source Schema         : ww

 Target Server Type    : MySQL
 Target Server Version : 80039 (8.0.39)
 File Encoding         : 65001

 Date: 26/11/2024 10:39:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `act_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动id',
  `day` int NOT NULL,
  `start_time` datetime NULL DEFAULT NULL,
  `end_time` datetime NULL DEFAULT NULL,
  `display_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '宣传图',
  `booking_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '预定方式',
  `transport` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '交通方式',
  PRIMARY KEY (`act_id`, `day`) USING BTREE,
  INDEX `day_act`(`day` ASC) USING BTREE,
  CONSTRAINT `day_act` FOREIGN KEY (`day`) REFERENCES `dailytrip` (`day`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
  `overview` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容总览',
  PRIMARY KEY (`plan_id` DESC, `day`) USING BTREE,
  INDEX `plan_day`(`plan_id` ASC) USING BTREE,
  INDEX `day`(`day` ASC) USING BTREE,
  CONSTRAINT `plan_day` FOREIGN KEY (`plan_id`) REFERENCES `tripmanage` (`plan_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dailytrip
-- ----------------------------

-- ----------------------------
-- Table structure for recommendation
-- ----------------------------
DROP TABLE IF EXISTS `recommendation`;
CREATE TABLE `recommendation`  (
  `recommendation_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `recommendation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `creation_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `feedback_status` enum('accept','reject','ignore') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `rating` int NULL DEFAULT NULL COMMENT '值范围：1-5',
  PRIMARY KEY (`recommendation_id`) USING BTREE,
  INDEX `rec_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
  `date` date NULL DEFAULT NULL COMMENT '用于显示的日期',
  `weather` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `accomodation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '住宿点',
  PRIMARY KEY (`plan_id`, `user_id`) USING BTREE,
  INDEX `plan_id`(`plan_id` ASC) USING BTREE,
  INDEX `user_trip`(`user_id` ASC) USING BTREE,
  CONSTRAINT `user_trip` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of useraccount
-- ----------------------------

-- ----------------------------
-- Table structure for usermemory
-- ----------------------------
DROP TABLE IF EXISTS `usermemory`;
CREATE TABLE `usermemory`  (
  `memory_id` int NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `interaction_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `interaction_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `agent_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `context_info` json NULL,
  `preference_record` json NULL,
  PRIMARY KEY (`memory_id`) USING BTREE,
  UNIQUE INDEX `memory_id_UNIQUE`(`memory_id` ASC) USING BTREE,
  UNIQUE INDEX `user_id_UNIQUE`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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
  CONSTRAINT `user_por` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of userportrait
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
