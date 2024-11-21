/*
 Navicat Premium Data Transfer

 Source Server         : WanderWiser
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : wanderwiser

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 22/11/2024 00:18:59
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of recommendation
-- ----------------------------

-- ----------------------------
-- Table structure for tripmanage
-- ----------------------------
DROP TABLE IF EXISTS `tripmanage`;
CREATE TABLE `tripmanage`  (
  `place_id` int NOT NULL,
  `user_id` int NOT NULL,
  `place_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_lct` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `plan_plan` json NULL,
  `place_food` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `place_rest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `place_trfc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`place_id`, `user_id`) USING BTREE,
  INDEX `trip_user`(`user_id` ASC) USING BTREE
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
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registration_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_login_time` datetime NULL DEFAULT NULL,
  `personal_profile` json NULL,
  `account_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of useraccount
-- ----------------------------
INSERT INTO `useraccount` VALUES ('1234', 'gin', '1234', '2024-11-22 00:17:22', '2024-11-21 21:59:07', NULL, '0');
INSERT INTO `useraccount` VALUES ('308777f0-7a9c-449b-b59e-f5d25a0ff81c', '233', '233', NULL, NULL, NULL, '0');
INSERT INTO `useraccount` VALUES ('b2761612-07eb-4c0e-b9bc-04087ae4f17c', '233', '233', NULL, NULL, NULL, '0');

-- ----------------------------
-- Table structure for usermemory
-- ----------------------------
DROP TABLE IF EXISTS `usermemory`;
CREATE TABLE `usermemory`  (
  `memory_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NULL DEFAULT NULL,
  `interaction_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `interaction_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `agent_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `context_info` json NULL,
  `preference_record` json NULL,
  PRIMARY KEY (`memory_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of usermemory
-- ----------------------------

-- ----------------------------
-- Table structure for userportrait
-- ----------------------------
DROP TABLE IF EXISTS `userportrait`;
CREATE TABLE `userportrait`  (
  `user_id` int NOT NULL,
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
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of userportrait
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
