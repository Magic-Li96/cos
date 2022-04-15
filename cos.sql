/*
Navicat MySQL Data Transfer

Source Server         : MySQL
Source Server Version : 50505
Source Host           : 127.0.0.1:3306
Source Database       : cos

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2022-03-30 21:18:56
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `p_id` int(20) NOT NULL,
  `course` int(20) NOT NULL,
  `department` int(10) NOT NULL,
  `subject` int(20) NOT NULL,
  `article_name` varchar(255) NOT NULL,
  `article_src` varchar(255) DEFAULT NULL,
  `contidion` int(1) NOT NULL,
  `start_institute` int(20) NOT NULL,
  `institute` int(10) NOT NULL,
  `teacher` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`p_id`,`course`,`department`,`subject`),
  KEY `ins` (`institute`),
  KEY `teacher` (`teacher`),
  KEY `dep` (`department`),
  KEY `contidion` (`contidion`),
  KEY `subject` (`subject`),
  KEY `course` (`course`),
  KEY `s_ins` (`start_institute`),
  CONSTRAINT `contidion` FOREIGN KEY (`contidion`) REFERENCES `article_condition` (`article_condition_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `dep` FOREIGN KEY (`department`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ins` FOREIGN KEY (`institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pid` FOREIGN KEY (`p_id`) REFERENCES `course` (`p_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `subject` FOREIGN KEY (`subject`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `s_ins` FOREIGN KEY (`start_institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teacher` FOREIGN KEY (`teacher`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('1322', '1809101', '19', '80912', '形势与政策', null, '1', '34', '28', null);
INSERT INTO `article` VALUES ('1323', '1809102', '19', '80912', '思想道德修养与法律基础', null, '1', '34', '28', null);
INSERT INTO `article` VALUES ('1324', '1809103', '19', '80912', '中国近现代史纲要', null, '1', '34', '28', null);
INSERT INTO `article` VALUES ('1325', '1809104', '19', '80912', '马克思主义基本原理概论', null, '1', '34', '28', null);
INSERT INTO `article` VALUES ('1326', '1809105', '19', '80912', '毛泽东思想和中国特色社会主义理论体系概论', null, '1', '34', '28', null);
INSERT INTO `article` VALUES ('1327', '1809106', '19', '80912', '大学生心理健康教育', null, '1', '0', '28', null);
INSERT INTO `article` VALUES ('1328', '1808101', '19', '80912', '大学英语Ⅰ-Ⅳ', null, '1', '0', '28', null);
INSERT INTO `article` VALUES ('1329', '1813101', '19', '80912', '体育Ⅰ-Ⅴ', null, '1', '37', '28', null);
INSERT INTO `article` VALUES ('1330', '1915701', '19', '80912', '军事理论与军事训练', null, '1', '0', '28', null);
INSERT INTO `article` VALUES ('1331', '1816101', '19', '80912', '大学生职业发展与就业指导', null, '1', '0', '28', null);
INSERT INTO `article` VALUES ('1332', '1815702', '19', '80912', '劳动教育与社会实践', null, '1', '0', '28', null);
INSERT INTO `article` VALUES ('1333', '1832101', '19', '80912', '创业基础与创新实践', null, '1', '38', '28', null);
INSERT INTO `article` VALUES ('1334', '1912205', '19', '80912', '高等数学Ⅰ-Ⅱ', null, '1', '36', '28', null);
INSERT INTO `article` VALUES ('1335', '1912231', '19', '80912', '线性代数', null, '1', '36', '28', null);
INSERT INTO `article` VALUES ('1336', '1912241', '19', '80912', '概率论与数理统计', null, '1', '36', '28', null);
INSERT INTO `article` VALUES ('1337', '1912252', '19', '80912', '大学物理', null, '1', '36', '28', null);
INSERT INTO `article` VALUES ('1338', '1912272', '19', '80912', '大学物理实验', null, '1', '36', '28', null);
INSERT INTO `article` VALUES ('1339', '1903306', '19', '80912', '专业导论实践课', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1340', '1903307', '19', '80912', '程序设计基础', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1341', '1803308', '19', '80912', '离散结构', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1342', '1802306', '19', '80912', '电工电子技术', null, '1', '26', '28', null);
INSERT INTO `article` VALUES ('1343', '1803401', '19', '80912', '面向对象程序设计', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1344', '1803402', '19', '80912', '数据结构与算法', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1345', '1803403', '19', '80912', '计算机系统基础', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1346', '1803404', '19', '80912', '数据库概论', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1347', '1803405', '19', '80912', '软件工程导论', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1348', '1803406', '19', '80912', '操作系统', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1349', '1803409', '19', '80912', '网络及其计算', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1350', '2103501', '19', '80912', 'Web前端技术', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1351', '2103502', '19', '80912', 'Web前端框架技术', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1352', '1803502', '19', '80912', 'Web编程技术基础', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1353', '2103504', '19', '80912', 'JavaEE框架与技术', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1354', '2103505', '19', '80912', 'Python程序设计', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1355', '1803507', '19', '80912', '软件项目管理', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1356', '2103601', '19', '80912', '软件需求分析', null, '2', '28', '28', 'ZB1803124266');
INSERT INTO `article` VALUES ('1357', '2103602', '19', '80912', '软件设计与体系结构', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1358', '1803606', '19', '80912', '数据库运维技术', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1359', '2103603', '19', '80912', '数据获取与数据处理*', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1360', '2103604', '19', '80912', 'Web前端项目开发实战', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1361', '2103605', '19', '80912', '移动应用开发技术', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1362', '1803607', '19', '80912', '专业外语*', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1363', '2103606', '19', '80912', '面向对象技术与UML建模', 'C:\\apache-tomcat-9.0.56\\webapps\\cos\\article\\2103606面向对象技术与UML建模(计算机与人工智能学院80912专业).doc', '3', '28', '28', 'ZB1803124266');
INSERT INTO `article` VALUES ('1364', '2103607', '19', '80912', '微信小程序项目开发实战', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1365', '1803611', '19', '80912', '算法设计与分析', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1366', '1803610', '19', '80912', '人工智能理论与应用', 'C:\\apache-tomcat-9.0.56\\webapps\\cos\\article\\1803610人工智能理论与应用(计算机与人工智能学院80912专业).doc', '4', '28', '28', 'ZB1803124263');
INSERT INTO `article` VALUES ('1367', '2103608', '19', '80912', 'JavaEE项目开发实战', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1368', '2103609', '19', '80912', 'Android项目开发实战', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1369', '1803612', '19', '80912', '软件工程职业实践', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1370', '1903703', '19', '80912', '程序设计项目实训', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1371', '1803702', '19', '80912', 'Web UI实训', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1372', '1803703', '19', '80912', '数据结构与算法课程设计', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1373', '1803704', '19', '80912', '数据库项目实训', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1374', '1803705', '19', '80912', 'Web项目开发实训', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1375', '1803706', '19', '80912', 'Linux配置与管理实训', 'C:\\apache-tomcat-9.0.56\\webapps\\cos\\article\\1803706Linux配置与管理实训(计算机与人工智能学院80912专业).doc', '6', '28', '28', 'ZB1803124260');
INSERT INTO `article` VALUES ('1376', '1803707', '19', '80912', '生产实习', null, '1', '28', '28', null);
INSERT INTO `article` VALUES ('1377', '2103701', '19', '80912', 'Python数据处理实训', null, '2', '28', '28', 'ZB1803124263');
INSERT INTO `article` VALUES ('1378', '1803709', '19', '80912', '软件工程综合实践', null, '2', '28', '28', 'ZB1803124263');
INSERT INTO `article` VALUES ('1379', '1803710', '19', '80912', '毕业设计及毕业实习', null, '2', '28', '28', 'ZB1803124260');

-- ----------------------------
-- Table structure for article_condition
-- ----------------------------
DROP TABLE IF EXISTS `article_condition`;
CREATE TABLE `article_condition` (
  `article_condition_id` int(10) NOT NULL AUTO_INCREMENT,
  `article_condition_name` varchar(255) NOT NULL,
  PRIMARY KEY (`article_condition_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_condition
-- ----------------------------
INSERT INTO `article_condition` VALUES ('1', '未分配');
INSERT INTO `article_condition` VALUES ('2', '未编写');
INSERT INTO `article_condition` VALUES ('3', '待初审');
INSERT INTO `article_condition` VALUES ('4', '待复审');
INSERT INTO `article_condition` VALUES ('5', '待终审');
INSERT INTO `article_condition` VALUES ('6', '生效中');

-- ----------------------------
-- Table structure for course
-- ----------------------------
DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `p_id` int(255) NOT NULL AUTO_INCREMENT,
  `course_id` int(255) NOT NULL,
  `department` int(10) NOT NULL,
  `subject` int(20) NOT NULL,
  `course_name` varchar(255) NOT NULL,
  `institute` int(10) NOT NULL,
  `start_institute` int(10) DEFAULT NULL,
  `priority` int(10) NOT NULL,
  `all_class_hours` int(10) NOT NULL,
  `credit` double(10,0) NOT NULL,
  `course_type` int(1) NOT NULL,
  PRIMARY KEY (`p_id`,`course_id`,`department`,`subject`),
  KEY `instit` (`institute`),
  KEY `department` (`department`),
  KEY `course_type` (`course_type`),
  KEY `sub` (`subject`),
  KEY `s_instit` (`start_institute`),
  CONSTRAINT `course_type` FOREIGN KEY (`course_type`) REFERENCES `course_type` (`course_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `department` FOREIGN KEY (`department`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `instit` FOREIGN KEY (`institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sub` FOREIGN KEY (`subject`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `s_instit` FOREIGN KEY (`start_institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1380 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course
-- ----------------------------
INSERT INTO `course` VALUES ('1322', '1809101', '19', '80912', '形势与政策', '28', '34', '1', '32', '2', '1');
INSERT INTO `course` VALUES ('1323', '1809102', '19', '80912', '思想道德修养与法律基础', '28', '34', '1', '48', '3', '1');
INSERT INTO `course` VALUES ('1324', '1809103', '19', '80912', '中国近现代史纲要', '28', '34', '4', '48', '3', '1');
INSERT INTO `course` VALUES ('1325', '1809104', '19', '80912', '马克思主义基本原理概论', '28', '34', '5', '48', '3', '1');
INSERT INTO `course` VALUES ('1326', '1809105', '19', '80912', '毛泽东思想和中国特色社会主义理论体系概论', '28', '34', '6', '80', '5', '1');
INSERT INTO `course` VALUES ('1327', '1809106', '19', '80912', '大学生心理健康教育', '28', '0', '1', '32', '2', '1');
INSERT INTO `course` VALUES ('1328', '1808101', '19', '80912', '大学英语Ⅰ-Ⅳ', '28', '0', '1', '256', '16', '1');
INSERT INTO `course` VALUES ('1329', '1813101', '19', '80912', '体育Ⅰ-Ⅴ', '28', '37', '1', '144', '4', '1');
INSERT INTO `course` VALUES ('1330', '1915701', '19', '80912', '军事理论与军事训练', '28', '0', '1', '68', '4', '1');
INSERT INTO `course` VALUES ('1331', '1816101', '19', '80912', '大学生职业发展与就业指导', '28', '0', '1', '38', '2', '1');
INSERT INTO `course` VALUES ('1332', '1815702', '19', '80912', '劳动教育与社会实践', '28', '0', '1', '0', '2', '1');
INSERT INTO `course` VALUES ('1333', '1832101', '19', '80912', '创业基础与创新实践', '28', '38', '1', '48', '3', '1');
INSERT INTO `course` VALUES ('1334', '1912205', '19', '80912', '高等数学Ⅰ-Ⅱ', '28', '36', '1', '180', '11', '1');
INSERT INTO `course` VALUES ('1335', '1912231', '19', '80912', '线性代数', '28', '36', '2', '32', '2', '1');
INSERT INTO `course` VALUES ('1336', '1912241', '19', '80912', '概率论与数理统计', '28', '36', '4', '48', '3', '1');
INSERT INTO `course` VALUES ('1337', '1912252', '19', '80912', '大学物理', '28', '36', '2', '64', '4', '1');
INSERT INTO `course` VALUES ('1338', '1912272', '19', '80912', '大学物理实验', '28', '36', '3', '24', '1', '1');
INSERT INTO `course` VALUES ('1339', '1903306', '19', '80912', '专业导论实践课', '28', '28', '1', '16', '1', '2');
INSERT INTO `course` VALUES ('1340', '1903307', '19', '80912', '程序设计基础', '28', '28', '1', '64', '4', '2');
INSERT INTO `course` VALUES ('1341', '1803308', '19', '80912', '离散结构', '28', '28', '3', '56', '3', '2');
INSERT INTO `course` VALUES ('1342', '1802306', '19', '80912', '电工电子技术', '28', '26', '3', '64', '4', '2');
INSERT INTO `course` VALUES ('1343', '1803401', '19', '80912', '面向对象程序设计', '28', '28', '2', '80', '5', '2');
INSERT INTO `course` VALUES ('1344', '1803402', '19', '80912', '数据结构与算法', '28', '28', '3', '64', '4', '2');
INSERT INTO `course` VALUES ('1345', '1803403', '19', '80912', '计算机系统基础', '28', '28', '4', '56', '3', '2');
INSERT INTO `course` VALUES ('1346', '1803404', '19', '80912', '数据库概论', '28', '28', '4', '64', '4', '2');
INSERT INTO `course` VALUES ('1347', '1803405', '19', '80912', '软件工程导论', '28', '28', '4', '56', '3', '2');
INSERT INTO `course` VALUES ('1348', '1803406', '19', '80912', '操作系统', '28', '28', '5', '56', '3', '2');
INSERT INTO `course` VALUES ('1349', '1803409', '19', '80912', '网络及其计算', '28', '28', '6', '56', '3', '2');
INSERT INTO `course` VALUES ('1350', '2103501', '19', '80912', 'Web前端技术', '28', '28', '5', '56', '3', '3');
INSERT INTO `course` VALUES ('1351', '2103502', '19', '80912', 'Web前端框架技术', '28', '28', '6', '64', '4', '3');
INSERT INTO `course` VALUES ('1352', '1803502', '19', '80912', 'Web编程技术基础', '28', '28', '5', '64', '4', '3');
INSERT INTO `course` VALUES ('1353', '2103504', '19', '80912', 'JavaEE框架与技术', '28', '28', '6', '56', '3', '3');
INSERT INTO `course` VALUES ('1354', '2103505', '19', '80912', 'Python程序设计', '28', '28', '5', '64', '4', '3');
INSERT INTO `course` VALUES ('1355', '1803507', '19', '80912', '软件项目管理', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1356', '2103601', '19', '80912', '软件需求分析', '28', '28', '6', '30', '2', '3');
INSERT INTO `course` VALUES ('1357', '2103602', '19', '80912', '软件设计与体系结构', '28', '28', '6', '30', '2', '3');
INSERT INTO `course` VALUES ('1358', '1803606', '19', '80912', '数据库运维技术', '28', '28', '6', '32', '2', '3');
INSERT INTO `course` VALUES ('1359', '2103603', '19', '80912', '数据获取与数据处理*', '28', '28', '6', '32', '2', '3');
INSERT INTO `course` VALUES ('1360', '2103604', '19', '80912', 'Web前端项目开发实战', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1361', '2103605', '19', '80912', '移动应用开发技术', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1362', '1803607', '19', '80912', '专业外语*', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1363', '2103606', '19', '80912', '面向对象技术与UML建模', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1364', '2103607', '19', '80912', '微信小程序项目开发实战', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1365', '1803611', '19', '80912', '算法设计与分析', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1366', '1803610', '19', '80912', '人工智能理论与应用', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1367', '2103608', '19', '80912', 'JavaEE项目开发实战', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1368', '2103609', '19', '80912', 'Android项目开发实战', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1369', '1803612', '19', '80912', '软件工程职业实践', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1370', '1903703', '19', '80912', '程序设计项目实训', '28', '28', '2', '32', '2', '3');
INSERT INTO `course` VALUES ('1371', '1803702', '19', '80912', 'Web UI实训', '28', '28', '3', '32', '2', '3');
INSERT INTO `course` VALUES ('1372', '1803703', '19', '80912', '数据结构与算法课程设计', '28', '28', '4', '16', '1', '3');
INSERT INTO `course` VALUES ('1373', '1803704', '19', '80912', '数据库项目实训', '28', '28', '4', '16', '1', '3');
INSERT INTO `course` VALUES ('1374', '1803705', '19', '80912', 'Web项目开发实训', '28', '28', '5', '16', '1', '3');
INSERT INTO `course` VALUES ('1375', '1803706', '19', '80912', 'Linux配置与管理实训', '28', '28', '5', '16', '1', '3');
INSERT INTO `course` VALUES ('1376', '1803707', '19', '80912', '生产实习', '28', '28', '6', '32', '2', '3');
INSERT INTO `course` VALUES ('1377', '2103701', '19', '80912', 'Python数据处理实训', '28', '28', '7', '16', '1', '3');
INSERT INTO `course` VALUES ('1378', '1803709', '19', '80912', '软件工程综合实践', '28', '28', '7', '32', '2', '3');
INSERT INTO `course` VALUES ('1379', '1803710', '19', '80912', '毕业设计及毕业实习', '28', '28', '8', '240', '15', '3');

-- ----------------------------
-- Table structure for course_type
-- ----------------------------
DROP TABLE IF EXISTS `course_type`;
CREATE TABLE `course_type` (
  `course_type_id` int(1) NOT NULL AUTO_INCREMENT,
  `course_type_name` varchar(255) NOT NULL,
  PRIMARY KEY (`course_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of course_type
-- ----------------------------
INSERT INTO `course_type` VALUES ('1', '通识教育');
INSERT INTO `course_type` VALUES ('2', '学科基础');
INSERT INTO `course_type` VALUES ('3', '专业教育');

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_id` int(10) NOT NULL AUTO_INCREMENT,
  `department_name` varchar(255) NOT NULL,
  `institute` int(10) NOT NULL,
  PRIMARY KEY (`department_id`),
  KEY `in` (`institute`),
  CONSTRAINT `in` FOREIGN KEY (`institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('19', '软件工程系', '28');
INSERT INTO `department` VALUES ('20', '日语系', '35');
INSERT INTO `department` VALUES ('21', '网络工程系', '28');
INSERT INTO `department` VALUES ('22', '英语系', '35');

-- ----------------------------
-- Table structure for department_head
-- ----------------------------
DROP TABLE IF EXISTS `department_head`;
CREATE TABLE `department_head` (
  `department_id` int(20) NOT NULL,
  `department_head_id` varchar(255) NOT NULL,
  PRIMARY KEY (`department_id`),
  UNIQUE KEY `d2` (`department_head_id`) USING BTREE,
  CONSTRAINT `d1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `d2` FOREIGN KEY (`department_head_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department_head
-- ----------------------------
INSERT INTO `department_head` VALUES ('19', 'ZB1803124260');

-- ----------------------------
-- Table structure for institute
-- ----------------------------
DROP TABLE IF EXISTS `institute`;
CREATE TABLE `institute` (
  `institute_id` int(10) NOT NULL AUTO_INCREMENT,
  `institute_name` varchar(255) NOT NULL,
  PRIMARY KEY (`institute_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of institute
-- ----------------------------
INSERT INTO `institute` VALUES ('0', '未确定');
INSERT INTO `institute` VALUES ('25', '机电工程学院');
INSERT INTO `institute` VALUES ('26', '电气工程学院');
INSERT INTO `institute` VALUES ('27', '土木工程学院');
INSERT INTO `institute` VALUES ('28', '计算机与人工智能学院');
INSERT INTO `institute` VALUES ('29', '电子信息工程学院');
INSERT INTO `institute` VALUES ('30', '材料工程学院');
INSERT INTO `institute` VALUES ('31', '汽车工程学院');
INSERT INTO `institute` VALUES ('32', '经济管理学院');
INSERT INTO `institute` VALUES ('33', '艺术设计学院');
INSERT INTO `institute` VALUES ('34', '马克思主义学院');
INSERT INTO `institute` VALUES ('35', '外国语学院');
INSERT INTO `institute` VALUES ('36', '基础学科部');
INSERT INTO `institute` VALUES ('37', '体育部');
INSERT INTO `institute` VALUES ('38', '创新创业学院');
INSERT INTO `institute` VALUES ('39', '继续教育学院');

-- ----------------------------
-- Table structure for message
-- ----------------------------
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `message_id` int(20) NOT NULL AUTO_INCREMENT,
  `message` varchar(200) NOT NULL,
  `message_type` int(20) NOT NULL,
  `send_user` varchar(50) NOT NULL,
  `receive_user` varchar(50) NOT NULL,
  `time` varchar(66) NOT NULL,
  `message_state` int(20) NOT NULL,
  PRIMARY KEY (`message_id`),
  KEY `message_type` (`message_type`),
  KEY `s_u` (`send_user`),
  KEY `r_u` (`receive_user`),
  KEY `m_s` (`message_state`),
  CONSTRAINT `m_s` FOREIGN KEY (`message_state`) REFERENCES `message_state` (`message_state_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `message_type` FOREIGN KEY (`message_type`) REFERENCES `message_type` (`message_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `r_u` FOREIGN KEY (`receive_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `s_u` FOREIGN KEY (`send_user`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message
-- ----------------------------
INSERT INTO `message` VALUES ('7', '78', '2', 'ZB1803124260', 'ZB1803124260', '2022-03-28 16:50:42', '1');
INSERT INTO `message` VALUES ('8', '89', '2', 'ZB1803124260', 'ZB1803124260', '2022-03-28 16:52:23', '1');
INSERT INTO `message` VALUES ('9', '78', '2', 'ZB1803124260', 'ZB1803124260', '2022-03-28 16:53:49', '1');
INSERT INTO `message` VALUES ('10', '78', '2', 'ZB1803124260', 'ZB1803124260', '2022-03-28 17:00:15', '1');
INSERT INTO `message` VALUES ('11', '78', '2', 'ZB1803124260', 'ZB1803124263', '2022-03-28 17:03:21', '1');
INSERT INTO `message` VALUES ('12', '您的《Python数据处理实训》课程大纲初审已通过！', '1', 'ZB1803124260', 'ZB1803124263', '2022-03-28 19:40:15', '1');
INSERT INTO `message` VALUES ('13', '您的《Linux配置与管理实训》课程大纲初审已通过！', '1', 'ZB1803124260', 'ZB1803124260', '2022-03-28 19:58:47', '1');
INSERT INTO `message` VALUES ('14', '您的《面向对象技术与UML建模》课程大纲初审已通过！', '1', 'ZB1803124260', 'ZB1803124266', '2022-03-28 20:32:24', '1');
INSERT INTO `message` VALUES ('15', '您的《面向对象技术与UML建模》课程大纲复审已通过！', '3', 'ZB1803124266', 'ZB1803124266', '2022-03-28 20:34:01', '2');
INSERT INTO `message` VALUES ('16', '您的《Linux配置与管理实训》课程大纲复审已通过！', '3', 'ZB1803124266', 'ZB1803124260', '2022-03-28 20:41:12', '1');
INSERT INTO `message` VALUES ('17', '您的《软件需求分析》课程大纲初审已通过！', '1', 'ZB1803124260', 'ZB1803124266', '2022-03-28 20:47:09', '2');
INSERT INTO `message` VALUES ('18', '78', '4', 'ZB1803124266', 'ZB1803124266', '2022-03-28 20:47:28', '1');
INSERT INTO `message` VALUES ('19', '63', '2', 'ZB1803124260', 'ZB1803124266', '2022-03-28 20:48:06', '1');
INSERT INTO `message` VALUES ('20', '您的《软件需求分析》课程大纲复审已通过！', '3', 'ZB1803124266', 'ZB1803124266', '2022-03-28 20:48:28', '1');
INSERT INTO `message` VALUES ('21', 'null', '2', 'ZB1803124260', 'ZB1803124260', '2022-03-28 21:36:49', '1');
INSERT INTO `message` VALUES ('22', '您的《Linux配置与管理实训》课程大纲初审已通过！', '1', 'ZB1803124260', 'ZB1803124260', '2022-03-29 01:01:17', '2');
INSERT INTO `message` VALUES ('23', '您的《人工智能理论与应用》课程大纲初审已通过！', '1', 'ZB1803124260', 'ZB1803124263', '2022-03-29 01:07:34', '1');
INSERT INTO `message` VALUES ('24', '您的《Linux配置与管理实训》课程大纲复审已通过！', '3', 'ZB1803124266', 'ZB1803124260', '2022-03-29 01:07:53', '2');
INSERT INTO `message` VALUES ('25', '789', '6', 'ZB1803124267', 'ZB1803124260', '2022-03-29 01:19:30', '1');
INSERT INTO `message` VALUES ('26', '您的《Linux配置与管理实训》课程大纲终审已通过！', '5', 'ZB1803124267', 'ZB1803124260', '2022-03-29 01:20:57', '1');

-- ----------------------------
-- Table structure for message_state
-- ----------------------------
DROP TABLE IF EXISTS `message_state`;
CREATE TABLE `message_state` (
  `message_state_id` int(20) NOT NULL,
  `message_state` varchar(50) NOT NULL,
  PRIMARY KEY (`message_state_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_state
-- ----------------------------
INSERT INTO `message_state` VALUES ('1', '已读');
INSERT INTO `message_state` VALUES ('2', '未读');

-- ----------------------------
-- Table structure for message_type
-- ----------------------------
DROP TABLE IF EXISTS `message_type`;
CREATE TABLE `message_type` (
  `message_type_id` int(5) NOT NULL,
  `message_type_name` varchar(20) NOT NULL,
  PRIMARY KEY (`message_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of message_type
-- ----------------------------
INSERT INTO `message_type` VALUES ('1', '初审通过通知');
INSERT INTO `message_type` VALUES ('2', '初审未通过通知');
INSERT INTO `message_type` VALUES ('3', '复审通过通知');
INSERT INTO `message_type` VALUES ('4', '复审未通过通知');
INSERT INTO `message_type` VALUES ('5', '终审通过通知');
INSERT INTO `message_type` VALUES ('6', '终审未通过通知');
INSERT INTO `message_type` VALUES ('7', '学院通知');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `position_id` int(1) NOT NULL AUTO_INCREMENT,
  `position_name` varchar(255) NOT NULL,
  PRIMARY KEY (`position_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES ('1', '教师');
INSERT INTO `position` VALUES ('2', '教学系主任');
INSERT INTO `position` VALUES ('3', '学院办公室');
INSERT INTO `position` VALUES ('4', '学院领导');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `subject_id` int(20) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
  `department_id` int(20) NOT NULL,
  PRIMARY KEY (`subject_id`),
  KEY `dep_id` (`department_id`),
  CONSTRAINT `dep_id` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject
-- ----------------------------
INSERT INTO `subject` VALUES ('50207', '日语', '20');
INSERT INTO `subject` VALUES ('50505', '商务英语', '22');
INSERT INTO `subject` VALUES ('80912', '软件工程', '19');
INSERT INTO `subject` VALUES ('80913', '网络工程', '21');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `user_id` varchar(255) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `cellphone` varchar(255) NOT NULL,
  `authority` int(10) NOT NULL,
  `state` int(10) NOT NULL,
  `institute` int(10) NOT NULL,
  `position` int(10) NOT NULL,
  PRIMARY KEY (`user_id`),
  KEY `institute` (`institute`),
  KEY `position` (`position`),
  CONSTRAINT `institute` FOREIGN KEY (`institute`) REFERENCES `institute` (`institute_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `position` FOREIGN KEY (`position`) REFERENCES `position` (`position_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('ZB1803124260', '张三', '120612', '17693175231', '1', '1', '28', '2');
INSERT INTO `user` VALUES ('ZB1803124263', '李四', '120612', '17693175231', '1', '1', '28', '1');
INSERT INTO `user` VALUES ('ZB1803124266', '王二', '120612', '17693175231', '1', '1', '28', '3');
INSERT INTO `user` VALUES ('ZB1803124267', '刘五', '120612', '17693175231', '1', '1', '28', '4');
