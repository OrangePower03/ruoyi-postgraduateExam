/*
 Navicat Premium Data Transfer

 Source Server         : jsjds
 Source Server Type    : MySQL
 Source Server Version : 50740
 Source Host           : 47.93.241.85:3306
 Source Schema         : jsjds

 Target Server Type    : MySQL
 Target Server Version : 50740
 File Encoding         : 65001

 Date: 12/09/2023 22:16:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;
drop database if exists `jsjds`;
create database `jsjds`;
use `jsjds`;
-- ----------------------------
-- Table structure for QRTZ_BLOB_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_BLOB_TRIGGERS`;
CREATE TABLE `QRTZ_BLOB_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_BLOB_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CALENDARS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CALENDARS`;
CREATE TABLE `QRTZ_CALENDARS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '日历信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CALENDARS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_CRON_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_CRON_TRIGGERS`;
CREATE TABLE `QRTZ_CRON_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_CRON_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_FIRED_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_FIRED_TRIGGERS`;
CREATE TABLE `QRTZ_FIRED_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint(13) NOT NULL COMMENT '触发的时间',
  `sched_time` bigint(13) NOT NULL COMMENT '定时器制定的时间',
  `priority` int(11) NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '已触发的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_FIRED_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_JOB_DETAILS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_JOB_DETAILS`;
CREATE TABLE `QRTZ_JOB_DETAILS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_JOB_DETAILS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_LOCKS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_LOCKS`;
CREATE TABLE `QRTZ_LOCKS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_LOCKS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_PAUSED_TRIGGER_GRPS`;
CREATE TABLE `QRTZ_PAUSED_TRIGGER_GRPS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '暂停的触发器表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_PAUSED_TRIGGER_GRPS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SCHEDULER_STATE
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SCHEDULER_STATE`;
CREATE TABLE `QRTZ_SCHEDULER_STATE`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint(13) NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint(13) NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度器状态表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SCHEDULER_STATE
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPLE_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPLE_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPLE_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint(7) NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint(12) NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint(10) NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPLE_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_SIMPROP_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_SIMPROP_TRIGGERS`;
CREATE TABLE `QRTZ_SIMPROP_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int(11) NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint(20) NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `QRTZ_TRIGGERS` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_SIMPROP_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for QRTZ_TRIGGERS
-- ----------------------------
DROP TABLE IF EXISTS `QRTZ_TRIGGERS`;
CREATE TABLE `QRTZ_TRIGGERS`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint(13) NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int(11) NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint(13) NOT NULL COMMENT '开始时间',
  `end_time` bigint(13) NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint(2) NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name`, `job_name`, `job_group`) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `QRTZ_JOB_DETAILS` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '触发器详细信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of QRTZ_TRIGGERS
-- ----------------------------

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'wx_area', '', NULL, NULL, 'WxArea', 'crud', 'com.ruoyi.system', 'system', 'area', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-03-25 20:13:14', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (2, 'wx_department', '', NULL, NULL, 'WxDepartment', 'crud', 'com.ruoyi.system', 'system', 'department', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-03-25 20:13:14', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (4, 'wx_school', '', NULL, NULL, 'WxSchool', 'crud', 'com.ruoyi.system', 'system', 'school', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-03-25 20:13:14', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (5, 'wx_score', '', NULL, NULL, 'WxScore', 'crud', 'com.ruoyi.system', 'system', 'score', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-03-25 20:13:14', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (6, 'wx_major', '', NULL, NULL, 'WxMajor', 'crud', 'com.ruoyi.system', 'system', 'major', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-04-05 13:52:24', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (7, 'cys_score', '', NULL, NULL, 'CysScore', 'crud', 'com.ruoyi.system', 'system', 'score', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-04-14 19:35:54', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (8, 'wx_mcd', '', NULL, NULL, 'WxMcd', 'crud', 'com.ruoyi.system', 'system', 'mcd', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-04-23 14:05:50', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (9, 'wx_dscore', '', NULL, NULL, 'WxDscore', 'crud', 'com.ruoyi.system', 'system', 'dscore', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-04-23 18:05:21', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (10, 'wx_feedback', '', NULL, NULL, 'WxFeedback', 'crud', 'com.ruoyi.system', 'system', 'feedback', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-04-25 22:06:31', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (11, 'wx_user_scoreinfo', '', NULL, NULL, 'WxUserScoreinfo', 'crud', 'com.ruoyi.system', 'system', 'scoreinfo', NULL, 'ruoyi', '0', '/', NULL, 'admin', '2023-04-26 14:11:13', '', NULL, NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'area_id', '地区主键', 'int', 'Long', 'areaId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (2, '1', 'area_name', '地区名称', 'varchar(255)', 'String', 'areaName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (3, '1', 'area_type', '判断该地区是一区还是二区', 'int', 'Long', 'areaType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 3, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (4, '2', 'department_id', '院系编号', 'int', 'Long', 'departmentId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (5, '2', 'department_name', '院系名称', 'varchar(255)', 'String', 'departmentName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (6, '2', 'department_school_id', '院系所在的学校', 'varchar(255)', 'String', 'departmentSchoolId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (11, '4', 'school_id', '学校的编号', 'int', 'Long', 'schoolId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-03-25 20:13:14', '', '2023-03-27 09:55:31');
INSERT INTO `gen_table_column` VALUES (12, '4', 'school_name', '学校的名字', 'varchar(255)', 'String', 'schoolName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2023-03-25 20:13:14', '', '2023-03-27 09:55:31');
INSERT INTO `gen_table_column` VALUES (13, '4', 'school_area', '学校所在地区', 'int', 'Long', 'schoolArea', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-03-25 20:13:14', '', '2023-03-27 09:55:31');
INSERT INTO `gen_table_column` VALUES (14, '4', 'school_type', '是否为34所自划线', 'int', 'Long', 'schoolType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 4, 'admin', '2023-03-25 20:13:14', '', '2023-03-27 09:55:31');
INSERT INTO `gen_table_column` VALUES (15, '4', 'school_levels', '学校层次', 'int', 'Long', 'schoolLevels', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2023-03-25 20:13:14', '', '2023-03-27 09:55:31');
INSERT INTO `gen_table_column` VALUES (16, '5', 'score_id', '分数线编号', 'int', 'Long', 'scoreId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (17, '5', 'score_year', '考试的年份', 'int', 'Long', 'scoreYear', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (18, '5', 'score_all', '复试线', 'int', 'Long', 'scoreAll', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (19, '5', 'score_math', '数学线', 'int', 'Long', 'scoreMath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (20, '5', 'score_english', '英语线', 'int', 'Long', 'scoreEnglish', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (21, '5', 'score_politics', '政治线', 'int', 'Long', 'scorePolitics', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (22, '5', 'score_major', '专业线', 'int', 'Long', 'scoreMajor', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (23, '5', 'score_major_id', '专业编号', 'int', 'Long', 'scoreMajorId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2023-03-25 20:13:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (24, '6', 'major_id', '专业编号', 'varchar(255)', 'Long', 'majorId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-04-05 13:52:24', '', '2023-04-05 18:23:00');
INSERT INTO `gen_table_column` VALUES (25, '6', 'major_name', '专业名称', 'varchar(255)', 'String', 'majorName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 'admin', '2023-04-05 13:52:24', '', '2023-04-05 18:23:00');
INSERT INTO `gen_table_column` VALUES (26, '6', 'major_department_id', '专业所在院', 'int', 'Long', 'majorDepartmentId', '1', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-04-05 13:52:24', '', '2023-04-05 18:23:00');
INSERT INTO `gen_table_column` VALUES (27, '6', 'major_type', '专业类型（学硕、专硕）', 'int', 'Long', 'majorType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 5, 'admin', '2023-04-05 13:52:24', '', '2023-04-05 18:23:00');
INSERT INTO `gen_table_column` VALUES (28, '6', 'major_code', '专业代码', 'varchar(255)', 'String', 'majorCode', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, '', '2023-04-05 18:23:00', '', NULL);
INSERT INTO `gen_table_column` VALUES (29, '7', 'score_id', NULL, 'int', 'Long', 'scoreId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (30, '7', 'score_major_id', NULL, 'int', 'Long', 'scoreMajorId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (31, '7', 'score_year', NULL, 'int', 'Long', 'scoreYear', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (32, '7', 'score_all', NULL, 'int', 'Long', 'scoreAll', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (33, '7', 'score_math', NULL, 'int', 'Long', 'scoreMath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (34, '7', 'score_english', NULL, 'int', 'Long', 'scoreEnglish', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (35, '7', 'score_politics', NULL, 'int', 'Long', 'scorePolitics', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (36, '7', 'score_major', NULL, 'int', 'Long', 'scoreMajor', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2023-04-14 19:35:54', '', NULL);
INSERT INTO `gen_table_column` VALUES (37, '8', 'connect_id', '连接编号', 'int', 'Long', 'connectId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-04-23 14:05:50', '', NULL);
INSERT INTO `gen_table_column` VALUES (38, '8', 'major_id', '专业编号', 'int', 'Long', 'majorId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-04-23 14:05:50', '', NULL);
INSERT INTO `gen_table_column` VALUES (39, '8', 'department_id', '院系编号', 'int', 'Long', 'departmentId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-04-23 14:05:50', '', NULL);
INSERT INTO `gen_table_column` VALUES (40, '9', 'score_id', '分数编号', 'int', 'Long', 'scoreId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (41, '9', 'score_year', '考研年份', 'int', 'Long', 'scoreYear', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (42, '9', 'score_all', '复试线', 'int', 'Long', 'scoreAll', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (43, '9', 'score_math', '专业一', 'int', 'Long', 'scoreMath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (44, '9', 'score_english', '英语线', 'int', 'Long', 'scoreEnglish', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (45, '9', 'score_politics', '政治线', 'int', 'Long', 'scorePolitics', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (46, '9', 'score_major', '专业线', 'int', 'Long', 'scoreMajor', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (47, '9', 'major_id', '专业编号', 'int', 'Long', 'majorId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (48, '9', 'area_type', '地区类型', 'int', 'Long', 'areaType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 9, 'admin', '2023-04-23 18:05:21', '', NULL);
INSERT INTO `gen_table_column` VALUES (49, '10', 'user_id', '用户编号', 'int', 'Long', 'userId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-04-25 22:06:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (50, '10', 'satisfaction', '满意程度', 'int', 'Long', 'satisfaction', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-04-25 22:06:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (51, '10', 'action', '调剂情况', 'varchar(255)', 'String', 'action', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-04-25 22:06:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (52, '10', 'suggest', '您的建议', 'varchar(255)', 'String', 'suggest', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-04-25 22:06:31', '', NULL);
INSERT INTO `gen_table_column` VALUES (53, '11', 'user_id', '用户编号', 'int', 'Long', 'userId', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (54, '11', 'score_all', '初试成绩', 'int', 'Long', 'scoreAll', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (55, '11', 'score_english', '初试英语', 'int', 'Long', 'scoreEnglish', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (56, '11', 'score_politics', '初始政治', 'int', 'Long', 'scorePolitics', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (57, '11', 'score_math', '专业一', 'int', 'Long', 'scoreMath', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (58, '11', 'score_major', '专业二', 'int', 'Long', 'scoreMajor', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (59, '11', 'major_name', '专业名称', 'varchar(255)', 'String', 'majorName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 7, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (60, '11', 'major_type', '专业类型', 'int', 'Long', 'majorType', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', '', 8, 'admin', '2023-04-26 14:11:13', '', NULL);
INSERT INTO `gen_table_column` VALUES (61, '11', 'area_name', '地区名称', 'varchar(255)', 'String', 'areaName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 9, 'admin', '2023-04-26 14:11:13', '', NULL);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(5) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2023-04-17 20:09:11', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2023-04-17 20:09:11', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2023-04-17 20:09:12', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2023-04-17 20:09:12', 'admin', '2023-05-04 20:44:44', '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2023-04-17 20:09:12', 'admin', '2023-05-03 18:14:21', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2023-04-17 20:09:12', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int(4) NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2023-04-17 20:09:02', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(4) NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2023-04-17 20:09:11', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2023-04-17 20:09:10', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2023-04-17 20:09:12', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2023-04-17 20:09:12', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2023-04-17 20:09:12', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status`) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 924 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-01 20:50:15');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-01 20:50:15');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-05-01 20:50:26');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-01 20:50:26');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 20:50:38');
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-03 20:16:20');
INSERT INTO `sys_logininfor` VALUES (159, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-05 12:58:13');
INSERT INTO `sys_logininfor` VALUES (160, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-05 17:08:10');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-05 18:12:39');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-04-05 19:36:52');
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-05 19:36:55');
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-06 08:36:41');
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-06 09:22:13');
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-07 09:48:12');
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-07 11:37:41');
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-07 13:03:43');
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-07 19:41:14');
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-07 21:23:30');
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-09 14:47:41');
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-09 19:22:20');
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-09 19:22:29');
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-10 10:15:55');
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-10 16:15:56');
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-10 16:17:45');
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-10 16:18:22');
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-10 16:18:27');
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-10 16:19:59');
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-10 16:20:19');
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-10 16:22:21');
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-10 16:22:41');
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-10 16:22:45');
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-11 13:36:08');
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-11 18:49:38');
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-14 18:30:06');
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-14 18:30:21');
INSERT INTO `sys_logininfor` VALUES (188, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-14 18:36:38');
INSERT INTO `sys_logininfor` VALUES (189, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-14 18:36:58');
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-14 18:37:03');
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-14 18:37:07');
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-14 21:35:10');
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-15 19:31:01');
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-16 16:58:56');
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-16 17:18:57');
INSERT INTO `sys_logininfor` VALUES (196, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-16 17:34:17');
INSERT INTO `sys_logininfor` VALUES (197, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-16 18:08:38');
INSERT INTO `sys_logininfor` VALUES (198, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-16 18:40:01');
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-16 19:40:08');
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-16 20:40:41');
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-16 20:40:45');
INSERT INTO `sys_logininfor` VALUES (202, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-17 19:14:52');
INSERT INTO `sys_logininfor` VALUES (203, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-04-17 20:05:05');
INSERT INTO `sys_logininfor` VALUES (204, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-17 20:05:12');
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-22 18:28:16');
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-23 12:51:04');
INSERT INTO `sys_logininfor` VALUES (207, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-23 12:51:07');
INSERT INTO `sys_logininfor` VALUES (208, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '登录用户：xckhh 不存在', '2023-04-23 13:21:38');
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-23 13:21:46');
INSERT INTO `sys_logininfor` VALUES (210, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-23 16:01:57');
INSERT INTO `sys_logininfor` VALUES (211, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-23 18:00:52');
INSERT INTO `sys_logininfor` VALUES (212, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-23 20:12:46');
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-23 20:12:50');
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-23 21:33:15');
INSERT INTO `sys_logininfor` VALUES (215, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 10:06:39');
INSERT INTO `sys_logininfor` VALUES (216, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 13:59:06');
INSERT INTO `sys_logininfor` VALUES (217, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 16:34:24');
INSERT INTO `sys_logininfor` VALUES (218, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 18:17:28');
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 18:47:36');
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 19:45:28');
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-24 22:24:43');
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-25 00:12:18');
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-25 08:43:21');
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-25 13:19:44');
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-25 13:19:48');
INSERT INTO `sys_logininfor` VALUES (226, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-25 15:36:09');
INSERT INTO `sys_logininfor` VALUES (227, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-25 19:55:31');
INSERT INTO `sys_logininfor` VALUES (228, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-25 23:59:26');
INSERT INTO `sys_logininfor` VALUES (229, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 07:31:36');
INSERT INTO `sys_logininfor` VALUES (230, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 08:31:33');
INSERT INTO `sys_logininfor` VALUES (231, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 11:14:00');
INSERT INTO `sys_logininfor` VALUES (232, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-04-26 11:14:12');
INSERT INTO `sys_logininfor` VALUES (233, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:14:20');
INSERT INTO `sys_logininfor` VALUES (234, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 11:15:06');
INSERT INTO `sys_logininfor` VALUES (235, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 11:15:16');
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:15:23');
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 11:16:45');
INSERT INTO `sys_logininfor` VALUES (238, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:17:03');
INSERT INTO `sys_logininfor` VALUES (239, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 11:21:57');
INSERT INTO `sys_logininfor` VALUES (240, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:22:02');
INSERT INTO `sys_logininfor` VALUES (241, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 11:22:07');
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:22:15');
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:23:06');
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 11:27:29');
INSERT INTO `sys_logininfor` VALUES (245, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 11:27:47');
INSERT INTO `sys_logininfor` VALUES (246, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 11:27:51');
INSERT INTO `sys_logininfor` VALUES (247, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 13:50:26');
INSERT INTO `sys_logininfor` VALUES (248, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 14:10:27');
INSERT INTO `sys_logininfor` VALUES (249, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 14:10:42');
INSERT INTO `sys_logininfor` VALUES (250, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 15:38:10');
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 15:38:16');
INSERT INTO `sys_logininfor` VALUES (252, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 16:28:27');
INSERT INTO `sys_logininfor` VALUES (253, '栾吉宁', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-26 16:28:47');
INSERT INTO `sys_logininfor` VALUES (254, '栾吉宁', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 16:29:02');
INSERT INTO `sys_logininfor` VALUES (255, '栾吉宁', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 16:40:55');
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 16:41:07');
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 16:41:11');
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 16:41:55');
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 16:42:09');
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 16:42:45');
INSERT INTO `sys_logininfor` VALUES (261, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 16:43:02');
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 16:43:50');
INSERT INTO `sys_logininfor` VALUES (263, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 16:48:39');
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 16:48:52');
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 19:10:55');
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 19:11:00');
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 19:12:04');
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 19:15:08');
INSERT INTO `sys_logininfor` VALUES (269, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 19:15:31');
INSERT INTO `sys_logininfor` VALUES (270, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 19:19:02');
INSERT INTO `sys_logininfor` VALUES (271, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-04-26 19:25:31');
INSERT INTO `sys_logininfor` VALUES (272, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 19:25:49');
INSERT INTO `sys_logininfor` VALUES (273, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 19:25:52');
INSERT INTO `sys_logininfor` VALUES (274, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 19:25:58');
INSERT INTO `sys_logininfor` VALUES (275, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-04-26 19:26:02');
INSERT INTO `sys_logininfor` VALUES (276, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-04-26 19:26:02');
INSERT INTO `sys_logininfor` VALUES (277, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 19:26:11');
INSERT INTO `sys_logininfor` VALUES (278, '123456', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-26 20:36:41');
INSERT INTO `sys_logininfor` VALUES (279, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-26 20:41:25');
INSERT INTO `sys_logininfor` VALUES (280, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 20:41:44');
INSERT INTO `sys_logininfor` VALUES (281, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:19:16');
INSERT INTO `sys_logininfor` VALUES (282, '123456', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:19:30');
INSERT INTO `sys_logininfor` VALUES (283, '123456', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:19:40');
INSERT INTO `sys_logininfor` VALUES (284, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 21:19:58');
INSERT INTO `sys_logininfor` VALUES (285, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:20:05');
INSERT INTO `sys_logininfor` VALUES (286, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:21:54');
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:22:06');
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:24:42');
INSERT INTO `sys_logininfor` VALUES (289, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:24:52');
INSERT INTO `sys_logininfor` VALUES (290, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:43:50');
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:44:08');
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:45:06');
INSERT INTO `sys_logininfor` VALUES (293, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:45:17');
INSERT INTO `sys_logininfor` VALUES (294, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:48:14');
INSERT INTO `sys_logininfor` VALUES (295, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:48:30');
INSERT INTO `sys_logininfor` VALUES (296, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:48:56');
INSERT INTO `sys_logininfor` VALUES (297, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:49:05');
INSERT INTO `sys_logininfor` VALUES (298, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:49:20');
INSERT INTO `sys_logininfor` VALUES (299, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:49:27');
INSERT INTO `sys_logininfor` VALUES (300, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:49:41');
INSERT INTO `sys_logininfor` VALUES (301, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:49:51');
INSERT INTO `sys_logininfor` VALUES (302, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 21:51:41');
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 21:51:51');
INSERT INTO `sys_logininfor` VALUES (304, '777', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-26 23:24:25');
INSERT INTO `sys_logininfor` VALUES (305, '777', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 23:24:33');
INSERT INTO `sys_logininfor` VALUES (306, '777', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 23:27:45');
INSERT INTO `sys_logininfor` VALUES (307, '999', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-04-26 23:30:21');
INSERT INTO `sys_logininfor` VALUES (308, '999', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 23:30:31');
INSERT INTO `sys_logininfor` VALUES (309, '999', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 23:32:29');
INSERT INTO `sys_logininfor` VALUES (310, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-26 23:32:43');
INSERT INTO `sys_logininfor` VALUES (311, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 23:32:46');
INSERT INTO `sys_logininfor` VALUES (312, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-26 23:33:28');
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-26 23:33:38');
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-04-27 00:33:12');
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-27 00:33:15');
INSERT INTO `sys_logininfor` VALUES (316, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-27 20:31:01');
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-27 23:28:44');
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-27 23:38:46');
INSERT INTO `sys_logininfor` VALUES (319, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-27 23:38:58');
INSERT INTO `sys_logininfor` VALUES (320, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-27 23:43:03');
INSERT INTO `sys_logininfor` VALUES (321, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-27 23:43:16');
INSERT INTO `sys_logininfor` VALUES (322, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-27 23:45:44');
INSERT INTO `sys_logininfor` VALUES (323, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-27 23:45:52');
INSERT INTO `sys_logininfor` VALUES (324, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-28 08:34:50');
INSERT INTO `sys_logininfor` VALUES (325, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-28 09:46:09');
INSERT INTO `sys_logininfor` VALUES (326, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-04-28 16:32:27');
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-28 16:32:31');
INSERT INTO `sys_logininfor` VALUES (328, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-29 16:09:10');
INSERT INTO `sys_logininfor` VALUES (329, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:09:17');
INSERT INTO `sys_logininfor` VALUES (330, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:10:02');
INSERT INTO `sys_logininfor` VALUES (331, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:10:15');
INSERT INTO `sys_logininfor` VALUES (332, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:11:04');
INSERT INTO `sys_logininfor` VALUES (333, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:11:07');
INSERT INTO `sys_logininfor` VALUES (334, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:12:11');
INSERT INTO `sys_logininfor` VALUES (335, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:12:21');
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:19:05');
INSERT INTO `sys_logininfor` VALUES (337, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-29 16:19:37');
INSERT INTO `sys_logininfor` VALUES (338, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-04-29 16:19:40');
INSERT INTO `sys_logininfor` VALUES (339, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-04-29 16:19:40');
INSERT INTO `sys_logininfor` VALUES (340, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:19:47');
INSERT INTO `sys_logininfor` VALUES (341, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:20:17');
INSERT INTO `sys_logininfor` VALUES (342, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:21:00');
INSERT INTO `sys_logininfor` VALUES (343, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:21:08');
INSERT INTO `sys_logininfor` VALUES (344, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:21:18');
INSERT INTO `sys_logininfor` VALUES (345, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-04-29 16:24:05');
INSERT INTO `sys_logininfor` VALUES (346, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-04-29 16:24:05');
INSERT INTO `sys_logininfor` VALUES (347, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-04-29 16:24:13');
INSERT INTO `sys_logininfor` VALUES (348, 'admin', '127.0.0.1', '内网IP', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-04-29 16:24:16');
INSERT INTO `sys_logininfor` VALUES (349, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-29 16:27:48');
INSERT INTO `sys_logininfor` VALUES (350, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-29 16:57:28');
INSERT INTO `sys_logininfor` VALUES (351, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 16:57:31');
INSERT INTO `sys_logininfor` VALUES (352, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-29 17:39:00');
INSERT INTO `sys_logininfor` VALUES (353, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 17:39:04');
INSERT INTO `sys_logininfor` VALUES (354, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-29 18:18:05');
INSERT INTO `sys_logininfor` VALUES (355, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-04-30 11:12:46');
INSERT INTO `sys_logininfor` VALUES (356, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-04-30 11:12:46');
INSERT INTO `sys_logininfor` VALUES (357, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-30 11:12:58');
INSERT INTO `sys_logininfor` VALUES (358, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-30 11:20:41');
INSERT INTO `sys_logininfor` VALUES (359, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-30 11:21:04');
INSERT INTO `sys_logininfor` VALUES (360, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-30 11:21:28');
INSERT INTO `sys_logininfor` VALUES (361, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-30 11:21:40');
INSERT INTO `sys_logininfor` VALUES (362, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-30 11:31:14');
INSERT INTO `sys_logininfor` VALUES (363, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-30 11:31:28');
INSERT INTO `sys_logininfor` VALUES (364, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-30 11:32:06');
INSERT INTO `sys_logininfor` VALUES (365, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-30 11:32:15');
INSERT INTO `sys_logininfor` VALUES (366, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-04-30 11:32:19');
INSERT INTO `sys_logininfor` VALUES (367, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-04-30 11:32:19');
INSERT INTO `sys_logininfor` VALUES (368, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-30 11:32:25');
INSERT INTO `sys_logininfor` VALUES (369, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-04-30 11:33:42');
INSERT INTO `sys_logininfor` VALUES (370, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-30 11:33:53');
INSERT INTO `sys_logininfor` VALUES (371, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-04-30 11:34:01');
INSERT INTO `sys_logininfor` VALUES (372, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-04-30 11:34:04');
INSERT INTO `sys_logininfor` VALUES (373, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 15:22:15');
INSERT INTO `sys_logininfor` VALUES (374, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 16:35:59');
INSERT INTO `sys_logininfor` VALUES (375, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 17:38:43');
INSERT INTO `sys_logininfor` VALUES (376, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-01 17:40:09');
INSERT INTO `sys_logininfor` VALUES (377, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 17:40:19');
INSERT INTO `sys_logininfor` VALUES (378, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-01 20:59:29');
INSERT INTO `sys_logininfor` VALUES (379, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-01 20:59:34');
INSERT INTO `sys_logininfor` VALUES (380, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-01 20:59:34');
INSERT INTO `sys_logininfor` VALUES (381, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-05-01 20:59:38');
INSERT INTO `sys_logininfor` VALUES (382, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-01 20:59:38');
INSERT INTO `sys_logininfor` VALUES (383, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-01 20:59:41');
INSERT INTO `sys_logininfor` VALUES (384, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 20:59:49');
INSERT INTO `sys_logininfor` VALUES (385, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-01 21:01:21');
INSERT INTO `sys_logininfor` VALUES (386, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 21:01:39');
INSERT INTO `sys_logininfor` VALUES (387, '赵若彤', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-01 21:01:46');
INSERT INTO `sys_logininfor` VALUES (388, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 21:01:54');
INSERT INTO `sys_logininfor` VALUES (389, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-01 21:02:11');
INSERT INTO `sys_logininfor` VALUES (390, '崔元帅', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 22:06:09');
INSERT INTO `sys_logininfor` VALUES (391, 'admin', '111.15.80.214', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-01 23:45:40');
INSERT INTO `sys_logininfor` VALUES (392, 'admin', '111.15.80.214', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-01 23:45:40');
INSERT INTO `sys_logininfor` VALUES (393, 'admin', '111.15.80.214', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-01 23:45:48');
INSERT INTO `sys_logininfor` VALUES (394, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '1', '用户不存在/密码错误', '2023-05-01 23:46:53');
INSERT INTO `sys_logininfor` VALUES (395, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '1', '密码输入错误1次', '2023-05-01 23:46:53');
INSERT INTO `sys_logininfor` VALUES (396, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2023-05-01 23:47:00');
INSERT INTO `sys_logininfor` VALUES (397, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2023-05-01 23:47:05');
INSERT INTO `sys_logininfor` VALUES (398, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '退出成功', '2023-05-01 23:48:40');
INSERT INTO `sys_logininfor` VALUES (399, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '1', '用户不存在/密码错误', '2023-05-01 23:49:05');
INSERT INTO `sys_logininfor` VALUES (400, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '1', '密码输入错误1次', '2023-05-01 23:49:05');
INSERT INTO `sys_logininfor` VALUES (401, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2023-05-01 23:49:17');
INSERT INTO `sys_logininfor` VALUES (402, 'admin', '117.136.95.215', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2023-05-01 23:49:21');
INSERT INTO `sys_logininfor` VALUES (403, 'admin', '111.15.85.78', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-02 10:21:00');
INSERT INTO `sys_logininfor` VALUES (404, 'admin', '111.15.85.78', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-02 10:21:00');
INSERT INTO `sys_logininfor` VALUES (405, 'admin', '111.15.85.78', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-02 10:21:06');
INSERT INTO `sys_logininfor` VALUES (406, 'admin', '111.16.180.63', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-05-02 11:21:06');
INSERT INTO `sys_logininfor` VALUES (407, 'admin', '111.16.180.63', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-02 11:21:06');
INSERT INTO `sys_logininfor` VALUES (408, 'admin', '111.15.81.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-02 19:36:10');
INSERT INTO `sys_logininfor` VALUES (409, 'admin', '111.15.81.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-02 19:36:10');
INSERT INTO `sys_logininfor` VALUES (410, 'admin', '111.15.81.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-02 19:36:13');
INSERT INTO `sys_logininfor` VALUES (411, 'admin', '111.15.81.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-02 19:36:17');
INSERT INTO `sys_logininfor` VALUES (412, 'admin', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-02 21:23:52');
INSERT INTO `sys_logininfor` VALUES (413, 'admin', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-02 21:23:57');
INSERT INTO `sys_logininfor` VALUES (414, 'admin', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-02 21:23:57');
INSERT INTO `sys_logininfor` VALUES (415, 'admin', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-02 21:24:02');
INSERT INTO `sys_logininfor` VALUES (416, 'admin', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-02 21:28:37');
INSERT INTO `sys_logininfor` VALUES (417, '崔元帅', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-02 21:30:10');
INSERT INTO `sys_logininfor` VALUES (418, '崔元帅', '111.15.81.20', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-02 21:30:14');
INSERT INTO `sys_logininfor` VALUES (419, 'admin', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-05-03 16:39:48');
INSERT INTO `sys_logininfor` VALUES (420, 'admin', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 16:39:48');
INSERT INTO `sys_logininfor` VALUES (421, 'cys', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '1', '登录用户：cys 不存在', '2023-05-03 16:40:02');
INSERT INTO `sys_logininfor` VALUES (422, '崔元帅', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-03 16:40:17');
INSERT INTO `sys_logininfor` VALUES (423, '崔元帅', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-03 18:11:38');
INSERT INTO `sys_logininfor` VALUES (424, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-03 18:13:01');
INSERT INTO `sys_logininfor` VALUES (425, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 18:13:01');
INSERT INTO `sys_logininfor` VALUES (426, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-05-03 18:13:04');
INSERT INTO `sys_logininfor` VALUES (427, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 18:13:04');
INSERT INTO `sys_logininfor` VALUES (428, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 18:13:10');
INSERT INTO `sys_logininfor` VALUES (429, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-03 18:14:24');
INSERT INTO `sys_logininfor` VALUES (430, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 18:15:02');
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-03 18:15:42');
INSERT INTO `sys_logininfor` VALUES (432, '崔元帅', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-03 18:18:45');
INSERT INTO `sys_logininfor` VALUES (433, '123', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '0', '注册成功', '2023-05-03 18:19:04');
INSERT INTO `sys_logininfor` VALUES (434, '123', '111.15.80.187', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-03 18:19:14');
INSERT INTO `sys_logininfor` VALUES (435, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-03 18:53:11');
INSERT INTO `sys_logininfor` VALUES (436, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 18:53:14');
INSERT INTO `sys_logininfor` VALUES (437, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-03 19:32:06');
INSERT INTO `sys_logininfor` VALUES (438, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 19:32:06');
INSERT INTO `sys_logininfor` VALUES (439, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-03 19:32:17');
INSERT INTO `sys_logininfor` VALUES (440, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-05-03 19:32:21');
INSERT INTO `sys_logininfor` VALUES (441, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 19:32:21');
INSERT INTO `sys_logininfor` VALUES (442, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 19:32:25');
INSERT INTO `sys_logininfor` VALUES (443, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误3次', '2023-05-03 19:32:25');
INSERT INTO `sys_logininfor` VALUES (444, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-03 19:32:28');
INSERT INTO `sys_logininfor` VALUES (445, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 19:32:34');
INSERT INTO `sys_logininfor` VALUES (446, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误4次', '2023-05-03 19:32:34');
INSERT INTO `sys_logininfor` VALUES (447, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 19:32:40');
INSERT INTO `sys_logininfor` VALUES (448, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-03 19:40:37');
INSERT INTO `sys_logininfor` VALUES (449, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 19:40:40');
INSERT INTO `sys_logininfor` VALUES (450, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 20:59:09');
INSERT INTO `sys_logininfor` VALUES (451, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-03 21:03:56');
INSERT INTO `sys_logininfor` VALUES (452, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-03 21:03:56');
INSERT INTO `sys_logininfor` VALUES (453, 'admin', '111.15.96.81', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-03 21:04:02');
INSERT INTO `sys_logininfor` VALUES (454, '崔元帅', '111.15.84.198', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-04 14:00:14');
INSERT INTO `sys_logininfor` VALUES (455, '崔元帅', '111.15.84.198', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-04 19:20:50');
INSERT INTO `sys_logininfor` VALUES (456, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-04 20:10:01');
INSERT INTO `sys_logininfor` VALUES (457, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-04 20:10:01');
INSERT INTO `sys_logininfor` VALUES (458, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-04 20:10:08');
INSERT INTO `sys_logininfor` VALUES (459, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-04 20:15:50');
INSERT INTO `sys_logininfor` VALUES (460, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-04 20:17:19');
INSERT INTO `sys_logininfor` VALUES (461, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-04 20:17:19');
INSERT INTO `sys_logininfor` VALUES (462, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-04 20:17:23');
INSERT INTO `sys_logininfor` VALUES (463, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-04 20:31:11');
INSERT INTO `sys_logininfor` VALUES (464, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-04 20:31:11');
INSERT INTO `sys_logininfor` VALUES (465, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-04 20:31:16');
INSERT INTO `sys_logininfor` VALUES (466, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-04 20:44:52');
INSERT INTO `sys_logininfor` VALUES (467, 'admin', '111.15.84.183', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-04 20:50:08');
INSERT INTO `sys_logininfor` VALUES (468, '崔元帅', '111.15.84.198', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码已失效', '2023-05-04 20:55:13');
INSERT INTO `sys_logininfor` VALUES (469, '崔元帅', '111.15.84.198', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-04 20:55:17');
INSERT INTO `sys_logininfor` VALUES (470, 'admin', '223.97.53.7', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-04 21:26:29');
INSERT INTO `sys_logininfor` VALUES (471, 'admin', '223.97.53.7', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-04 21:26:29');
INSERT INTO `sys_logininfor` VALUES (472, 'admin', '223.97.53.7', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-05-04 21:26:34');
INSERT INTO `sys_logininfor` VALUES (473, 'admin', '223.97.53.7', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-04 21:26:34');
INSERT INTO `sys_logininfor` VALUES (474, 'admin', '223.97.53.7', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误3次', '2023-05-04 21:26:47');
INSERT INTO `sys_logininfor` VALUES (475, 'admin', '223.97.53.7', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-04 21:26:47');
INSERT INTO `sys_logininfor` VALUES (476, '崔元帅', '111.15.84.185', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 12:01:52');
INSERT INTO `sys_logininfor` VALUES (477, 'admin', '111.15.96.233', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 12:06:10');
INSERT INTO `sys_logininfor` VALUES (478, 'admin', '111.15.96.233', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 12:06:10');
INSERT INTO `sys_logininfor` VALUES (479, 'admin', '111.15.96.233', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 12:06:54');
INSERT INTO `sys_logininfor` VALUES (480, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:06:44');
INSERT INTO `sys_logininfor` VALUES (481, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:06:54');
INSERT INTO `sys_logininfor` VALUES (482, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:08:38');
INSERT INTO `sys_logininfor` VALUES (483, '123', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:08:44');
INSERT INTO `sys_logininfor` VALUES (484, '123', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:10:18');
INSERT INTO `sys_logininfor` VALUES (485, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:10:35');
INSERT INTO `sys_logininfor` VALUES (486, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:10:44');
INSERT INTO `sys_logininfor` VALUES (487, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:10:49');
INSERT INTO `sys_logininfor` VALUES (488, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:11:39');
INSERT INTO `sys_logininfor` VALUES (489, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 17:11:41');
INSERT INTO `sys_logininfor` VALUES (490, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:11:41');
INSERT INTO `sys_logininfor` VALUES (491, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:11:50');
INSERT INTO `sys_logininfor` VALUES (492, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:13:47');
INSERT INTO `sys_logininfor` VALUES (493, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 17:14:55');
INSERT INTO `sys_logininfor` VALUES (494, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:14:55');
INSERT INTO `sys_logininfor` VALUES (495, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-05 17:15:06');
INSERT INTO `sys_logininfor` VALUES (496, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-05 17:16:36');
INSERT INTO `sys_logininfor` VALUES (497, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:16:45');
INSERT INTO `sys_logininfor` VALUES (498, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:16:54');
INSERT INTO `sys_logininfor` VALUES (499, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:17:46');
INSERT INTO `sys_logininfor` VALUES (500, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:17:52');
INSERT INTO `sys_logininfor` VALUES (501, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:18:53');
INSERT INTO `sys_logininfor` VALUES (502, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 17:18:59');
INSERT INTO `sys_logininfor` VALUES (503, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:18:59');
INSERT INTO `sys_logininfor` VALUES (504, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:19:04');
INSERT INTO `sys_logininfor` VALUES (505, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:19:10');
INSERT INTO `sys_logininfor` VALUES (506, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:19:18');
INSERT INTO `sys_logininfor` VALUES (507, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 17:19:22');
INSERT INTO `sys_logininfor` VALUES (508, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:19:22');
INSERT INTO `sys_logininfor` VALUES (509, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:19:32');
INSERT INTO `sys_logininfor` VALUES (510, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:20:12');
INSERT INTO `sys_logininfor` VALUES (511, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:20:44');
INSERT INTO `sys_logininfor` VALUES (512, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:20:56');
INSERT INTO `sys_logininfor` VALUES (513, 'manager', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '1', '登录用户：manager 不存在', '2023-05-05 17:21:19');
INSERT INTO `sys_logininfor` VALUES (514, 'manager', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 17:21:25');
INSERT INTO `sys_logininfor` VALUES (515, 'manager', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '1', '登录用户：manager 不存在', '2023-05-05 17:21:30');
INSERT INTO `sys_logininfor` VALUES (516, 'manage', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 17:21:50');
INSERT INTO `sys_logininfor` VALUES (517, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:22:05');
INSERT INTO `sys_logininfor` VALUES (518, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:22:26');
INSERT INTO `sys_logininfor` VALUES (519, 'manage', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-05 17:22:33');
INSERT INTO `sys_logininfor` VALUES (520, 'manage', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:22:43');
INSERT INTO `sys_logininfor` VALUES (521, 'user', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 17:22:46');
INSERT INTO `sys_logininfor` VALUES (522, 'user', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 17:22:51');
INSERT INTO `sys_logininfor` VALUES (523, 'user', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-05 17:23:26');
INSERT INTO `sys_logininfor` VALUES (524, 'admin', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 17:23:42');
INSERT INTO `sys_logininfor` VALUES (525, 'admin', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 17:23:48');
INSERT INTO `sys_logininfor` VALUES (526, 'admin', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-05 17:24:16');
INSERT INTO `sys_logininfor` VALUES (527, 'manager', '223.104.195.5', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 17:24:31');
INSERT INTO `sys_logininfor` VALUES (528, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 17:45:02');
INSERT INTO `sys_logininfor` VALUES (529, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 17:45:02');
INSERT INTO `sys_logininfor` VALUES (530, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:45:09');
INSERT INTO `sys_logininfor` VALUES (531, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:49:59');
INSERT INTO `sys_logininfor` VALUES (532, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:50:04');
INSERT INTO `sys_logininfor` VALUES (533, '赵若彤', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 17:50:22');
INSERT INTO `sys_logininfor` VALUES (534, '赵若彤', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:50:25');
INSERT INTO `sys_logininfor` VALUES (535, '赵若彤', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:53:27');
INSERT INTO `sys_logininfor` VALUES (536, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:53:35');
INSERT INTO `sys_logininfor` VALUES (537, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 17:54:12');
INSERT INTO `sys_logininfor` VALUES (538, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 17:54:18');
INSERT INTO `sys_logininfor` VALUES (539, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 18:05:14');
INSERT INTO `sys_logininfor` VALUES (540, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 18:05:14');
INSERT INTO `sys_logininfor` VALUES (541, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-05-05 18:05:48');
INSERT INTO `sys_logininfor` VALUES (542, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 18:05:48');
INSERT INTO `sys_logininfor` VALUES (543, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 18:05:56');
INSERT INTO `sys_logininfor` VALUES (544, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-05 18:06:01');
INSERT INTO `sys_logininfor` VALUES (545, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误3次', '2023-05-05 18:06:04');
INSERT INTO `sys_logininfor` VALUES (546, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 18:06:04');
INSERT INTO `sys_logininfor` VALUES (547, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 18:06:13');
INSERT INTO `sys_logininfor` VALUES (548, 'admin', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 18:06:59');
INSERT INTO `sys_logininfor` VALUES (549, 'admin', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 18:07:03');
INSERT INTO `sys_logininfor` VALUES (550, 'admin', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 18:07:03');
INSERT INTO `sys_logininfor` VALUES (551, 'admin', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误2次', '2023-05-05 18:07:52');
INSERT INTO `sys_logininfor` VALUES (552, 'admin', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 18:07:52');
INSERT INTO `sys_logininfor` VALUES (553, 'admin', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 18:08:00');
INSERT INTO `sys_logininfor` VALUES (554, 'manage', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码已失效', '2023-05-05 18:35:19');
INSERT INTO `sys_logininfor` VALUES (555, 'manage', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '1', '登录用户：manage 不存在', '2023-05-05 18:35:24');
INSERT INTO `sys_logininfor` VALUES (556, 'manager', '111.15.84.164', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 18:35:31');
INSERT INTO `sys_logininfor` VALUES (557, 'admin', '221.0.95.239', 'XX XX', 'Chrome 11', 'Mac OS X', '1', '密码输入错误1次', '2023-05-05 19:21:03');
INSERT INTO `sys_logininfor` VALUES (558, 'admin', '221.0.95.239', 'XX XX', 'Chrome 11', 'Mac OS X', '1', '用户不存在/密码错误', '2023-05-05 19:21:03');
INSERT INTO `sys_logininfor` VALUES (559, 'admin', '221.0.95.239', 'XX XX', 'Chrome 11', 'Mac OS X', '0', '登录成功', '2023-05-05 19:21:11');
INSERT INTO `sys_logininfor` VALUES (560, 'admin', '221.0.95.239', 'XX XX', 'Chrome 11', 'Mac OS X', '0', '退出成功', '2023-05-05 19:21:47');
INSERT INTO `sys_logininfor` VALUES (561, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-05 20:53:13');
INSERT INTO `sys_logininfor` VALUES (562, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 20:53:18');
INSERT INTO `sys_logininfor` VALUES (563, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 20:56:36');
INSERT INTO `sys_logininfor` VALUES (564, 'qqq', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-05 20:59:01');
INSERT INTO `sys_logininfor` VALUES (565, 'qqq', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 20:59:13');
INSERT INTO `sys_logininfor` VALUES (566, 'qqq', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 21:13:36');
INSERT INTO `sys_logininfor` VALUES (567, 'www', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-05 21:14:12');
INSERT INTO `sys_logininfor` VALUES (568, 'www', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 21:14:22');
INSERT INTO `sys_logininfor` VALUES (569, 'www', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 21:19:57');
INSERT INTO `sys_logininfor` VALUES (570, 'manager', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 21:20:11');
INSERT INTO `sys_logininfor` VALUES (571, 'manager', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 21:25:40');
INSERT INTO `sys_logininfor` VALUES (572, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 21:25:46');
INSERT INTO `sys_logininfor` VALUES (573, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 21:26:20');
INSERT INTO `sys_logininfor` VALUES (574, 'manager', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-05 22:20:36');
INSERT INTO `sys_logininfor` VALUES (575, 'manager', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 22:20:39');
INSERT INTO `sys_logininfor` VALUES (576, 'manager', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 22:25:38');
INSERT INTO `sys_logininfor` VALUES (577, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 22:25:45');
INSERT INTO `sys_logininfor` VALUES (578, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 22:54:17');
INSERT INTO `sys_logininfor` VALUES (579, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 22:54:17');
INSERT INTO `sys_logininfor` VALUES (580, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误2次', '2023-05-05 22:54:24');
INSERT INTO `sys_logininfor` VALUES (581, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 22:54:24');
INSERT INTO `sys_logininfor` VALUES (582, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误3次', '2023-05-05 22:54:33');
INSERT INTO `sys_logininfor` VALUES (583, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 22:54:33');
INSERT INTO `sys_logininfor` VALUES (584, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误4次', '2023-05-05 22:54:34');
INSERT INTO `sys_logininfor` VALUES (585, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 22:54:34');
INSERT INTO `sys_logininfor` VALUES (586, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 22:54:34');
INSERT INTO `sys_logininfor` VALUES (587, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 22:54:35');
INSERT INTO `sys_logininfor` VALUES (588, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 22:54:35');
INSERT INTO `sys_logininfor` VALUES (589, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 22:54:35');
INSERT INTO `sys_logininfor` VALUES (590, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-05-05 22:54:35');
INSERT INTO `sys_logininfor` VALUES (591, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误5次', '2023-05-05 22:54:36');
INSERT INTO `sys_logininfor` VALUES (592, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 22:54:36');
INSERT INTO `sys_logininfor` VALUES (593, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 22:55:04');
INSERT INTO `sys_logininfor` VALUES (594, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-05 22:55:42');
INSERT INTO `sys_logininfor` VALUES (595, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2023-05-05 22:55:49');
INSERT INTO `sys_logininfor` VALUES (596, 'admin', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '1', '密码输入错误5次，帐户锁定10分钟', '2023-05-05 22:55:49');
INSERT INTO `sys_logininfor` VALUES (597, '1233456', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '注册成功', '2023-05-05 22:56:11');
INSERT INTO `sys_logininfor` VALUES (598, '1233456', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-05 22:56:18');
INSERT INTO `sys_logininfor` VALUES (599, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-05-05 23:10:38');
INSERT INTO `sys_logininfor` VALUES (600, 'admin', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-05-05 23:10:38');
INSERT INTO `sys_logininfor` VALUES (601, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-05 23:13:05');
INSERT INTO `sys_logininfor` VALUES (602, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 23:13:09');
INSERT INTO `sys_logininfor` VALUES (603, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 23:13:17');
INSERT INTO `sys_logininfor` VALUES (604, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 23:13:25');
INSERT INTO `sys_logininfor` VALUES (605, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 23:13:28');
INSERT INTO `sys_logininfor` VALUES (606, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-05 23:53:28');
INSERT INTO `sys_logininfor` VALUES (607, 'user', '111.15.84.164', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-05 23:53:31');
INSERT INTO `sys_logininfor` VALUES (608, 'user', '111.15.97.239', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-06 10:13:07');
INSERT INTO `sys_logininfor` VALUES (609, 'user', '111.15.97.239', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-06 10:15:45');
INSERT INTO `sys_logininfor` VALUES (610, 'user', '111.15.97.239', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-06 10:16:59');
INSERT INTO `sys_logininfor` VALUES (611, 'admin', '221.0.95.239', 'XX XX', 'Chrome 11', 'Mac OS X', '0', '登录成功', '2023-05-06 11:52:54');
INSERT INTO `sys_logininfor` VALUES (612, '1233456', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-06 13:38:50');
INSERT INTO `sys_logininfor` VALUES (613, 'user', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-06 14:11:25');
INSERT INTO `sys_logininfor` VALUES (614, 'user', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-06 14:11:35');
INSERT INTO `sys_logininfor` VALUES (615, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-06 14:24:41');
INSERT INTO `sys_logininfor` VALUES (616, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Windows 10', '0', '退出成功', '2023-05-06 14:25:23');
INSERT INTO `sys_logininfor` VALUES (617, 'user', '111.15.97.239', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-06 18:07:46');
INSERT INTO `sys_logininfor` VALUES (618, 'user', '111.15.97.239', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-06 18:07:51');
INSERT INTO `sys_logininfor` VALUES (619, 'user', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 09:46:14');
INSERT INTO `sys_logininfor` VALUES (620, 'user', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-07 09:46:53');
INSERT INTO `sys_logininfor` VALUES (621, 'admin', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 09:47:01');
INSERT INTO `sys_logininfor` VALUES (622, 'user', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 09:51:07');
INSERT INTO `sys_logininfor` VALUES (623, 'admin', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-07 10:08:58');
INSERT INTO `sys_logininfor` VALUES (624, 'user', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 10:09:07');
INSERT INTO `sys_logininfor` VALUES (625, 'user', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-07 10:09:27');
INSERT INTO `sys_logininfor` VALUES (626, 'user', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 10:10:17');
INSERT INTO `sys_logininfor` VALUES (627, 'user', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-07 10:17:00');
INSERT INTO `sys_logininfor` VALUES (628, 'manager', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 10:17:21');
INSERT INTO `sys_logininfor` VALUES (629, 'manager', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-07 10:18:12');
INSERT INTO `sys_logininfor` VALUES (630, 'admin', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-07 10:18:23');
INSERT INTO `sys_logininfor` VALUES (631, 'admin', '111.15.96.119', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-07 10:18:52');
INSERT INTO `sys_logininfor` VALUES (632, 'sss', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-08 23:51:48');
INSERT INTO `sys_logininfor` VALUES (633, 'sss', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-08 23:52:04');
INSERT INTO `sys_logininfor` VALUES (634, 'sss', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-08 23:52:47');
INSERT INTO `sys_logininfor` VALUES (635, '111', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-08 23:53:29');
INSERT INTO `sys_logininfor` VALUES (636, '111', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-08 23:53:43');
INSERT INTO `sys_logininfor` VALUES (637, '111', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-08 23:53:47');
INSERT INTO `sys_logininfor` VALUES (638, '111', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-08 23:54:18');
INSERT INTO `sys_logininfor` VALUES (639, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-05-08 23:56:35');
INSERT INTO `sys_logininfor` VALUES (640, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-08 23:56:47');
INSERT INTO `sys_logininfor` VALUES (641, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:08:27');
INSERT INTO `sys_logininfor` VALUES (642, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:08:38');
INSERT INTO `sys_logininfor` VALUES (643, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:09:28');
INSERT INTO `sys_logininfor` VALUES (644, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:09:38');
INSERT INTO `sys_logininfor` VALUES (645, '222', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:14:37');
INSERT INTO `sys_logininfor` VALUES (646, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:14:52');
INSERT INTO `sys_logininfor` VALUES (647, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:17:46');
INSERT INTO `sys_logininfor` VALUES (648, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:18:51');
INSERT INTO `sys_logininfor` VALUES (649, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:21:28');
INSERT INTO `sys_logininfor` VALUES (650, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:22:13');
INSERT INTO `sys_logininfor` VALUES (651, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:22:31');
INSERT INTO `sys_logininfor` VALUES (652, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-09 00:22:46');
INSERT INTO `sys_logininfor` VALUES (653, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-09 00:22:49');
INSERT INTO `sys_logininfor` VALUES (654, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-09 00:23:04');
INSERT INTO `sys_logininfor` VALUES (655, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:23:07');
INSERT INTO `sys_logininfor` VALUES (656, 'manager', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-09 00:24:43');
INSERT INTO `sys_logininfor` VALUES (657, 'admin', '111.15.97.230', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-09 00:24:52');
INSERT INTO `sys_logininfor` VALUES (658, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Mac OS X', '0', '登录成功', '2023-05-10 13:18:48');
INSERT INTO `sys_logininfor` VALUES (659, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Mac OS X', '0', '退出成功', '2023-05-10 13:24:40');
INSERT INTO `sys_logininfor` VALUES (660, 'user', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-10 13:31:33');
INSERT INTO `sys_logininfor` VALUES (661, 'user', '111.15.84.209', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-10 16:17:44');
INSERT INTO `sys_logininfor` VALUES (662, 'user', '111.15.84.209', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-10 16:17:47');
INSERT INTO `sys_logininfor` VALUES (663, 'user', '111.15.84.209', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-10 16:17:51');
INSERT INTO `sys_logininfor` VALUES (664, 'user', '111.15.84.209', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-10 16:18:01');
INSERT INTO `sys_logininfor` VALUES (665, 'user', '112.6.19.93', 'XX XX', 'Chrome 11', 'Mac OS X', '0', '登录成功', '2023-05-10 18:19:24');
INSERT INTO `sys_logininfor` VALUES (666, 'admin', '111.15.85.73', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-12 09:24:24');
INSERT INTO `sys_logininfor` VALUES (667, 'admin', '223.99.7.7', 'XX XX', 'Chrome 10', 'Windows 7', '0', '登录成功', '2023-05-13 15:27:35');
INSERT INTO `sys_logininfor` VALUES (668, 'user', '111.15.84.196', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-15 08:27:04');
INSERT INTO `sys_logininfor` VALUES (669, 'user', '111.15.84.196', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-15 08:27:12');
INSERT INTO `sys_logininfor` VALUES (670, 'user', '111.15.84.196', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-15 08:27:35');
INSERT INTO `sys_logininfor` VALUES (671, 'user', '111.15.84.12', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-05-17 16:39:31');
INSERT INTO `sys_logininfor` VALUES (672, 'user', '111.15.84.12', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-17 16:39:37');
INSERT INTO `sys_logininfor` VALUES (673, 'user', '111.15.96.156', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-18 16:33:35');
INSERT INTO `sys_logininfor` VALUES (674, 'user', '111.15.85.57', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-05-21 21:46:09');
INSERT INTO `sys_logininfor` VALUES (675, 'user', '111.15.85.57', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-21 21:46:17');
INSERT INTO `sys_logininfor` VALUES (676, 'user', '111.15.85.57', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-05-21 21:46:29');
INSERT INTO `sys_logininfor` VALUES (677, 'user', '221.0.91.92', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-05-29 20:16:18');
INSERT INTO `sys_logininfor` VALUES (678, 'user', '111.15.85.232', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-05-31 15:34:10');
INSERT INTO `sys_logininfor` VALUES (679, 'user', '111.15.96.30', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-02 08:50:08');
INSERT INTO `sys_logininfor` VALUES (680, 'user', '111.15.84.169', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-08 16:11:34');
INSERT INTO `sys_logininfor` VALUES (681, 'user', '111.15.84.169', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-06-08 16:11:50');
INSERT INTO `sys_logininfor` VALUES (682, 'admin', '111.15.84.169', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-06-08 16:12:09');
INSERT INTO `sys_logininfor` VALUES (683, 'admin', '111.15.84.169', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-06-08 16:12:09');
INSERT INTO `sys_logininfor` VALUES (684, 'admin', '111.15.84.169', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-08 16:12:34');
INSERT INTO `sys_logininfor` VALUES (685, 'admin', '111.15.80.185', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-26 08:22:54');
INSERT INTO `sys_logininfor` VALUES (686, 'admin', '111.15.80.185', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-06-26 08:23:23');
INSERT INTO `sys_logininfor` VALUES (687, 'user', '111.15.80.185', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-26 08:23:29');
INSERT INTO `sys_logininfor` VALUES (688, 'user', '111.15.80.185', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-06-26 08:31:43');
INSERT INTO `sys_logininfor` VALUES (689, 'admin', '111.15.80.185', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-26 08:31:49');
INSERT INTO `sys_logininfor` VALUES (690, '崔元帅', '111.15.96.194', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-06-28 20:59:01');
INSERT INTO `sys_logininfor` VALUES (691, 'admin', '111.15.81.138', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-29 08:51:46');
INSERT INTO `sys_logininfor` VALUES (692, 'admin', '111.15.85.94', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-29 23:02:13');
INSERT INTO `sys_logininfor` VALUES (693, 'admin', '111.15.85.94', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-06-29 23:02:39');
INSERT INTO `sys_logininfor` VALUES (694, 'admin', '111.15.85.94', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-29 23:40:14');
INSERT INTO `sys_logininfor` VALUES (695, 'admin', '111.15.85.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-06-30 11:04:17');
INSERT INTO `sys_logininfor` VALUES (696, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-02 10:30:50');
INSERT INTO `sys_logininfor` VALUES (697, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-02 10:30:52');
INSERT INTO `sys_logininfor` VALUES (698, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-02 10:31:00');
INSERT INTO `sys_logininfor` VALUES (699, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-02 10:31:35');
INSERT INTO `sys_logininfor` VALUES (700, 'user', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-02 10:31:45');
INSERT INTO `sys_logininfor` VALUES (701, 'user', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-02 10:47:46');
INSERT INTO `sys_logininfor` VALUES (702, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-07-02 10:47:58');
INSERT INTO `sys_logininfor` VALUES (703, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-07-02 10:47:58');
INSERT INTO `sys_logininfor` VALUES (704, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误2次', '2023-07-02 10:48:08');
INSERT INTO `sys_logininfor` VALUES (705, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-07-02 10:48:08');
INSERT INTO `sys_logininfor` VALUES (706, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误3次', '2023-07-02 10:48:22');
INSERT INTO `sys_logininfor` VALUES (707, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-07-02 10:48:22');
INSERT INTO `sys_logininfor` VALUES (708, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-07-02 10:50:42');
INSERT INTO `sys_logininfor` VALUES (709, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-02 10:50:48');
INSERT INTO `sys_logininfor` VALUES (710, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-02 10:50:53');
INSERT INTO `sys_logininfor` VALUES (711, 'admin', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-02 10:50:57');
INSERT INTO `sys_logininfor` VALUES (712, 'manager', '111.15.80.211', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-02 10:51:11');
INSERT INTO `sys_logininfor` VALUES (713, 'admin', '111.15.80.155', 'XX XX', 'Chrome 9', 'Windows 10', '1', '密码输入错误1次', '2023-07-10 15:42:08');
INSERT INTO `sys_logininfor` VALUES (714, 'admin', '111.15.80.155', 'XX XX', 'Chrome 9', 'Windows 10', '1', '用户不存在/密码错误', '2023-07-10 15:42:08');
INSERT INTO `sys_logininfor` VALUES (715, 'admin', '111.15.80.155', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-10 15:42:20');
INSERT INTO `sys_logininfor` VALUES (716, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-10 15:55:46');
INSERT INTO `sys_logininfor` VALUES (717, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-10 17:26:26');
INSERT INTO `sys_logininfor` VALUES (718, 'admin', '111.15.80.155', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-10 22:09:18');
INSERT INTO `sys_logininfor` VALUES (719, 'admin', '111.15.80.155', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-10 22:09:22');
INSERT INTO `sys_logininfor` VALUES (720, 'admin', '111.15.81.227', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-07-11 08:52:57');
INSERT INTO `sys_logininfor` VALUES (721, 'admin', '111.15.81.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 08:53:06');
INSERT INTO `sys_logininfor` VALUES (722, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 09:05:54');
INSERT INTO `sys_logininfor` VALUES (723, 'admin', '111.15.81.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 10:55:45');
INSERT INTO `sys_logininfor` VALUES (724, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 11:06:34');
INSERT INTO `sys_logininfor` VALUES (725, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-11 11:06:40');
INSERT INTO `sys_logininfor` VALUES (726, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 11:06:52');
INSERT INTO `sys_logininfor` VALUES (727, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-11 11:13:48');
INSERT INTO `sys_logininfor` VALUES (728, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-11 11:14:03');
INSERT INTO `sys_logininfor` VALUES (729, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 11:14:07');
INSERT INTO `sys_logininfor` VALUES (730, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 18:47:31');
INSERT INTO `sys_logininfor` VALUES (731, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-11 23:38:08');
INSERT INTO `sys_logininfor` VALUES (732, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-12 16:59:59');
INSERT INTO `sys_logininfor` VALUES (733, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-12 17:45:40');
INSERT INTO `sys_logininfor` VALUES (734, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-12 20:53:04');
INSERT INTO `sys_logininfor` VALUES (735, 'admin', '111.15.81.220', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-12 21:13:10');
INSERT INTO `sys_logininfor` VALUES (736, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-13 21:48:03');
INSERT INTO `sys_logininfor` VALUES (737, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-13 21:48:03');
INSERT INTO `sys_logininfor` VALUES (738, 'xckhh', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-13 22:00:17');
INSERT INTO `sys_logininfor` VALUES (739, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-13 22:00:28');
INSERT INTO `sys_logininfor` VALUES (740, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-13 22:00:33');
INSERT INTO `sys_logininfor` VALUES (741, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-14 00:11:37');
INSERT INTO `sys_logininfor` VALUES (742, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 00:11:38');
INSERT INTO `sys_logininfor` VALUES (743, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-14 00:17:58');
INSERT INTO `sys_logininfor` VALUES (744, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 00:18:01');
INSERT INTO `sys_logininfor` VALUES (745, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 00:18:06');
INSERT INTO `sys_logininfor` VALUES (746, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-14 00:18:06');
INSERT INTO `sys_logininfor` VALUES (747, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-14 00:31:19');
INSERT INTO `sys_logininfor` VALUES (748, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-14 08:18:45');
INSERT INTO `sys_logininfor` VALUES (749, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 08:18:52');
INSERT INTO `sys_logininfor` VALUES (750, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-14 08:19:09');
INSERT INTO `sys_logininfor` VALUES (751, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 08:19:10');
INSERT INTO `sys_logininfor` VALUES (752, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-14 08:19:25');
INSERT INTO `sys_logininfor` VALUES (753, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 08:19:33');
INSERT INTO `sys_logininfor` VALUES (754, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 11:05:11');
INSERT INTO `sys_logininfor` VALUES (755, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 11:13:06');
INSERT INTO `sys_logininfor` VALUES (756, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 11:13:12');
INSERT INTO `sys_logininfor` VALUES (757, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-14 11:13:21');
INSERT INTO `sys_logininfor` VALUES (758, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 11:23:29');
INSERT INTO `sys_logininfor` VALUES (759, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-14 11:23:38');
INSERT INTO `sys_logininfor` VALUES (760, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 11:23:43');
INSERT INTO `sys_logininfor` VALUES (761, 'admin', '127.0.0.1', '内网IP', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 19:47:23');
INSERT INTO `sys_logininfor` VALUES (762, 'admin', '111.15.85.121', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-14 19:57:10');
INSERT INTO `sys_logininfor` VALUES (763, 'admin', '111.15.81.224', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-15 08:57:23');
INSERT INTO `sys_logininfor` VALUES (764, '崔元帅', '111.15.81.59', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-07-16 12:51:47');
INSERT INTO `sys_logininfor` VALUES (765, 'admin', '58.57.27.253', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-07-16 13:22:49');
INSERT INTO `sys_logininfor` VALUES (766, 'admin', '111.15.96.203', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-16 17:30:00');
INSERT INTO `sys_logininfor` VALUES (767, 'admin', '111.15.81.53', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-21 18:44:10');
INSERT INTO `sys_logininfor` VALUES (768, 'admin', '111.15.81.53', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-21 18:52:15');
INSERT INTO `sys_logininfor` VALUES (769, 'admin', '111.15.84.238', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-21 21:46:20');
INSERT INTO `sys_logininfor` VALUES (770, 'admin', '111.15.85.155', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-07-22 10:21:49');
INSERT INTO `sys_logininfor` VALUES (771, 'admin', '111.15.85.155', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-22 10:21:53');
INSERT INTO `sys_logininfor` VALUES (772, 'admin', '111.15.85.155', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-22 11:30:44');
INSERT INTO `sys_logininfor` VALUES (773, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-22 19:56:15');
INSERT INTO `sys_logininfor` VALUES (774, 'aaa', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-07-23 09:21:03');
INSERT INTO `sys_logininfor` VALUES (775, 'aaa', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 09:21:20');
INSERT INTO `sys_logininfor` VALUES (776, 'aaa', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 09:24:55');
INSERT INTO `sys_logininfor` VALUES (777, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 09:25:02');
INSERT INTO `sys_logininfor` VALUES (778, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 09:29:31');
INSERT INTO `sys_logininfor` VALUES (779, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 09:29:52');
INSERT INTO `sys_logininfor` VALUES (780, 'tt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-07-23 10:34:26');
INSERT INTO `sys_logininfor` VALUES (781, 'tt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 10:34:39');
INSERT INTO `sys_logininfor` VALUES (782, 'tt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 10:37:53');
INSERT INTO `sys_logininfor` VALUES (783, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 10:38:04');
INSERT INTO `sys_logininfor` VALUES (784, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 10:38:52');
INSERT INTO `sys_logininfor` VALUES (785, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 10:38:58');
INSERT INTO `sys_logininfor` VALUES (786, 'admin', '111.15.80.80', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-23 11:57:28');
INSERT INTO `sys_logininfor` VALUES (787, 'admin', '111.15.80.80', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-23 11:57:32');
INSERT INTO `sys_logininfor` VALUES (788, 'admin', '111.15.80.80', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 11:57:34');
INSERT INTO `sys_logininfor` VALUES (789, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-07-23 14:25:03');
INSERT INTO `sys_logininfor` VALUES (790, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:25:17');
INSERT INTO `sys_logininfor` VALUES (791, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 14:27:41');
INSERT INTO `sys_logininfor` VALUES (792, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:27:50');
INSERT INTO `sys_logininfor` VALUES (793, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 14:28:06');
INSERT INTO `sys_logininfor` VALUES (794, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:28:10');
INSERT INTO `sys_logininfor` VALUES (795, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 14:28:49');
INSERT INTO `sys_logininfor` VALUES (796, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:28:56');
INSERT INTO `sys_logininfor` VALUES (797, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 14:32:26');
INSERT INTO `sys_logininfor` VALUES (798, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:32:29');
INSERT INTO `sys_logininfor` VALUES (799, 'admin', '111.15.80.80', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:33:31');
INSERT INTO `sys_logininfor` VALUES (800, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 14:44:28');
INSERT INTO `sys_logininfor` VALUES (801, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:44:40');
INSERT INTO `sys_logininfor` VALUES (802, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 14:55:24');
INSERT INTO `sys_logininfor` VALUES (803, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 14:55:30');
INSERT INTO `sys_logininfor` VALUES (804, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 15:04:26');
INSERT INTO `sys_logininfor` VALUES (805, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 15:04:32');
INSERT INTO `sys_logininfor` VALUES (806, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 15:28:12');
INSERT INTO `sys_logininfor` VALUES (807, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 15:29:39');
INSERT INTO `sys_logininfor` VALUES (808, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 15:42:11');
INSERT INTO `sys_logininfor` VALUES (809, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 15:42:52');
INSERT INTO `sys_logininfor` VALUES (810, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 15:46:02');
INSERT INTO `sys_logininfor` VALUES (811, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 15:46:08');
INSERT INTO `sys_logininfor` VALUES (812, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 18:16:00');
INSERT INTO `sys_logininfor` VALUES (813, 'admin', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 18:30:17');
INSERT INTO `sys_logininfor` VALUES (814, 'admin', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 18:30:20');
INSERT INTO `sys_logininfor` VALUES (815, 'user', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 18:30:26');
INSERT INTO `sys_logininfor` VALUES (816, 'user', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 18:30:44');
INSERT INTO `sys_logininfor` VALUES (817, 'admin', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 18:30:52');
INSERT INTO `sys_logininfor` VALUES (818, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 18:33:52');
INSERT INTO `sys_logininfor` VALUES (819, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 18:33:57');
INSERT INTO `sys_logininfor` VALUES (820, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 18:44:05');
INSERT INTO `sys_logininfor` VALUES (821, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 18:44:27');
INSERT INTO `sys_logininfor` VALUES (822, 'ttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-07-23 19:09:58');
INSERT INTO `sys_logininfor` VALUES (823, 'ttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:10:11');
INSERT INTO `sys_logininfor` VALUES (824, 'ttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 19:13:46');
INSERT INTO `sys_logininfor` VALUES (825, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:13:50');
INSERT INTO `sys_logininfor` VALUES (826, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 19:15:31');
INSERT INTO `sys_logininfor` VALUES (827, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:15:38');
INSERT INTO `sys_logininfor` VALUES (828, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 19:19:08');
INSERT INTO `sys_logininfor` VALUES (829, 'ttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:19:17');
INSERT INTO `sys_logininfor` VALUES (830, 'user', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:26:21');
INSERT INTO `sys_logininfor` VALUES (831, 'user', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 19:43:05');
INSERT INTO `sys_logininfor` VALUES (832, 'user', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-23 19:43:14');
INSERT INTO `sys_logininfor` VALUES (833, 'admin', '111.15.84.227', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:43:32');
INSERT INTO `sys_logininfor` VALUES (834, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 19:59:22');
INSERT INTO `sys_logininfor` VALUES (835, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:03:55');
INSERT INTO `sys_logininfor` VALUES (836, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:04:02');
INSERT INTO `sys_logininfor` VALUES (837, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:13:05');
INSERT INTO `sys_logininfor` VALUES (838, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:13:11');
INSERT INTO `sys_logininfor` VALUES (839, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:16:43');
INSERT INTO `sys_logininfor` VALUES (840, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:16:48');
INSERT INTO `sys_logininfor` VALUES (841, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:32:25');
INSERT INTO `sys_logininfor` VALUES (842, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:33:12');
INSERT INTO `sys_logininfor` VALUES (843, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:43:00');
INSERT INTO `sys_logininfor` VALUES (844, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:43:09');
INSERT INTO `sys_logininfor` VALUES (845, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:43:14');
INSERT INTO `sys_logininfor` VALUES (846, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:43:19');
INSERT INTO `sys_logininfor` VALUES (847, '崔元帅', '111.15.80.30', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-07-23 20:45:24');
INSERT INTO `sys_logininfor` VALUES (848, '崔元帅', '111.15.80.30', 'XX XX', 'Chrome 11', 'Windows 10', '1', '验证码错误', '2023-07-23 20:45:28');
INSERT INTO `sys_logininfor` VALUES (849, '崔元帅', '111.15.80.30', 'XX XX', 'Chrome 11', 'Windows 10', '0', '登录成功', '2023-07-23 20:45:34');
INSERT INTO `sys_logininfor` VALUES (850, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:45:51');
INSERT INTO `sys_logininfor` VALUES (851, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:45:59');
INSERT INTO `sys_logininfor` VALUES (852, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:55:03');
INSERT INTO `sys_logininfor` VALUES (853, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:57:45');
INSERT INTO `sys_logininfor` VALUES (854, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:57:50');
INSERT INTO `sys_logininfor` VALUES (855, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-23 20:59:33');
INSERT INTO `sys_logininfor` VALUES (856, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-23 20:59:37');
INSERT INTO `sys_logininfor` VALUES (857, 'tttt', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-23 22:52:53');
INSERT INTO `sys_logininfor` VALUES (878, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-24 06:56:03');
INSERT INTO `sys_logininfor` VALUES (879, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 06:56:05');
INSERT INTO `sys_logininfor` VALUES (880, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 06:58:59');
INSERT INTO `sys_logininfor` VALUES (881, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 06:59:06');
INSERT INTO `sys_logininfor` VALUES (882, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:01:15');
INSERT INTO `sys_logininfor` VALUES (883, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:01:23');
INSERT INTO `sys_logininfor` VALUES (884, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:06:35');
INSERT INTO `sys_logininfor` VALUES (885, 'qqq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:09:15');
INSERT INTO `sys_logininfor` VALUES (886, 'qqq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:12:22');
INSERT INTO `sys_logininfor` VALUES (887, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:12:29');
INSERT INTO `sys_logininfor` VALUES (888, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:14:06');
INSERT INTO `sys_logininfor` VALUES (889, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:14:13');
INSERT INTO `sys_logininfor` VALUES (890, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:21:19');
INSERT INTO `sys_logininfor` VALUES (891, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:26:21');
INSERT INTO `sys_logininfor` VALUES (892, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码错误', '2023-07-24 07:26:27');
INSERT INTO `sys_logininfor` VALUES (893, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:26:30');
INSERT INTO `sys_logininfor` VALUES (894, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:27:55');
INSERT INTO `sys_logininfor` VALUES (895, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:28:02');
INSERT INTO `sys_logininfor` VALUES (896, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 07:29:59');
INSERT INTO `sys_logininfor` VALUES (897, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 07:37:51');
INSERT INTO `sys_logininfor` VALUES (898, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 08:03:19');
INSERT INTO `sys_logininfor` VALUES (899, 'qq', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 08:05:50');
INSERT INTO `sys_logininfor` VALUES (900, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 08:06:00');
INSERT INTO `sys_logininfor` VALUES (901, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 08:07:07');
INSERT INTO `sys_logininfor` VALUES (902, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 08:07:17');
INSERT INTO `sys_logininfor` VALUES (903, 'manager', '58.57.27.245', 'XX XX', 'Chrome 10', 'Windows 7', '0', '登录成功', '2023-07-24 08:18:55');
INSERT INTO `sys_logininfor` VALUES (904, 'manager', '58.57.27.245', 'XX XX', 'Chrome 10', 'Windows 7', '0', '退出成功', '2023-07-24 08:22:47');
INSERT INTO `sys_logininfor` VALUES (905, 'admin', '58.57.27.245', 'XX XX', 'Chrome 10', 'Windows 7', '0', '登录成功', '2023-07-24 08:23:16');
INSERT INTO `sys_logininfor` VALUES (906, 'user', '112.6.19.93', 'XX XX', 'Chrome 10', 'Windows 7', '0', '登录成功', '2023-07-24 08:25:22');
INSERT INTO `sys_logininfor` VALUES (907, 'aa', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '注册成功', '2023-07-24 08:27:57');
INSERT INTO `sys_logininfor` VALUES (908, 'aa', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 08:28:04');
INSERT INTO `sys_logininfor` VALUES (909, 'aa', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 08:30:39');
INSERT INTO `sys_logininfor` VALUES (910, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 08:30:45');
INSERT INTO `sys_logininfor` VALUES (911, 'manager', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-07-24 08:32:22');
INSERT INTO `sys_logininfor` VALUES (912, 'admin', '111.17.149.91', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-24 08:32:28');
INSERT INTO `sys_logininfor` VALUES (913, 'user', '39.144.106.191', 'XX XX', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2023-07-27 11:35:32');
INSERT INTO `sys_logininfor` VALUES (914, 'admin', '223.96.143.162', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-28 17:25:10');
INSERT INTO `sys_logininfor` VALUES (915, 'user', '223.96.142.64', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-07-29 22:53:43');
INSERT INTO `sys_logininfor` VALUES (916, 'user', '111.15.81.132', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-08-03 18:19:01');
INSERT INTO `sys_logininfor` VALUES (917, 'user', '111.15.81.132', 'XX XX', 'Chrome 9', 'Windows 10', '0', '退出成功', '2023-08-03 18:19:05');
INSERT INTO `sys_logininfor` VALUES (918, 'admin', '111.15.81.132', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-08-03 18:19:13');
INSERT INTO `sys_logininfor` VALUES (919, 'admin', '111.15.97.176', 'XX XX', 'Chrome 9', 'Windows 10', '1', '验证码已失效', '2023-08-10 02:04:56');
INSERT INTO `sys_logininfor` VALUES (920, 'admin', '111.15.97.176', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-08-10 02:04:59');
INSERT INTO `sys_logininfor` VALUES (921, 'admin', '111.15.97.126', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-08-11 14:45:09');
INSERT INTO `sys_logininfor` VALUES (922, 'admin', '111.15.80.134', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-08-13 22:26:18');
INSERT INTO `sys_logininfor` VALUES (923, 'admin', '111.15.96.132', 'XX XX', 'Chrome 9', 'Windows 10', '0', '登录成功', '2023-08-14 16:23:05');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int(11) NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(11) NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2051 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-26 17:13:32', '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2023-03-16 21:08:35', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '1', '1', '', 'tool', 'admin', '2023-03-16 21:08:35', 'admin', '2023-07-22 10:22:24', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 4, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '1', '1', '', 'guide', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-16 17:28:54', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '账号管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-30 11:19:26', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2023-03-16 21:08:35', '', NULL, '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2023-03-16 21:08:35', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '1', '1', 'system:dept:list', 'tree', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-16 20:00:55', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '1', '1', 'system:post:list', 'post', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-27 21:04:38', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2023-03-16 21:08:35', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2023-03-16 21:08:35', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2023-03-16 21:08:35', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2023-03-16 21:08:35', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2023-03-16 21:08:35', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2023-03-16 21:08:35', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2023-03-16 21:08:35', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2023-03-16 21:08:35', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2023-03-16 21:08:35', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2023-03-16 21:08:35', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2023-03-16 21:08:35', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2023-03-16 21:08:35', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2023-03-16 21:08:35', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2023-03-16 21:08:35', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2023-03-16 21:08:35', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '信息管理', 0, 0, 'wx', NULL, NULL, 1, 0, 'M', '0', '0', '', 'tree-table', 'admin', '2023-03-24 19:34:11', 'admin', '2023-05-05 17:21:33', '');
INSERT INTO `sys_menu` VALUES (2001, '地区管理', 2000, 1, 'area', 'wx/area/index', NULL, 1, 0, 'C', '0', '0', 'user:area:list', 'international', 'admin', '2023-03-26 16:12:17', 'admin', '2023-04-26 16:49:38', '');
INSERT INTO `sys_menu` VALUES (2002, '学校管理', 2000, 2, 'school', 'wx/school/index', NULL, 1, 0, 'C', '0', '0', 'user:school:list', 'build', 'admin', '2023-03-26 19:28:10', 'admin', '2023-04-26 16:49:55', '');
INSERT INTO `sys_menu` VALUES (2003, '学院管理', 2000, 3, 'department', 'wx/department/index', NULL, 1, 0, 'C', '0', '0', 'user:department:list', 'tree', 'admin', '2023-03-27 16:06:04', 'admin', '2023-04-26 16:49:47', '');
INSERT INTO `sys_menu` VALUES (2004, '院校专业管理', 2000, 5, 'major', 'wx/major/index', NULL, 1, 0, 'C', '0', '0', 'user:connect:list', 'job', 'admin', '2023-04-01 15:28:10', 'admin', '2023-04-26 16:50:11', '');
INSERT INTO `sys_menu` VALUES (2005, '复试线管理', 2000, 6, 'score', 'wx/score/index', NULL, 1, 0, 'C', '0', '0', 'user:score:list', 'education', 'admin', '2023-04-02 09:57:32', 'admin', '2023-04-26 16:50:22', '');
INSERT INTO `sys_menu` VALUES (2006, '国家线管理', 2000, 7, 'dscore', 'wx/dscore/index', NULL, 1, 0, 'C', '0', '0', 'user:dscore:list', 'tab', 'admin', '2023-04-16 18:43:10', 'admin', '2023-04-26 16:50:30', '');
INSERT INTO `sys_menu` VALUES (2007, '专业管理', 2000, 4, 'smajor', 'wx/smajor/index', NULL, 1, 0, 'C', '0', '0', 'user:major:list', 'rate', 'admin', '2023-04-23 13:03:19', 'admin', '2023-04-26 16:50:03', '');
INSERT INTO `sys_menu` VALUES (2008, '地区查询', 2001, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:area:query', '#', 'admin', '2023-04-24 22:51:03', 'admin', '2023-04-25 00:12:42', '');
INSERT INTO `sys_menu` VALUES (2009, '地区新增', 2001, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:area:add', '#', 'admin', '2023-04-25 00:14:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '地区修改', 2001, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:area:edit', '#', 'admin', '2023-04-25 00:15:21', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '地区删除', 2001, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:area:remove', '#', 'admin', '2023-04-25 00:16:44', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '学校查询', 2002, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:school:query', '#', 'admin', '2023-04-25 00:17:38', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '学校新增', 2002, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:school:add', '#', 'admin', '2023-04-25 00:18:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '学校修改', 2002, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:school:edit', '#', 'admin', '2023-04-25 00:18:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '学校删除', 2002, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:school:remove', '#', 'admin', '2023-04-25 08:44:27', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '学院查询', 2003, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:department:query', '#', 'admin', '2023-04-25 08:45:13', 'admin', '2023-04-25 08:46:20', '');
INSERT INTO `sys_menu` VALUES (2017, '学院新增', 2003, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:department:add', '#', 'admin', '2023-04-25 08:46:51', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '学院修改', 2003, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:department:edit', '#', 'admin', '2023-04-25 08:48:26', 'admin', '2023-04-29 16:13:48', '');
INSERT INTO `sys_menu` VALUES (2019, '学院删除', 2003, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:department:remove', '#', 'admin', '2023-04-25 08:49:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '专业查询', 2007, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:major:query', '#', 'admin', '2023-04-25 08:51:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '专业新增', 2007, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:major:add', '#', 'admin', '2023-04-25 08:54:25', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '专业修改', 2007, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:major:edit', '#', 'admin', '2023-04-25 08:55:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '专业删除', 2007, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:major:remove', '#', 'admin', '2023-04-25 08:56:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, '院校查询', 2004, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:connect:query', '#', 'admin', '2023-04-25 09:02:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '院校专业新增', 2004, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:connect:add', '#', 'admin', '2023-04-25 09:03:34', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '院校专业修改', 2004, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:connect:edit', '#', 'admin', '2023-04-25 09:03:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '院校专业删除', 2004, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:connect:remove', '#', 'admin', '2023-04-25 09:04:33', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '复试线查询', 2005, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:score:query', '#', 'admin', '2023-04-25 09:05:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '复试线新增', 2005, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:score:add', '#', 'admin', '2023-04-25 09:05:55', 'admin', '2023-04-25 09:06:03', '');
INSERT INTO `sys_menu` VALUES (2031, '复试线修改', 2005, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:score:edit', '#', 'admin', '2023-04-25 09:06:30', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '复试线删除', 2005, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:score:remove', '#', 'admin', '2023-04-25 09:06:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '国家线查询', 2006, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:dscore:list', '#', 'admin', '2023-04-25 09:07:53', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '国家线新增', 2006, 1, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:dscore:add', '#', 'admin', '2023-04-25 09:08:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '国家线修改', 2006, 2, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:dscore:edit', '#', 'admin', '2023-04-25 09:08:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '国家线删除', 2006, 3, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:dscore:remove', '#', 'admin', '2023-04-25 09:10:52', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2037, '调剂反馈', 0, 1, 'feedback', 'wx/feedback/index', NULL, 1, 0, 'C', '0', '0', '', 'textarea', 'admin', '2023-04-25 13:33:03', 'admin', '2023-04-30 11:18:03', '');
INSERT INTO `sys_menu` VALUES (2038, '反馈管理', 0, 1, 'feedbackList', 'wx/feedbackList/index', NULL, 1, 0, 'C', '0', '0', 'user:feedback:list', 'input', 'admin', '2023-04-25 22:21:41', 'admin', '2023-04-26 17:13:05', '');
INSERT INTO `sys_menu` VALUES (2039, '考研信息', 0, 0, 'wx_user', NULL, NULL, 1, 0, 'M', '0', '0', '', 'list', 'admin', '2023-04-26 10:16:00', 'admin', '2023-04-26 10:25:49', '');
INSERT INTO `sys_menu` VALUES (2040, '地区', 2039, 0, 'area', 'wx_user/area/index', NULL, 1, 0, 'C', '0', '0', 'user:area:list', 'international', 'admin', '2023-04-26 10:17:22', 'admin', '2023-04-26 10:27:31', '');
INSERT INTO `sys_menu` VALUES (2041, '学校', 2039, 1, 'school', 'wx_user/school/index', NULL, 1, 0, 'C', '0', '0', 'user:school:list', 'build', 'admin', '2023-04-26 10:32:23', 'admin', '2023-04-26 10:39:35', '');
INSERT INTO `sys_menu` VALUES (2042, '学院', 2039, 2, 'department', 'wx_user/department/index', NULL, 1, 0, 'C', '0', '0', 'user:department:list', 'tree', 'admin', '2023-04-26 10:33:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2043, '专业', 2039, 3, 'smajor', 'wx_user/smajor/index', NULL, 1, 0, 'C', '0', '0', 'user:major:list', 'rate', 'admin', '2023-04-26 10:45:35', 'admin', '2023-04-26 10:47:35', '');
INSERT INTO `sys_menu` VALUES (2044, '院校专业', 2039, 3, 'major', 'wx_user/major/index', NULL, 1, 0, 'C', '0', '0', 'user:major:list', 'job', 'admin', '2023-04-26 10:55:05', 'admin', '2023-04-26 10:55:29', '');
INSERT INTO `sys_menu` VALUES (2046, '复试线', 2039, 5, 'score', 'wx_user/score/index', NULL, 1, 0, 'C', '0', '0', 'user:score:list', 'education', 'admin', '2023-04-26 10:59:52', 'admin', '2023-04-26 11:00:26', '');
INSERT INTO `sys_menu` VALUES (2047, '国家线', 2039, 6, 'dscore', 'wx_user/dscore/index', NULL, 1, 0, 'C', '0', '0', 'user:dscore:list', 'monitor', 'admin', '2023-04-26 11:07:51', 'admin', '2023-04-26 11:09:25', '');
INSERT INTO `sys_menu` VALUES (2048, '删除反馈', 2038, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:feedback:remove', '#', 'admin', '2023-04-29 16:16:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2049, '考研新增', 2037, 0, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:feedback:add', '#', 'admin', '2023-04-29 16:27:01', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2050, '复试线导出', 2005, 4, '', NULL, NULL, 1, 0, 'F', '0', '0', 'user:score:export', '#', 'admin', '2023-07-23 14:39:28', '', NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2023-03-16 21:08:36', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2023-03-16 21:08:36', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int(11) NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int(11) NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int(11) NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint(20) NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type`) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status`) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1, '操作日志', 9, 'com.ruoyi.web.controller.monitor.SysOperlogController.clean()', 'DELETE', 1, 'admin', NULL, '/monitor/operlog/clean', '111.15.80.80', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 15:07:28', 14);
INSERT INTO `sys_oper_log` VALUES (2, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 15:43:35', 63);
INSERT INTO `sys_oper_log` VALUES (5, '操作日志', 3, 'com.ruoyi.web.controller.monitor.SysOperlogController.remove()', 'DELETE', 1, 'admin', NULL, '/monitor/operlog/3,4', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 15:47:25', 7);
INSERT INTO `sys_oper_log` VALUES (6, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"阿喇哈\",\"areaType\":1,\"params\":{}}', NULL, 1, '\n### Error updating database.  Cause: java.sql.SQLException: Field \'area_id\' doesn\'t have a default value\n### The error may exist in URL [jar:file:/www/wwwroot/springboot/ruoyi-admin.jar!/BOOT-INF/lib/ruoyi-user-3.8.5.jar!/mapper/user/AreaMapper.xml]\n### The error may involve com.ruoyi.user.mapper.AreaMapper.insertWxArea-Inline\n### The error occurred while setting parameters\n### SQL: insert into wx_area          ( area_name,             area_type )           values ( ?,             ? )\n### Cause: java.sql.SQLException: Field \'area_id\' doesn\'t have a default value\n; Field \'area_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'area_id\' doesn\'t have a default value', '2023-07-23 18:35:09', 11);
INSERT INTO `sys_oper_log` VALUES (7, '修改地区信息', 2, 'com.ruoyi.user.controller.AreaController.edit()', 'PUT', 1, 'admin', NULL, '/user/area', '111.15.84.227', 'XX XX', '{\"areaId\":1,\"areaName\":\"北京\",\"areaType\":2,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 18:35:58', 7);
INSERT INTO `sys_oper_log` VALUES (8, '修改地区信息', 2, 'com.ruoyi.user.controller.AreaController.edit()', 'PUT', 1, 'admin', NULL, '/user/area', '111.15.84.227', 'XX XX', '{\"areaId\":1,\"areaName\":\"北京\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 18:36:02', 8);
INSERT INTO `sys_oper_log` VALUES (9, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'admin', NULL, '/user/area', '111.15.84.227', 'XX XX', '{\"areaName\":\"日本\",\"areaType\":1,\"params\":{}}', NULL, 1, '\n### Error updating database.  Cause: java.sql.SQLException: Field \'area_id\' doesn\'t have a default value\n### The error may exist in URL [jar:file:/www/wwwroot/springboot/ruoyi-admin.jar!/BOOT-INF/lib/ruoyi-user-3.8.5.jar!/mapper/user/AreaMapper.xml]\n### The error may involve com.ruoyi.user.mapper.AreaMapper.insertWxArea-Inline\n### The error occurred while setting parameters\n### SQL: insert into wx_area          ( area_name,             area_type )           values ( ?,             ? )\n### Cause: java.sql.SQLException: Field \'area_id\' doesn\'t have a default value\n; Field \'area_id\' doesn\'t have a default value; nested exception is java.sql.SQLException: Field \'area_id\' doesn\'t have a default value', '2023-07-23 18:36:17', 3);
INSERT INTO `sys_oper_log` VALUES (10, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"阿喇哈\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 18:37:58', 6);
INSERT INTO `sys_oper_log` VALUES (11, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/32', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 18:38:04', 8);
INSERT INTO `sys_oper_log` VALUES (12, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 18:43:14', 32);
INSERT INTO `sys_oper_log` VALUES (13, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.changeStatus()', 'PUT', 1, 'admin', NULL, '/system/user/changeStatus', '111.17.149.91', 'XX XX', '{\"admin\":true,\"params\":{},\"status\":\"1\",\"userId\":1}', NULL, 1, '不允许操作超级管理员用户', '2023-07-23 18:47:37', 1);
INSERT INTO `sys_oper_log` VALUES (14, '在线用户', 7, 'com.ruoyi.web.controller.monitor.SysUserOnlineController.forceLogout()', 'DELETE', 1, 'admin', NULL, '/monitor/online/ca25c627-7602-43bf-bcc0-1363a634e67b', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 18:47:56', 0);
INSERT INTO `sys_oper_log` VALUES (15, '在线用户', 7, 'com.ruoyi.web.controller.monitor.SysUserOnlineController.forceLogout()', 'DELETE', 1, 'admin', NULL, '/monitor/online/5e1dcaea-0599-4493-85f2-533d77d679c2', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 18:48:04', 1);
INSERT INTO `sys_oper_log` VALUES (16, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"台湾\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 19:14:14', 6);
INSERT INTO `sys_oper_log` VALUES (17, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/33', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 19:14:18', 5);
INSERT INTO `sys_oper_log` VALUES (18, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 19:14:34', 62);
INSERT INTO `sys_oper_log` VALUES (19, '删除复试线信息', 3, 'com.ruoyi.user.controller.ScoreController.remove()', 'DELETE', 1, 'manager', NULL, '/user/score/130', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 19:15:14', 6);
INSERT INTO `sys_oper_log` VALUES (20, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"wwwv\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 20:04:38', 6);
INSERT INTO `sys_oper_log` VALUES (21, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/34', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 20:04:44', 517);
INSERT INTO `sys_oper_log` VALUES (22, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 20:08:57', 27);
INSERT INTO `sys_oper_log` VALUES (23, '删除复试线信息', 3, 'com.ruoyi.user.controller.ScoreController.remove()', 'DELETE', 1, 'manager', NULL, '/user/score/131', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 20:11:40', 6);
INSERT INTO `sys_oper_log` VALUES (24, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 20:16:53', 31);
INSERT INTO `sys_oper_log` VALUES (25, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"台湾\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 20:58:11', 6);
INSERT INTO `sys_oper_log` VALUES (26, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/35', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 20:58:15', 6);
INSERT INTO `sys_oper_log` VALUES (27, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 20:58:38', 25);
INSERT INTO `sys_oper_log` VALUES (28, '删除复试线信息', 3, 'com.ruoyi.user.controller.ScoreController.remove()', 'DELETE', 1, 'manager', NULL, '/user/score/132', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 20:59:16', 6);
INSERT INTO `sys_oper_log` VALUES (29, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"台湾\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 22:56:57', 6);
INSERT INTO `sys_oper_log` VALUES (30, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/36', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-23 22:57:01', 6);
INSERT INTO `sys_oper_log` VALUES (31, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-23 22:57:33', 26);
INSERT INTO `sys_oper_log` VALUES (36, '操作日志', 3, 'com.ruoyi.web.controller.monitor.SysOperlogController.remove()', 'DELETE', 1, 'admin', NULL, '/monitor/operlog/35,34,33', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 00:21:23', 6);
INSERT INTO `sys_oper_log` VALUES (37, '登录日志', 3, 'com.ruoyi.web.controller.monitor.SysLogininforController.remove()', 'DELETE', 1, 'admin', NULL, '/monitor/logininfor/877,876,875,874,873,872,871,870,869,868', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 00:21:53', 6);
INSERT INTO `sys_oper_log` VALUES (38, '登录日志', 3, 'com.ruoyi.web.controller.monitor.SysLogininforController.remove()', 'DELETE', 1, 'admin', NULL, '/monitor/logininfor/867,866,865,864,863,862,861,860,859,858', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 00:22:03', 6);
INSERT INTO `sys_oper_log` VALUES (39, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"台湾\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 06:59:33', 6);
INSERT INTO `sys_oper_log` VALUES (40, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/37', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 06:59:37', 6);
INSERT INTO `sys_oper_log` VALUES (41, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-24 06:59:55', 28);
INSERT INTO `sys_oper_log` VALUES (42, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-24 07:13:14', 22);
INSERT INTO `sys_oper_log` VALUES (43, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-24 07:27:08', 21);
INSERT INTO `sys_oper_log` VALUES (44, '新增地区信息', 1, 'com.ruoyi.user.controller.AreaController.add()', 'POST', 1, 'manager', NULL, '/user/area', '111.17.149.91', 'XX XX', '{\"areaName\":\"台湾\",\"areaType\":1,\"params\":{}}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 08:31:03', 6);
INSERT INTO `sys_oper_log` VALUES (45, '删除地区信息', 3, 'com.ruoyi.user.controller.AreaController.remove()', 'DELETE', 1, 'manager', NULL, '/user/area/38', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 08:31:07', 6);
INSERT INTO `sys_oper_log` VALUES (46, '导出复试线列表', 5, 'com.ruoyi.user.controller.ScoreController.export()', 'POST', 1, 'manager', NULL, '/user/score/export', '111.17.149.91', 'XX XX', '{\"pageSize\":\"10\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2023-07-24 08:31:30', 48);
INSERT INTO `sys_oper_log` VALUES (47, '删除复试线信息', 3, 'com.ruoyi.user.controller.ScoreController.remove()', 'DELETE', 1, 'manager', NULL, '/user/score/133', '111.17.149.91', 'XX XX', '{}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-07-24 08:32:03', 6);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int(11) NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2023-03-16 21:08:35', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2023-03-16 21:08:35', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 101 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2023-03-16 21:08:35', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通用户', 'common', 2, '2', 1, 1, '0', '0', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-29 16:27:18', '普通角色');
INSERT INTO `sys_role` VALUES (100, '管理员', 'ordinaryAdministrator', 0, '1', 1, 1, '0', '0', 'admin', '2023-04-14 19:12:32', 'admin', '2023-07-23 14:39:50', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 2037);
INSERT INTO `sys_role_menu` VALUES (2, 2039);
INSERT INTO `sys_role_menu` VALUES (2, 2040);
INSERT INTO `sys_role_menu` VALUES (2, 2041);
INSERT INTO `sys_role_menu` VALUES (2, 2042);
INSERT INTO `sys_role_menu` VALUES (2, 2043);
INSERT INTO `sys_role_menu` VALUES (2, 2044);
INSERT INTO `sys_role_menu` VALUES (2, 2046);
INSERT INTO `sys_role_menu` VALUES (2, 2047);
INSERT INTO `sys_role_menu` VALUES (2, 2049);
INSERT INTO `sys_role_menu` VALUES (100, 2000);
INSERT INTO `sys_role_menu` VALUES (100, 2001);
INSERT INTO `sys_role_menu` VALUES (100, 2002);
INSERT INTO `sys_role_menu` VALUES (100, 2003);
INSERT INTO `sys_role_menu` VALUES (100, 2004);
INSERT INTO `sys_role_menu` VALUES (100, 2005);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2009);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2011);
INSERT INTO `sys_role_menu` VALUES (100, 2012);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2016);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2025);
INSERT INTO `sys_role_menu` VALUES (100, 2026);
INSERT INTO `sys_role_menu` VALUES (100, 2027);
INSERT INTO `sys_role_menu` VALUES (100, 2028);
INSERT INTO `sys_role_menu` VALUES (100, 2029);
INSERT INTO `sys_role_menu` VALUES (100, 2030);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (100, 2032);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2036);
INSERT INTO `sys_role_menu` VALUES (100, 2038);
INSERT INTO `sys_role_menu` VALUES (100, 2048);
INSERT INTO `sys_role_menu` VALUES (100, 2050);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 122 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '/profile/avatar/2023/05/07/blob_20230507101840A005.png', '$2a$10$cdNWSMCVr.74RJDIOyE.9eZb3N8fCeNJ8FaTO/Ki77SZQeQSBQkKi', '0', '0', '111.15.96.132', '2023-08-14 16:23:06', 'admin', '2023-03-16 21:08:35', '', '2023-08-14 16:23:05', '管理员');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2023-03-16 21:08:35', 'admin', '2023-03-16 21:08:35', 'admin', '2023-04-27 21:09:36', '测试员');
INSERT INTO `sys_user` VALUES (100, NULL, '崔元帅', '崔元帅', '00', '1356462151@qq.com', '15552782536', '0', '', '$2a$10$vvSa2vmaC0yZ9vtTwSat8O0nYhYrADYg9q9fDfxW7XUK04QuVeRz2', '0', '0', '111.15.80.30', '2023-07-23 20:45:35', '', '2023-04-14 18:36:38', 'admin', '2023-07-23 20:45:34', NULL);
INSERT INTO `sys_user` VALUES (101, NULL, '赵若彤', '赵若彤', '00', '', '', '0', '', '$2a$10$WK8LbvAWHQRpDjhNY5RpJ.79nwawHu/4LvMsemOxQC2uJheeiA4zO', '0', '0', '111.15.84.164', '2023-05-05 17:50:26', '', '2023-04-14 18:36:58', 'admin', '2023-05-05 17:50:25', NULL);
INSERT INTO `sys_user` VALUES (102, NULL, '栾吉宁', '栾吉宁', '00', '', '', '0', '', '$2a$10$1Uwsi.U05sSxDnXhJlJsceF8gLtvLrgfH.vJ/FSMu4tw/bG3qjEre', '0', '0', '127.0.0.1', '2023-04-26 16:29:03', '', '2023-04-26 16:28:47', '', '2023-04-26 16:29:02', NULL);
INSERT INTO `sys_user` VALUES (103, NULL, '123456', '123456', '00', '', '', '0', '', '$2a$10$FBdxA6.tzp8aNNiqKBKoneQvwXNZh47GA3Vptl1degAXVtDT5TS1.', '0', '0', '127.0.0.1', '2023-04-26 21:19:31', '', '2023-04-26 20:36:41', 'admin', '2023-05-05 17:08:00', NULL);
INSERT INTO `sys_user` VALUES (104, NULL, 'xckhh', 'xckhh', '00', '', '', '0', '', '$2a$10$MgWzqlXtCQZF6tH1p6CVg.pRFliJW/AfXDUVIH5RQXKkBR9/8j.w6', '0', '0', '127.0.0.1', '2023-07-13 21:48:03', '', '2023-04-26 20:41:25', '', '2023-07-13 21:48:03', NULL);
INSERT INTO `sys_user` VALUES (105, NULL, '777', '777', '00', '', '', '0', '', '$2a$10$m0u0rP2dy7MBMJICfWwG8eS4LSihzlpDw9h8cQWsc1n3ui1hQta1u', '0', '0', '127.0.0.1', '2023-04-26 23:24:34', '', '2023-04-26 23:24:24', '', '2023-04-26 23:24:33', NULL);
INSERT INTO `sys_user` VALUES (106, NULL, '999', '999', '00', '', '', '0', '', '$2a$10$9Ubh03zzG876O6F4AmCjF.7mCPeh8NoJoruBliPKscAJwCDUg.M0O', '0', '0', '127.0.0.1', '2023-04-26 23:30:31', '', '2023-04-26 23:30:21', '', '2023-04-26 23:30:31', NULL);
INSERT INTO `sys_user` VALUES (107, NULL, '123', '123', '00', '', '', '0', '', '$2a$10$lAmBHa4eTfqVJSNuvM4RzOvOArCMJgokXMkBOjQ7Y1mTx.voYh2v6', '0', '0', '111.15.84.164', '2023-05-05 17:08:45', '', '2023-05-03 18:19:04', 'admin', '2023-05-05 17:08:44', NULL);
INSERT INTO `sys_user` VALUES (108, NULL, 'user', 'user', '00', '1711953919@qq.com', '19558960558', '0', '/profile/avatar/2023/05/07/blob_20230507101642A003.png', '$2a$10$q3RSWqgbgByjXVP59y7pFOSpTz8zXEawTyGZQ8Y55r7XkiCBax3zm', '0', '0', '111.15.81.132', '2023-08-03 18:19:02', '', '2023-05-05 17:15:06', '', '2023-08-03 18:19:01', NULL);
INSERT INTO `sys_user` VALUES (109, NULL, 'manager', 'manager', '00', '', '', '0', '/profile/avatar/2023/05/07/blob_20230507101759A004.png', '$2a$10$uLjdjBShtN4GX61ddjLBB.x/4NY1WHpZLc0dJv3lddzlvP8hbB6oy', '0', '0', '111.17.149.91', '2023-07-24 08:30:45', '', '2023-05-05 17:16:36', 'admin', '2023-07-24 08:30:45', NULL);
INSERT INTO `sys_user` VALUES (110, NULL, 'qqq', 'qqq', '00', '', '', '0', '', '$2a$10$pR32APZQJid2jQlmHJP3mu3kQtNQNwDTQz3Iq6TPe1SqI3DcSlka6', '0', '0', '111.17.149.91', '2023-07-24 07:09:16', '', '2023-05-05 20:59:01', '', '2023-07-24 07:09:15', NULL);
INSERT INTO `sys_user` VALUES (111, NULL, 'www', 'www', '00', '', '', '0', '', '$2a$10$Pp2xP1PCdYvqqmiZklKPU.LqNowQDefGY9IXa5hijRhdEA5pZ/nAC', '0', '0', '111.15.84.164', '2023-05-05 21:14:23', '', '2023-05-05 21:14:12', '', '2023-05-05 21:14:22', NULL);
INSERT INTO `sys_user` VALUES (112, NULL, '1233456', '1233456', '00', '', '', '0', '', '$2a$10$nSL3yCsVoEzZr3iZrpmvCOBCTfE9qfctfXkKH9tyLt39T5XGNzC.C', '0', '0', '112.6.19.93', '2023-05-06 13:38:51', '', '2023-05-05 22:56:11', '', '2023-05-06 13:38:50', NULL);
INSERT INTO `sys_user` VALUES (113, NULL, 'sss', 'sss', '00', '', '', '0', '', '$2a$10$fCnMFgdgnJWUJAGlRkm6qOwGGgih9BQt0Bs863TpeMHZrYsY/AiLy', '0', '0', '111.15.97.230', '2023-05-08 23:52:05', '', '2023-05-08 23:51:48', '', '2023-05-08 23:52:04', NULL);
INSERT INTO `sys_user` VALUES (114, NULL, '111', '111', '00', '', '', '0', '', '$2a$10$c87TqHKhKqoEzgr6kVHuhOlbivDknZ9c7hJCVFrnapMXZEBZXUu6q', '0', '0', '111.15.97.230', '2023-05-08 23:53:47', '', '2023-05-08 23:53:29', '', '2023-05-08 23:53:47', NULL);
INSERT INTO `sys_user` VALUES (115, NULL, '222', '222', '00', '', '', '0', '', '$2a$10$yB3dPkDzWgirAD4DUNVmSeAL9jE31C2VULVe4Nx3iojF1d/IlXHH6', '0', '0', '111.15.97.230', '2023-05-09 00:09:38', '', '2023-05-08 23:56:35', '', '2023-05-09 00:09:38', NULL);
INSERT INTO `sys_user` VALUES (116, NULL, 'aaa', 'aaa', '00', '', '', '0', '', '$2a$10$/ED40vZdcDxNBl8H8ans6.WPY0X5Ng7rDqEE3t31n6TG5Ler8Fqrm', '0', '0', '111.17.149.91', '2023-07-23 09:21:20', '', '2023-07-23 09:21:03', '', '2023-07-23 09:21:20', NULL);
INSERT INTO `sys_user` VALUES (117, NULL, 'tt', 'tt', '00', '', '', '0', '', '$2a$10$OrBJzH3sURE5v8DPkoi0XOPgLSSz4ha0jrDLuR4XQHzDVlmJTc5Uy', '0', '0', '111.17.149.91', '2023-07-23 10:34:40', '', '2023-07-23 10:34:26', '', '2023-07-23 10:34:39', NULL);
INSERT INTO `sys_user` VALUES (118, NULL, 'tttt', 'tttt', '00', '', '', '0', '', '$2a$10$KsmFn21jw2zFgOInw8Eav.xzeiAvlO1plATMQ98mc9NZdTbziYMGe', '0', '0', '111.17.149.91', '2023-07-23 22:52:56', '', '2023-07-23 14:25:03', '', '2023-07-23 22:52:55', NULL);
INSERT INTO `sys_user` VALUES (119, NULL, 'ttt', 'ttt', '00', '', '', '0', '', '$2a$10$m.OP8BIab.3SEdGpSxC8nuJbKEo.1HbBn.pWQgqrcUjVKNF0hMrM.', '0', '0', '111.17.149.91', '2023-07-23 19:19:18', '', '2023-07-23 19:09:58', '', '2023-07-23 19:19:17', NULL);
INSERT INTO `sys_user` VALUES (120, NULL, 'qq', 'qq', '00', '', '', '0', '', '$2a$10$VkJ3inNaeZtvDewb9.IjD.ixX/q9bu921qqRrG26a8voGnn.I/3CK', '0', '0', '111.17.149.91', '2023-07-24 08:03:19', '', '2023-07-24 00:06:14', '', '2023-07-24 08:03:19', NULL);
INSERT INTO `sys_user` VALUES (121, NULL, 'aa', 'aa', '00', '', '', '0', '', '$2a$10$qROkLjuDsi4gs7oaFq1AOO6WRNF92IsHGgKkB5Py5btcV6zNDfa7q', '0', '0', '111.17.149.91', '2023-07-24 08:28:05', '', '2023-07-24 08:27:57', '', '2023-07-24 08:28:04', NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 2);
INSERT INTO `sys_user_role` VALUES (101, 100);
INSERT INTO `sys_user_role` VALUES (102, 2);
INSERT INTO `sys_user_role` VALUES (103, 100);
INSERT INTO `sys_user_role` VALUES (104, 2);
INSERT INTO `sys_user_role` VALUES (105, 2);
INSERT INTO `sys_user_role` VALUES (106, 2);
INSERT INTO `sys_user_role` VALUES (107, 2);
INSERT INTO `sys_user_role` VALUES (108, 2);
INSERT INTO `sys_user_role` VALUES (109, 100);
INSERT INTO `sys_user_role` VALUES (110, 2);
INSERT INTO `sys_user_role` VALUES (111, 2);
INSERT INTO `sys_user_role` VALUES (112, 2);
INSERT INTO `sys_user_role` VALUES (113, 2);
INSERT INTO `sys_user_role` VALUES (114, 2);
INSERT INTO `sys_user_role` VALUES (115, 2);
INSERT INTO `sys_user_role` VALUES (116, 2);
INSERT INTO `sys_user_role` VALUES (117, 2);
INSERT INTO `sys_user_role` VALUES (118, 2);
INSERT INTO `sys_user_role` VALUES (119, 2);
INSERT INTO `sys_user_role` VALUES (120, 2);
INSERT INTO `sys_user_role` VALUES (121, 2);

-- ----------------------------
-- Table structure for wx_area
-- ----------------------------
DROP TABLE IF EXISTS `wx_area`;
CREATE TABLE `wx_area`  (
  `area_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '地区主键',
  `area_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地区名称',
  `area_type` int(11) NOT NULL COMMENT '判断该地区是一区还是二区',
  PRIMARY KEY (`area_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wx_area
-- ----------------------------
INSERT INTO `wx_area` VALUES (1, '北京', 1);
INSERT INTO `wx_area` VALUES (2, '天津', 1);
INSERT INTO `wx_area` VALUES (3, '河北', 1);
INSERT INTO `wx_area` VALUES (4, '山西', 1);
INSERT INTO `wx_area` VALUES (5, '辽宁', 1);
INSERT INTO `wx_area` VALUES (6, '吉林', 1);
INSERT INTO `wx_area` VALUES (7, '黑龙江', 1);
INSERT INTO `wx_area` VALUES (8, '上海', 1);
INSERT INTO `wx_area` VALUES (9, '江苏', 1);
INSERT INTO `wx_area` VALUES (10, '浙江', 1);
INSERT INTO `wx_area` VALUES (11, '安徽', 1);
INSERT INTO `wx_area` VALUES (12, '福建', 1);
INSERT INTO `wx_area` VALUES (13, '江西', 1);
INSERT INTO `wx_area` VALUES (14, '山东', 1);
INSERT INTO `wx_area` VALUES (15, '河南', 1);
INSERT INTO `wx_area` VALUES (16, '湖北', 1);
INSERT INTO `wx_area` VALUES (17, '湖南', 1);
INSERT INTO `wx_area` VALUES (18, '广东', 1);
INSERT INTO `wx_area` VALUES (19, '重庆', 1);
INSERT INTO `wx_area` VALUES (20, '四川', 1);
INSERT INTO `wx_area` VALUES (21, '陕西', 1);
INSERT INTO `wx_area` VALUES (22, '内蒙古', 2);
INSERT INTO `wx_area` VALUES (23, '广西', 2);
INSERT INTO `wx_area` VALUES (24, '海南', 2);
INSERT INTO `wx_area` VALUES (25, '贵州', 2);
INSERT INTO `wx_area` VALUES (26, '云南', 2);
INSERT INTO `wx_area` VALUES (27, '西藏', 2);
INSERT INTO `wx_area` VALUES (28, '甘肃', 2);
INSERT INTO `wx_area` VALUES (29, '青海', 2);
INSERT INTO `wx_area` VALUES (30, '宁夏', 2);
INSERT INTO `wx_area` VALUES (31, '新疆', 2);

-- ----------------------------
-- Table structure for wx_department
-- ----------------------------
DROP TABLE IF EXISTS `wx_department`;
CREATE TABLE `wx_department`  (
  `department_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '院系编号',
  `department_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '院系名称',
  `department_school_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '院系所在的学校',
  PRIMARY KEY (`department_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wx_department
-- ----------------------------
INSERT INTO `wx_department` VALUES (1, '五道口金融学院', '1');
INSERT INTO `wx_department` VALUES (2, '经济与管理学院', '2');
INSERT INTO `wx_department` VALUES (3, '经济学院', '3');
INSERT INTO `wx_department` VALUES (4, '经济与管理学院', '4');
INSERT INTO `wx_department` VALUES (5, '商学院', '5');
INSERT INTO `wx_department` VALUES (6, '经济学院', '6');
INSERT INTO `wx_department` VALUES (7, '经济管理学院', '7');
INSERT INTO `wx_department` VALUES (8, '商学院', '8');
INSERT INTO `wx_department` VALUES (9, '经济学院', '9');
INSERT INTO `wx_department` VALUES (10, '金融学院', '10');
INSERT INTO `wx_department` VALUES (11, '信息科学技术学院', '1');
INSERT INTO `wx_department` VALUES (12, '计算机科学与技术学院', '2');
INSERT INTO `wx_department` VALUES (13, '信息科学与工程学院', '3');
INSERT INTO `wx_department` VALUES (14, '计算机学院', '4');
INSERT INTO `wx_department` VALUES (15, '计算机科学与技术学院', '5');
INSERT INTO `wx_department` VALUES (16, '信息学院', '6');
INSERT INTO `wx_department` VALUES (17, '信息学院', '7');
INSERT INTO `wx_department` VALUES (18, '计算机学院', '8');
INSERT INTO `wx_department` VALUES (19, '计算机科学技术学院', '9');
INSERT INTO `wx_department` VALUES (20, '信息学院', '10');
INSERT INTO `wx_department` VALUES (21, '人文学院', '1');
INSERT INTO `wx_department` VALUES (22, '马克思主义学院', '2');
INSERT INTO `wx_department` VALUES (23, '马克思主义学院', '3');
INSERT INTO `wx_department` VALUES (24, '哲学学院', '4');
INSERT INTO `wx_department` VALUES (25, '政治与公共管理学院', '5');
INSERT INTO `wx_department` VALUES (26, '公共管理学院', '6');
INSERT INTO `wx_department` VALUES (27, '马克思主义学院', '7');
INSERT INTO `wx_department` VALUES (28, '马克思主义学院', '8');
INSERT INTO `wx_department` VALUES (29, '马克思主义学院', '9');
INSERT INTO `wx_department` VALUES (30, '马克思主义学院', '10');
INSERT INTO `wx_department` VALUES (31, '新闻与传播学院', '1');
INSERT INTO `wx_department` VALUES (32, '人文社科与法学学院', '2');
INSERT INTO `wx_department` VALUES (33, '新闻与传播学院', '3');
INSERT INTO `wx_department` VALUES (34, '新闻与传播学院', '4');
INSERT INTO `wx_department` VALUES (35, '传媒学院', '5');
INSERT INTO `wx_department` VALUES (36, '新闻学院', '6');
INSERT INTO `wx_department` VALUES (37, '信息学院', '7');
INSERT INTO `wx_department` VALUES (38, '文学与新闻学院', '8');
INSERT INTO `wx_department` VALUES (39, '文学与新闻传播学院', '9');
INSERT INTO `wx_department` VALUES (40, '文学院', '10');

-- ----------------------------
-- Table structure for wx_dscore
-- ----------------------------
DROP TABLE IF EXISTS `wx_dscore`;
CREATE TABLE `wx_dscore`  (
  `score_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分数编号',
  `score_year` int(11) NOT NULL COMMENT '考研年份',
  `score_all` int(11) NOT NULL COMMENT '复试线',
  `score_math` int(11) NOT NULL COMMENT '专业一',
  `score_english` int(11) NOT NULL COMMENT '英语线',
  `score_politics` int(11) NOT NULL COMMENT '政治线',
  `score_major` int(11) NOT NULL COMMENT '专业线',
  `major_id` int(11) NOT NULL COMMENT '专业编号',
  `area_type` int(11) NOT NULL COMMENT '地区类型',
  PRIMARY KEY (`score_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wx_dscore
-- ----------------------------
INSERT INTO `wx_dscore` VALUES (1, 2021, 348, 74, 49, 49, 74, 1, 1);
INSERT INTO `wx_dscore` VALUES (2, 2021, 338, 69, 46, 46, 69, 1, 2);
INSERT INTO `wx_dscore` VALUES (3, 2022, 360, 78, 52, 52, 78, 1, 1);
INSERT INTO `wx_dscore` VALUES (4, 2022, 350, 74, 49, 49, 74, 1, 2);
INSERT INTO `wx_dscore` VALUES (5, 2023, 346, 72, 48, 48, 72, 1, 1);
INSERT INTO `wx_dscore` VALUES (6, 2023, 336, 68, 45, 45, 68, 1, 2);
INSERT INTO `wx_dscore` VALUES (7, 2021, 263, 56, 37, 37, 56, 2, 1);
INSERT INTO `wx_dscore` VALUES (8, 2021, 253, 51, 34, 34, 51, 2, 2);
INSERT INTO `wx_dscore` VALUES (9, 2022, 273, 57, 38, 38, 57, 2, 1);
INSERT INTO `wx_dscore` VALUES (10, 2022, 263, 53, 35, 35, 53, 2, 2);
INSERT INTO `wx_dscore` VALUES (11, 2023, 273, 57, 38, 38, 57, 2, 1);
INSERT INTO `wx_dscore` VALUES (12, 2023, 263, 53, 35, 35, 53, 2, 2);
INSERT INTO `wx_dscore` VALUES (13, 2021, 299, 62, 41, 41, 62, 3, 1);
INSERT INTO `wx_dscore` VALUES (14, 2021, 289, 57, 38, 38, 57, 3, 2);
INSERT INTO `wx_dscore` VALUES (15, 2022, 314, 68, 45, 45, 68, 3, 1);
INSERT INTO `wx_dscore` VALUES (16, 2022, 304, 63, 42, 42, 63, 3, 2);
INSERT INTO `wx_dscore` VALUES (17, 2023, 323, 68, 45, 45, 68, 3, 1);
INSERT INTO `wx_dscore` VALUES (18, 2023, 313, 63, 42, 42, 63, 3, 2);
INSERT INTO `wx_dscore` VALUES (19, 2021, 355, 80, 53, 53, 80, 4, 1);
INSERT INTO `wx_dscore` VALUES (20, 2021, 345, 75, 50, 50, 75, 4, 2);
INSERT INTO `wx_dscore` VALUES (21, 2022, 367, 84, 56, 56, 84, 4, 1);
INSERT INTO `wx_dscore` VALUES (22, 2022, 357, 80, 53, 53, 80, 4, 2);
INSERT INTO `wx_dscore` VALUES (23, 2023, 363, 81, 54, 54, 81, 4, 1);
INSERT INTO `wx_dscore` VALUES (24, 2023, 353, 77, 51, 51, 77, 4, 2);

-- ----------------------------
-- Table structure for wx_feedback
-- ----------------------------
DROP TABLE IF EXISTS `wx_feedback`;
CREATE TABLE `wx_feedback`  (
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `satisfaction` int(11) NOT NULL COMMENT '满意程度',
  `action` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调剂情况',
  `suggest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '您的建议',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wx_feedback
-- ----------------------------
INSERT INTO `wx_feedback` VALUES (104, 5, '调剂成功', '满意');
INSERT INTO `wx_feedback` VALUES (106, 4, '无', '满意');
INSERT INTO `wx_feedback` VALUES (108, 5, '挺好的', '加油');
INSERT INTO `wx_feedback` VALUES (118, 5, '好', '可以');
INSERT INTO `wx_feedback` VALUES (121, 5, '好', '好');

-- ----------------------------
-- Table structure for wx_major
-- ----------------------------
DROP TABLE IF EXISTS `wx_major`;
CREATE TABLE `wx_major`  (
  `major_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '专业编号',
  `major_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专业名称',
  `major_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专业代码',
  `major_type` int(11) NOT NULL COMMENT '专业类型',
  PRIMARY KEY (`major_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- -- ----------------------------
-- -- Records of wx_major
-- -- ----------------------------
-- INSERT INTO `wx_major` VALUES (1, '金融', '025100', 1);
-- INSERT INTO `wx_major` VALUES (2, '计算机科学与技术', '081200', 2);
-- INSERT INTO `wx_major` VALUES (3, '马克思主义哲学', '010101 ', 2);
-- INSERT INTO `wx_major` VALUES (4, '新闻与传播', '055200', 1);

-- ----------------------------
-- Table structure for wx_mcd
-- ----------------------------
DROP TABLE IF EXISTS `wx_mcd`;
CREATE TABLE `wx_mcd`  (
  `connect_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '连接编号',
  `major_id` int(11) NOT NULL COMMENT '专业编号',
  `department_id` int(11) NOT NULL COMMENT '院系编号',
  PRIMARY KEY (`connect_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 45 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- -- ----------------------------
-- -- Records of wx_mcd
-- -- ----------------------------
-- INSERT INTO `wx_mcd` VALUES (2, 1, 2);
-- INSERT INTO `wx_mcd` VALUES (3, 1, 3);
-- INSERT INTO `wx_mcd` VALUES (4, 1, 4);
-- INSERT INTO `wx_mcd` VALUES (5, 1, 5);
-- INSERT INTO `wx_mcd` VALUES (6, 1, 6);
-- INSERT INTO `wx_mcd` VALUES (7, 1, 7);
-- INSERT INTO `wx_mcd` VALUES (8, 1, 8);
-- INSERT INTO `wx_mcd` VALUES (9, 1, 9);
-- INSERT INTO `wx_mcd` VALUES (11, 1, 10);
-- INSERT INTO `wx_mcd` VALUES (13, 1, 1);
-- INSERT INTO `wx_mcd` VALUES (15, 2, 11);
-- INSERT INTO `wx_mcd` VALUES (16, 2, 12);
-- INSERT INTO `wx_mcd` VALUES (17, 2, 13);
-- INSERT INTO `wx_mcd` VALUES (18, 2, 14);
-- INSERT INTO `wx_mcd` VALUES (19, 2, 15);
-- INSERT INTO `wx_mcd` VALUES (20, 2, 16);
-- INSERT INTO `wx_mcd` VALUES (21, 2, 17);
-- INSERT INTO `wx_mcd` VALUES (22, 2, 18);
-- INSERT INTO `wx_mcd` VALUES (23, 2, 19);
-- INSERT INTO `wx_mcd` VALUES (24, 2, 20);
-- INSERT INTO `wx_mcd` VALUES (25, 3, 21);
-- INSERT INTO `wx_mcd` VALUES (26, 3, 22);
-- INSERT INTO `wx_mcd` VALUES (27, 3, 23);
-- INSERT INTO `wx_mcd` VALUES (28, 3, 24);
-- INSERT INTO `wx_mcd` VALUES (29, 3, 25);
-- INSERT INTO `wx_mcd` VALUES (30, 3, 26);
-- INSERT INTO `wx_mcd` VALUES (31, 3, 27);
-- INSERT INTO `wx_mcd` VALUES (32, 3, 28);
-- INSERT INTO `wx_mcd` VALUES (33, 3, 29);
-- INSERT INTO `wx_mcd` VALUES (34, 3, 30);
-- INSERT INTO `wx_mcd` VALUES (35, 4, 31);
-- INSERT INTO `wx_mcd` VALUES (36, 4, 32);
-- INSERT INTO `wx_mcd` VALUES (37, 4, 33);
-- INSERT INTO `wx_mcd` VALUES (38, 4, 34);
-- INSERT INTO `wx_mcd` VALUES (39, 4, 35);
-- INSERT INTO `wx_mcd` VALUES (40, 4, 36);
-- INSERT INTO `wx_mcd` VALUES (41, 4, 37);
-- INSERT INTO `wx_mcd` VALUES (42, 4, 38);
-- INSERT INTO `wx_mcd` VALUES (43, 4, 39);
-- INSERT INTO `wx_mcd` VALUES (44, 4, 40);

-- ----------------------------
-- Table structure for wx_school
-- ----------------------------
DROP TABLE IF EXISTS `wx_school`;
CREATE TABLE `wx_school`  (
  `school_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '学校的编号',
  `school_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学校的名字',
  `school_area` int(11) NOT NULL COMMENT '学校所在地区',
  `school_type` int(11) NOT NULL COMMENT '是否为34所自划线',
  `school_levels` int(11) NOT NULL COMMENT '学校层次',
  `school_website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学校官网',
  `school_recruit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学校研招网',
  PRIMARY KEY (`school_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- -- ----------------------------
-- -- Records of wx_school
-- -- ----------------------------
-- INSERT INTO `wx_school` VALUES (1, '清华大学', 1, 1, 1, 'https://www.tsinghua.edu.cn/', 'http://yz.tsinghua.edu.cn/');
-- INSERT INTO `wx_school` VALUES (2, '哈尔滨工业大学', 7, 1, 1, 'http://www.hit.edu.cn/', 'http://yzb.hit.edu.cn/');
-- INSERT INTO `wx_school` VALUES (3, '兰州大学', 28, 1, 1, 'http://www.lzu.edu.cn/', 'http://yz.lzu.edu.cn/');
-- INSERT INTO `wx_school` VALUES (4, '武汉大学', 16, 1, 1, 'http://www.whu.edu.cn/', 'https://gs.whu.edu.cn/');
-- INSERT INTO `wx_school` VALUES (5, '苏州大学', 9, 2, 2, 'http://www.suda.edu.cn/', 'http://yjs.suda.edu.cn/');
-- INSERT INTO `wx_school` VALUES (6, '云南大学', 26, 2, 2, 'http://www.ynu.edu.cn/', 'http://www.grs.ynu.edu.cn/');
-- INSERT INTO `wx_school` VALUES (7, '上海海洋大学', 8, 2, 4, 'https://www.shou.edu.cn/', 'https://yz.chsi.com.cn/sch/schoolInfo--schId-368134.dhtml');
-- INSERT INTO `wx_school` VALUES (8, '湘潭大学', 17, 2, 4, 'https://www.xtu.edu.cn/', 'http://yjsc.xtu.edu.cn/');
-- INSERT INTO `wx_school` VALUES (9, '青岛大学', 14, 2, 5, 'http://www.qdu.edu.cn/', 'http://grad.qdu.edu.cn/');
-- INSERT INTO `wx_school` VALUES (10, '贵州财经大学', 25, 2, 5, 'https://www.gufe.edu.cn/', 'https://yjsy.gufe.edu.cn/');

-- ----------------------------
-- Table structure for wx_score
-- ----------------------------
DROP TABLE IF EXISTS `wx_score`;
CREATE TABLE `wx_score`  (
  `score_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '分数线编号',
  `score_year` int(11) NOT NULL COMMENT '考试的年份',
  `score_all` int(11) NOT NULL COMMENT '复试线',
  `score_math` int(11) NOT NULL COMMENT '数学线',
  `score_english` int(11) NOT NULL COMMENT '英语线',
  `score_politics` int(11) NOT NULL COMMENT '政治线',
  `score_major` int(11) NOT NULL COMMENT '专业线二',
  `connect_id` int(11) NOT NULL COMMENT '连接编号',
  PRIMARY KEY (`score_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 134 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- -- ----------------------------
-- -- Records of wx_score
-- -- ----------------------------
-- INSERT INTO `wx_score` VALUES (7, 2021, 405, 90, 50, 50, 90, 13);
-- INSERT INTO `wx_score` VALUES (8, 2022, 403, 90, 52, 52, 90, 13);
-- INSERT INTO `wx_score` VALUES (9, 2023, 369, 90, 50, 50, 80, 13);
-- INSERT INTO `wx_score` VALUES (10, 2021, 350, 90, 60, 60, 90, 2);
-- INSERT INTO `wx_score` VALUES (11, 2022, 360, 78, 52, 52, 78, 2);
-- INSERT INTO `wx_score` VALUES (12, 2023, 360, 90, 60, 60, 90, 2);
-- INSERT INTO `wx_score` VALUES (13, 2021, 355, 75, 50, 50, 75, 3);
-- INSERT INTO `wx_score` VALUES (14, 2022, 365, 90, 55, 55, 90, 3);
-- INSERT INTO `wx_score` VALUES (15, 2023, 346, 75, 50, 50, 75, 3);
-- INSERT INTO `wx_score` VALUES (16, 2021, 348, 90, 60, 60, 90, 4);
-- INSERT INTO `wx_score` VALUES (17, 2022, 360, 78, 52, 52, 78, 4);
-- INSERT INTO `wx_score` VALUES (18, 2023, 346, 72, 48, 48, 72, 4);
-- INSERT INTO `wx_score` VALUES (19, 2021, 348, 74, 49, 49, 74, 5);
-- INSERT INTO `wx_score` VALUES (20, 2022, 385, 78, 52, 52, 78, 5);
-- INSERT INTO `wx_score` VALUES (21, 2023, 366, 72, 48, 48, 72, 5);
-- INSERT INTO `wx_score` VALUES (22, 2021, 338, 69, 46, 46, 69, 6);
-- INSERT INTO `wx_score` VALUES (23, 2022, 363, 78, 52, 52, 78, 6);
-- INSERT INTO `wx_score` VALUES (24, 2023, 336, 68, 45, 45, 68, 6);
-- INSERT INTO `wx_score` VALUES (25, 2021, 348, 74, 49, 49, 74, 7);
-- INSERT INTO `wx_score` VALUES (26, 2022, 360, 78, 52, 52, 78, 7);
-- INSERT INTO `wx_score` VALUES (27, 2023, 346, 72, 48, 48, 72, 7);
-- INSERT INTO `wx_score` VALUES (28, 2021, 348, 74, 49, 49, 74, 8);
-- INSERT INTO `wx_score` VALUES (29, 2022, 360, 78, 52, 52, 78, 8);
-- INSERT INTO `wx_score` VALUES (30, 2023, 346, 72, 48, 48, 72, 8);
-- INSERT INTO `wx_score` VALUES (31, 2021, 348, 74, 49, 49, 74, 9);
-- INSERT INTO `wx_score` VALUES (32, 2022, 360, 78, 52, 52, 78, 9);
-- INSERT INTO `wx_score` VALUES (33, 2023, 346, 72, 48, 48, 72, 9);
-- INSERT INTO `wx_score` VALUES (34, 2021, 338, 69, 46, 46, 69, 11);
-- INSERT INTO `wx_score` VALUES (35, 2022, 350, 74, 49, 49, 74, 11);
-- INSERT INTO `wx_score` VALUES (36, 2023, 336, 68, 45, 45, 68, 11);
-- INSERT INTO `wx_score` VALUES (37, 2021, 310, 80, 50, 50, 70, 15);
-- INSERT INTO `wx_score` VALUES (38, 2022, 325, 80, 50, 50, 70, 15);
-- INSERT INTO `wx_score` VALUES (39, 2023, 325, 80, 50, 50, 70, 15);
-- INSERT INTO `wx_score` VALUES (40, 2021, 320, 80, 45, 50, 80, 16);
-- INSERT INTO `wx_score` VALUES (41, 2022, 320, 80, 50, 50, 80, 16);
-- INSERT INTO `wx_score` VALUES (42, 2023, 310, 75, 45, 45, 75, 16);
-- INSERT INTO `wx_score` VALUES (43, 2021, 315, 75, 45, 45, 75, 17);
-- INSERT INTO `wx_score` VALUES (44, 2022, 315, 75, 45, 45, 75, 17);
-- INSERT INTO `wx_score` VALUES (45, 2023, 320, 70, 50, 50, 70, 17);
-- INSERT INTO `wx_score` VALUES (46, 2021, 355, 80, 50, 50, 80, 18);
-- INSERT INTO `wx_score` VALUES (47, 2022, 315, 75, 60, 60, 75, 18);
-- INSERT INTO `wx_score` VALUES (48, 2023, 315, 90, 55, 55, 90, 18);
-- INSERT INTO `wx_score` VALUES (49, 2021, 263, 56, 37, 37, 56, 19);
-- INSERT INTO `wx_score` VALUES (50, 2022, 273, 57, 38, 38, 57, 19);
-- INSERT INTO `wx_score` VALUES (51, 2023, 273, 57, 38, 38, 57, 19);
-- INSERT INTO `wx_score` VALUES (52, 2021, 263, 51, 34, 34, 51, 20);
-- INSERT INTO `wx_score` VALUES (53, 2022, 273, 57, 38, 38, 57, 20);
-- INSERT INTO `wx_score` VALUES (54, 2023, 273, 57, 38, 38, 57, 20);
-- INSERT INTO `wx_score` VALUES (55, 2021, 263, 56, 37, 37, 56, 21);
-- INSERT INTO `wx_score` VALUES (56, 2022, 273, 57, 38, 38, 57, 21);
-- INSERT INTO `wx_score` VALUES (57, 2023, 273, 57, 38, 38, 57, 21);
-- INSERT INTO `wx_score` VALUES (58, 2021, 263, 56, 37, 37, 56, 22);
-- INSERT INTO `wx_score` VALUES (59, 2022, 273, 57, 38, 38, 57, 22);
-- INSERT INTO `wx_score` VALUES (60, 2023, 286, 57, 38, 38, 57, 22);
-- INSERT INTO `wx_score` VALUES (61, 2021, 263, 56, 37, 37, 56, 23);
-- INSERT INTO `wx_score` VALUES (62, 2022, 273, 57, 38, 38, 57, 23);
-- INSERT INTO `wx_score` VALUES (63, 2023, 273, 57, 38, 38, 57, 23);
-- INSERT INTO `wx_score` VALUES (65, 2021, 253, 51, 34, 34, 51, 24);
-- INSERT INTO `wx_score` VALUES (66, 2022, 263, 53, 35, 35, 53, 24);
-- INSERT INTO `wx_score` VALUES (67, 2023, 263, 53, 35, 35, 53, 24);
-- INSERT INTO `wx_score` VALUES (68, 2021, 305, 90, 45, 50, 90, 25);
-- INSERT INTO `wx_score` VALUES (69, 2022, 350, 105, 55, 55, 105, 25);
-- INSERT INTO `wx_score` VALUES (70, 2023, 355, 100, 48, 55, 100, 25);
-- INSERT INTO `wx_score` VALUES (71, 2021, 320, 90, 50, 55, 90, 26);
-- INSERT INTO `wx_score` VALUES (72, 2022, 330, 90, 55, 55, 90, 26);
-- INSERT INTO `wx_score` VALUES (73, 2023, 340, 90, 55, 55, 90, 26);
-- INSERT INTO `wx_score` VALUES (74, 2021, 320, 100, 45, 45, 100, 27);
-- INSERT INTO `wx_score` VALUES (75, 2022, 320, 90, 50, 50, 90, 27);
-- INSERT INTO `wx_score` VALUES (76, 2023, 335, 90, 50, 50, 90, 27);
-- INSERT INTO `wx_score` VALUES (77, 2021, 345, 90, 50, 55, 90, 28);
-- INSERT INTO `wx_score` VALUES (78, 2022, 370, 90, 60, 60, 90, 28);
-- INSERT INTO `wx_score` VALUES (79, 2023, 340, 90, 50, 55, 90, 28);
-- INSERT INTO `wx_score` VALUES (80, 2021, 299, 62, 41, 41, 62, 29);
-- INSERT INTO `wx_score` VALUES (81, 2022, 314, 68, 45, 45, 68, 29);
-- INSERT INTO `wx_score` VALUES (82, 2023, 323, 68, 45, 45, 68, 29);
-- INSERT INTO `wx_score` VALUES (83, 2021, 340, 57, 38, 38, 57, 30);
-- INSERT INTO `wx_score` VALUES (84, 2022, 322, 63, 42, 42, 63, 30);
-- INSERT INTO `wx_score` VALUES (85, 2023, 336, 63, 42, 42, 63, 30);
-- INSERT INTO `wx_score` VALUES (86, 2021, 299, 62, 41, 41, 62, 31);
-- INSERT INTO `wx_score` VALUES (87, 2022, 314, 68, 45, 45, 68, 31);
-- INSERT INTO `wx_score` VALUES (88, 2023, 323, 68, 45, 45, 68, 31);
-- INSERT INTO `wx_score` VALUES (89, 2021, 299, 62, 41, 41, 62, 32);
-- INSERT INTO `wx_score` VALUES (90, 2022, 314, 68, 45, 45, 68, 32);
-- INSERT INTO `wx_score` VALUES (91, 2023, 323, 68, 45, 45, 68, 32);
-- INSERT INTO `wx_score` VALUES (92, 2021, 299, 62, 41, 41, 62, 33);
-- INSERT INTO `wx_score` VALUES (93, 2022, 314, 68, 45, 45, 68, 33);
-- INSERT INTO `wx_score` VALUES (94, 2023, 323, 68, 45, 45, 68, 33);
-- INSERT INTO `wx_score` VALUES (95, 2021, 289, 57, 38, 38, 57, 34);
-- INSERT INTO `wx_score` VALUES (96, 2022, 304, 63, 42, 42, 63, 34);
-- INSERT INTO `wx_score` VALUES (97, 2023, 313, 63, 42, 42, 63, 34);
-- INSERT INTO `wx_score` VALUES (98, 2021, 390, 115, 65, 65, 115, 35);
-- INSERT INTO `wx_score` VALUES (99, 2022, 385, 100, 60, 60, 100, 35);
-- INSERT INTO `wx_score` VALUES (100, 2023, 363, 81, 75, 55, 100, 35);
-- INSERT INTO `wx_score` VALUES (101, 2021, 355, 80, 53, 53, 80, 36);
-- INSERT INTO `wx_score` VALUES (102, 2022, 367, 84, 56, 56, 84, 36);
-- INSERT INTO `wx_score` VALUES (103, 2023, 363, 81, 54, 54, 81, 36);
-- INSERT INTO `wx_score` VALUES (104, 2021, 370, 100, 55, 55, 100, 37);
-- INSERT INTO `wx_score` VALUES (105, 2022, 367, 90, 60, 60, 90, 37);
-- INSERT INTO `wx_score` VALUES (106, 2023, 380, 90, 60, 60, 90, 37);
-- INSERT INTO `wx_score` VALUES (107, 2021, 380, 100, 60, 60, 100, 38);
-- INSERT INTO `wx_score` VALUES (108, 2022, 385, 100, 60, 60, 100, 38);
-- INSERT INTO `wx_score` VALUES (109, 2023, 365, 105, 60, 60, 105, 38);
-- INSERT INTO `wx_score` VALUES (110, 2021, 355, 80, 53, 53, 80, 39);
-- INSERT INTO `wx_score` VALUES (111, 2022, 367, 84, 56, 56, 84, 39);
-- INSERT INTO `wx_score` VALUES (112, 2023, 363, 81, 54, 54, 81, 39);
-- INSERT INTO `wx_score` VALUES (113, 2021, 349, 75, 50, 50, 75, 40);
-- INSERT INTO `wx_score` VALUES (114, 2022, 358, 80, 53, 53, 80, 40);
-- INSERT INTO `wx_score` VALUES (115, 2023, 361, 77, 51, 51, 77, 40);
-- INSERT INTO `wx_score` VALUES (116, 2021, 355, 80, 53, 53, 80, 41);
-- INSERT INTO `wx_score` VALUES (117, 2022, 367, 84, 56, 56, 84, 41);
-- INSERT INTO `wx_score` VALUES (118, 2023, 363, 81, 54, 54, 81, 41);
-- INSERT INTO `wx_score` VALUES (119, 2021, 355, 80, 53, 53, 80, 42);
-- INSERT INTO `wx_score` VALUES (120, 2022, 391, 84, 56, 56, 84, 42);
-- INSERT INTO `wx_score` VALUES (121, 2023, 382, 81, 54, 54, 81, 42);
-- INSERT INTO `wx_score` VALUES (122, 2021, 355, 80, 53, 53, 80, 43);
-- INSERT INTO `wx_score` VALUES (123, 2022, 367, 84, 56, 56, 84, 43);
-- INSERT INTO `wx_score` VALUES (124, 2023, 363, 81, 54, 54, 81, 43);
-- INSERT INTO `wx_score` VALUES (125, 2021, 345, 75, 50, 50, 75, 44);
-- INSERT INTO `wx_score` VALUES (126, 2022, 357, 80, 53, 53, 80, 44);
-- INSERT INTO `wx_score` VALUES (127, 2023, 353, 77, 51, 51, 77, 44);

-- ----------------------------
-- Table structure for wx_user_scoreinfo
-- ----------------------------
DROP TABLE IF EXISTS `wx_user_scoreinfo`;
CREATE TABLE `wx_user_scoreinfo`  (
  `user_id` int(11) NOT NULL COMMENT '用户编号',
  `score_all` int(11) NULL DEFAULT NULL COMMENT '初试成绩',
  `score_english` int(11) NULL DEFAULT NULL COMMENT '初试英语',
  `score_politics` int(11) NULL DEFAULT NULL COMMENT '初始政治',
  `score_math` int(11) NULL DEFAULT NULL COMMENT '专业一',
  `score_major` int(11) NULL DEFAULT NULL COMMENT '专业二',
  `major_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '专业名称',
  `major_type` int(11) NULL DEFAULT NULL COMMENT '专业类型',
  `area_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区名称',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of wx_user_scoreinfo
-- ----------------------------
INSERT INTO `wx_user_scoreinfo` VALUES (1, 370, 85, 85, 100, 100, '金融', 2, '山东');
INSERT INTO `wx_user_scoreinfo` VALUES (100, NULL, NULL, NULL, NULL, NULL, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (102, 360, 99, 99, 99, 99, '金融', 1, '北京');
INSERT INTO `wx_user_scoreinfo` VALUES (104, 360, 100, 100, 100, 60, '金融', 1, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (105, 360, 100, 100, 100, 60, '金融', 1, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (106, 400, 100, 100, 100, 100, '金融', 1, '北京');
INSERT INTO `wx_user_scoreinfo` VALUES (108, 370, 85, 85, 100, 100, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (110, 370, 85, 85, 100, 100, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (111, 370, 100, 90, 90, 90, '金融', 1, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (115, 370, 90, 90, 90, 100, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (116, 340, 70, 70, 80, 80, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (117, 340, 70, 70, 80, 80, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (118, 370, 85, 85, 100, 100, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (119, 370, 75, 75, 80, 80, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (120, 370, 85, 85, 100, 100, '金融', NULL, NULL);
INSERT INTO `wx_user_scoreinfo` VALUES (121, 370, 85, 85, 100, 100, '金融', NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;


# 建立索引
create index idx_name_school_id on wx_department(department_name,department_school_id);
create index idx_school_id on wx_department(department_school_id);

create index idx_year_allScore on wx_dScore(score_year,score_all);

create index idx_code_name_type on wx_major(major_code,major_name,major_type);
create index idx_name_type on wx_major(major_name,major_type);
create index idx_type on wx_major(major_type);

create index idx_area_level on wx_school(school_area,school_levels);
create index idx_level on wx_school(school_levels);
create index idx_name on wx_school(school_name);

create index idx_all_math_english_politics_major_year on
    wx_score(score_all,score_math,score_english,score_politics,score_major,score_year);
create index idx_all_year on wx_score(score_all,score_year);


