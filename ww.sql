-- MySQL dump 10.13  Distrib 8.0.39, for Win64 (x86_64)
--
-- Host: localhost    Database: wanderwiser
-- ------------------------------------------------------
-- Server version	8.0.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `activity`
--

DROP TABLE IF EXISTS `activity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `activity` (
  `act_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '活动id',
  `actname` varchar(255) DEFAULT NULL,
  `day` int NOT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `display_image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '宣传图',
  `booking_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '预定方式',
  `transport` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '交通方式',
  `activity_content` text,
  `address` varchar(255) DEFAULT NULL,
  `recommended_dishes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`act_id`,`day`) USING BTREE,
  KEY `day_act` (`day`) USING BTREE,
  CONSTRAINT `day_act` FOREIGN KEY (`day`) REFERENCES `dailytrip` (`day`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `activity`
--

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;
INSERT INTO `activity` VALUES ('010d1c27-8bb9-4268-8154-13a50c268638','四川博物馆',1,'2025-12-03 09:26:34','2025-07-25 13:23:04','![四川博物馆](https://example.com/scmuseum.jpg)','[点击预约门票](https://example.com/book-scmuseum)','从酒店出发，地铁2号线到浣花溪站（约20分钟）。','参观博物馆展厅，了解巴蜀文化与历史文物。','成都市青羊区浣花南路251号','青柠和茄子挞'),('5cf14e8a-80b8-4132-ad83-4b7de6cc6656','四川博物馆',1,'2025-12-03 09:26:34','2025-07-25 13:23:04','![四川博物馆](https://example.com/scmuseum.jpg)','[点击预约门票](https://example.com/book-scmuseum)','从酒店出发，地铁2号线到浣花溪站（约20分钟）。','参观博物馆展厅，了解巴蜀文化与历史文物。','成都市青羊区浣花南路251号','青柠和茄子挞'),('8122aa6d-8a86-4fdb-a932-09caa7cb5bd3','四川博物馆',1,'2025-12-03 09:26:34','2025-07-25 13:23:04','![四川博物馆](https://example.com/scmuseum.jpg)','[点击预约门票](https://example.com/book-scmuseum)','从酒店出发，地铁2号线到浣花溪站（约20分钟）。','参观博物馆展厅，了解巴蜀文化与历史文物。','成都市青羊区浣花南路251号','青柠和茄子挞'),('d21b782d-e85b-48c6-a88e-2355df960e4e','四川博物馆',1,'2025-12-03 09:26:34','2025-07-25 13:23:04','![四川博物馆](https://example.com/scmuseum.jpg)','[点击预约门票](https://example.com/book-scmuseum)','从酒店出发，地铁2号线到浣花溪站（约20分钟）。','参观博物馆展厅，了解巴蜀文化与历史文物。','成都市青羊区浣花南路251号','青柠和茄子挞'),('e7b6ecc6-5bca-4622-aa5e-97d11c2dfbb4','四川博物馆',1,'2025-12-03 09:26:34','2025-07-25 13:23:04','![四川博物馆](https://example.com/scmuseum.jpg)','[点击预约门票](https://example.com/book-scmuseum)','从酒店出发，地铁2号线到浣花溪站（约20分钟）。','参观博物馆展厅，了解巴蜀文化与历史文物。','成都市青羊区浣花南路251号','青柠和茄子挞'),('e835d49d-faf6-4883-a9b4-9e0dc96e41b3','四川博物馆',1,'2025-12-03 09:26:34','2025-07-25 13:23:04','![四川博物馆](https://example.com/scmuseum.jpg)','[点击预约门票](https://example.com/book-scmuseum)','从酒店出发，地铁2号线到浣花溪站（约20分钟）。','参观博物馆展厅，了解巴蜀文化与历史文物。','成都市青羊区浣花南路251号','青柠和茄子挞');
/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dailytrip`
--

DROP TABLE IF EXISTS `dailytrip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dailytrip` (
  `plan_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '方案编号',
  `day` int NOT NULL COMMENT '日程编号',
  `location` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `weather` varchar(255) DEFAULT NULL,
  `keywords` text,
  `abstract` text,
  `accomodation` varchar(255) DEFAULT NULL,
  `summary` text,
  `carry_items` text,
  PRIMARY KEY (`plan_id` DESC,`day`) USING BTREE,
  KEY `plan_day` (`plan_id`) USING BTREE,
  KEY `day` (`day`) USING BTREE,
  CONSTRAINT `plan_day` FOREIGN KEY (`plan_id`) REFERENCES `tripmanage` (`plan_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dailytrip`
--

LOCK TABLES `dailytrip` WRITE;
/*!40000 ALTER TABLE `dailytrip` DISABLE KEYS */;
INSERT INTO `dailytrip` VALUES ('dfc279c3-8b57-4f3b-98b5-bd151e4df10d',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）'),('d4f60a16-2bcf-4aae-8a70-ccfd62f813c2',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）'),('d37e1cf5-a8af-4ccf-a1de-be933db2e2d4',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）'),('befd31a5-f0ef-4c13-acd2-724b02cd9d40',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）'),('564171bf-1132-431c-ad10-238458a2972c',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）'),('3f2bb73c-50b0-47b3-a92f-4401f730d069',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）'),('117276b8-21d8-44ee-82fc-24aa0ae7396b',1,'四川博物馆','2024-08-05','晴','历史与文化','参观四川博物馆，感受四川深厚的历史文化底蕴。','成都市中心某酒店','今天参观了四川博物馆，了解了四川的历史文化，同时游览了天府广场。充实的一天结束啦！','雨伞（防晒或下雨用）,舒适的运动鞋,笔记本（用于记录见闻）');
/*!40000 ALTER TABLE `dailytrip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recommendation`
--

DROP TABLE IF EXISTS `recommendation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recommendation` (
  `recommendation_id` varchar(255) NOT NULL,
  `user_id` varchar(255) DEFAULT NULL,
  `recommendation_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `creation_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `feedback_status` enum('accept','reject','ignore') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `rating` int DEFAULT NULL COMMENT '值范围：1-5',
  PRIMARY KEY (`recommendation_id`) USING BTREE,
  KEY `rec_user` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recommendation`
--

LOCK TABLES `recommendation` WRITE;
/*!40000 ALTER TABLE `recommendation` DISABLE KEYS */;
/*!40000 ALTER TABLE `recommendation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tripmanage`
--

DROP TABLE IF EXISTS `tripmanage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tripmanage` (
  `plan_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '方案id',
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `plan_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `days` tinyint DEFAULT NULL,
  PRIMARY KEY (`plan_id`,`user_id`) USING BTREE,
  KEY `plan_id` (`plan_id`) USING BTREE,
  KEY `user_trip` (`user_id`) USING BTREE,
  CONSTRAINT `user_trip` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tripmanage`
--

LOCK TABLES `tripmanage` WRITE;
/*!40000 ALTER TABLE `tripmanage` DISABLE KEYS */;
INSERT INTO `tripmanage` VALUES ('117276b8-21d8-44ee-82fc-24aa0ae7396b','4da1cbb7-f966-4a6b-82b0-f2845d13b6ba','四川之旅：大熊猫的家园与自然奇观之旅',4),('3f2bb73c-50b0-47b3-a92f-4401f730d069','9a79dec0-d960-4d51-b232-0594bb513d0d','四川之旅：大熊猫的家园与自然奇观之旅',4),('564171bf-1132-431c-ad10-238458a2972c','25ed8fe4-862a-4fd5-a02e-00fd5cb8d7bb','四川之旅：大熊猫的家园与自然奇观之旅',4),('befd31a5-f0ef-4c13-acd2-724b02cd9d40','762592ae-5f37-4bf8-ac0c-c17a88fcf3d6','四川之旅：大熊猫的家园与自然奇观之旅',4),('d37e1cf5-a8af-4ccf-a1de-be933db2e2d4','6389c2e4-414f-43f8-a52e-28968c63ce13','四川之旅：大熊猫的家园与自然奇观之旅',4),('d4f60a16-2bcf-4aae-8a70-ccfd62f813c2','8515a66b-80f1-4785-8f92-9c054242493d','四川之旅：大熊猫的家园与自然奇观之旅',4),('dfc279c3-8b57-4f3b-98b5-bd151e4df10d','464405e1-31cf-42dd-b907-4d4b7e24edb4','四川之旅：大熊猫的家园与自然奇观之旅',4);
/*!40000 ALTER TABLE `tripmanage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `useraccount`
--

DROP TABLE IF EXISTS `useraccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `useraccount` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `registration_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `last_login_time` datetime DEFAULT NULL,
  `user_gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_age` int DEFAULT NULL,
  `personal_profile` json DEFAULT NULL,
  `account_status` enum('activated','disabled') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `useraccount`
--

LOCK TABLES `useraccount` WRITE;
/*!40000 ALTER TABLE `useraccount` DISABLE KEYS */;
INSERT INTO `useraccount` VALUES ('25ed8fe4-862a-4fd5-a02e-00fd5cb8d7bb','gin','1234','2024-12-11 00:15:42','2024-12-11 00:15:42','male',NULL,NULL,'activated'),('464405e1-31cf-42dd-b907-4d4b7e24edb4','gin','1234','2024-12-11 00:28:38','2024-12-11 00:28:38','male',NULL,NULL,'activated'),('4da1cbb7-f966-4a6b-82b0-f2845d13b6ba','gin','1234','2024-12-11 00:14:15','2024-12-11 00:14:15','male',NULL,NULL,'activated'),('6389c2e4-414f-43f8-a52e-28968c63ce13','gin','1234','2024-12-11 00:26:46','2024-12-11 00:26:46','male',NULL,NULL,'activated'),('762592ae-5f37-4bf8-ac0c-c17a88fcf3d6','gin','1234','2024-12-10 23:14:50','2024-12-10 23:14:50','male',NULL,NULL,'activated'),('8515a66b-80f1-4785-8f92-9c054242493d','gin','1234','2024-12-11 00:16:43','2024-12-11 00:16:43','male',NULL,NULL,'activated'),('9a79dec0-d960-4d51-b232-0594bb513d0d','gin','1234','2024-12-11 00:22:27','2024-12-11 00:22:27','male',NULL,NULL,'activated');
/*!40000 ALTER TABLE `useraccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usermemory`
--

DROP TABLE IF EXISTS `usermemory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usermemory` (
  `memory_id` varchar(255) NOT NULL,
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `interaction_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `interaction_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `agent_response` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `context_info` json DEFAULT NULL,
  `preference_record` json DEFAULT NULL,
  PRIMARY KEY (`memory_id`) USING BTREE,
  UNIQUE KEY `memory_id_UNIQUE` (`memory_id`) USING BTREE,
  UNIQUE KEY `user_id_UNIQUE` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usermemory`
--

LOCK TABLES `usermemory` WRITE;
/*!40000 ALTER TABLE `usermemory` DISABLE KEYS */;
/*!40000 ALTER TABLE `usermemory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userportrait`
--

DROP TABLE IF EXISTS `userportrait`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userportrait` (
  `user_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_gender` enum('male','female') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `user_age` int DEFAULT NULL,
  `birth_day` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `travel_history` json DEFAULT NULL,
  `preferred_travel_season` enum('spring','summer','autumn','winter') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `interests` json DEFAULT NULL,
  `place_residence` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `occupation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `education_level` enum('Elementary school and below','junior high school','high school','college','undergraduate','master''s degree and above') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `budget` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `income_level` enum('low','medium','high') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `consumption_level` enum('low','medium','high') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `relationship` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '社交关系数据（喜欢一个人或与朋友一起出行等）',
  `other_profile` json DEFAULT NULL,
  `click_rate` float DEFAULT NULL COMMENT '用户一个月内的点击率，可针对特定的旅游推荐内容计算',
  `conversion_rate` float DEFAULT NULL COMMENT '用户一个月内的转化率，如从查看推荐到实际预订旅游行程的转化比例',
  `recent_behavior_count` int DEFAULT '0' COMMENT '用户周内特定行为（如搜索旅游目的地、查看旅游攻略等）的次数',
  PRIMARY KEY (`user_id`) USING BTREE,
  CONSTRAINT `user_por` FOREIGN KEY (`user_id`) REFERENCES `useraccount` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userportrait`
--

LOCK TABLES `userportrait` WRITE;
/*!40000 ALTER TABLE `userportrait` DISABLE KEYS */;
/*!40000 ALTER TABLE `userportrait` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-11  0:45:46
