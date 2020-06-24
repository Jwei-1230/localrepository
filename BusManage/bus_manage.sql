/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50538
Source Host           : 127.0.0.1:3306
Source Database       : bus_manage

Target Server Type    : MYSQL
Target Server Version : 50538
File Encoding         : 65001

Date: 2020-05-13 12:42:38
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bus_device
-- ----------------------------
DROP TABLE IF EXISTS `bus_device`;
CREATE TABLE `bus_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `balance` int(255) DEFAULT NULL,
  `price` int(11) DEFAULT '0',
  `version` int(11) DEFAULT NULL,
  `createUser` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='汽车配件库存表';

-- ----------------------------
-- Records of bus_device
-- ----------------------------
INSERT INTO `bus_device` VALUES ('3', '汽车轮毂', '9', '100', '3', '1', '2020-05-12 10:49:01');
INSERT INTO `bus_device` VALUES ('4', '汽车尾灯', '9', '100', '5', '1', '2020-05-12 10:50:25');
INSERT INTO `bus_device` VALUES ('5', '特斯拉前车灯', '8', '1000', '1', '1', '2020-05-13 11:26:51');
INSERT INTO `bus_device` VALUES ('6', '汽车保险杠', '20', '1000', '3', '1', '2020-05-13 12:32:05');

-- ----------------------------
-- Table structure for bus_device_inventory
-- ----------------------------
DROP TABLE IF EXISTS `bus_device_inventory`;
CREATE TABLE `bus_device_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceId` int(50) DEFAULT NULL COMMENT 'bus_device 主键',
  `amount` int(11) DEFAULT NULL COMMENT '库存',
  `version` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='汽车配件表';

-- ----------------------------
-- Records of bus_device_inventory
-- ----------------------------

-- ----------------------------
-- Table structure for bus_device_operate
-- ----------------------------
DROP TABLE IF EXISTS `bus_device_operate`;
CREATE TABLE `bus_device_operate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `deviceId` int(50) DEFAULT NULL,
  `type` int(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `operateAmount` int(255) DEFAULT NULL COMMENT '操作数量',
  `balanceAmount` int(11) DEFAULT NULL COMMENT '剩余数量',
  `createUser` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='汽车配件变动表';

-- ----------------------------
-- Records of bus_device_operate
-- ----------------------------
INSERT INTO `bus_device_operate` VALUES ('2', '3', '1', '初始入库', '10', '0', '1', '2020-05-12 10:49:01');
INSERT INTO `bus_device_operate` VALUES ('3', '4', '1', '初始入库', '2', '0', '1', '2020-05-12 10:50:25');
INSERT INTO `bus_device_operate` VALUES ('4', '4', '1', '手动入库', '1', '2', '1', '2020-05-12 11:26:59');
INSERT INTO `bus_device_operate` VALUES ('5', '4', '2', '手动出库', '3', '3', '1', '2020-05-12 11:27:19');
INSERT INTO `bus_device_operate` VALUES ('12', '3', '2', '客户维修领用出库', '1', '10', '3', '2020-05-12 21:12:49');
INSERT INTO `bus_device_operate` VALUES ('13', '3', '2', '客户维修领用出库', '1', '9', '3', '2020-05-12 21:20:38');
INSERT INTO `bus_device_operate` VALUES ('14', '3', '1', '维修完工配件入库', '1', '8', '3', '2020-05-12 22:48:11');
INSERT INTO `bus_device_operate` VALUES ('15', '4', '1', '手动入库', '10', '0', '1', '2020-05-13 11:20:25');
INSERT INTO `bus_device_operate` VALUES ('16', '5', '1', '初始入库', '10', '0', '1', '2020-05-13 11:26:51');
INSERT INTO `bus_device_operate` VALUES ('17', '4', '2', '客户维修领用出库', '2', '10', '3', '2020-05-13 11:27:45');
INSERT INTO `bus_device_operate` VALUES ('18', '5', '2', '客户维修领用出库', '2', '10', '3', '2020-05-13 11:27:52');
INSERT INTO `bus_device_operate` VALUES ('20', '4', '1', '维修完工配件入库', '1', '8', '3', '2020-05-13 11:30:57');
INSERT INTO `bus_device_operate` VALUES ('21', '6', '1', '初始入库', '10', '0', '1', '2020-05-13 12:32:06');
INSERT INTO `bus_device_operate` VALUES ('22', '6', '1', '手动入库', '10', '10', '1', '2020-05-13 12:32:13');
INSERT INTO `bus_device_operate` VALUES ('23', '6', '2', '客户维修领用出库', '2', '20', '5', '2020-05-13 12:37:23');
INSERT INTO `bus_device_operate` VALUES ('24', '6', '1', '维修完工配件入库', '2', '18', '5', '2020-05-13 12:37:50');

-- ----------------------------
-- Table structure for bus_info
-- ----------------------------
DROP TABLE IF EXISTS `bus_info`;
CREATE TABLE `bus_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `name` varchar(50) DEFAULT NULL,
  `total` varchar(50) DEFAULT NULL COMMENT '总价',
  `buyTime` varchar(255) DEFAULT NULL,
  `delFlag` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='汽车表';

-- ----------------------------
-- Records of bus_info
-- ----------------------------
INSERT INTO `bus_info` VALUES ('1', '1', '特斯拉model1的撒大士大夫士大夫', '25w', '2020-05-10', '1', '2020-05-12 15:03:45');
INSERT INTO `bus_info` VALUES ('2', '1', '特斯拉model2 超续航版', '100w', '2020-05-10', '0', '2020-05-12 15:19:47');
INSERT INTO `bus_info` VALUES ('3', '4', '特斯拉model2', '18w', '2020-04-30', '0', '2020-05-13 11:03:32');
INSERT INTO `bus_info` VALUES ('4', '4', '大众 桑塔纳1111', '10w', '2001-10-10', '0', '2020-05-13 12:35:07');

-- ----------------------------
-- Table structure for bus_msg
-- ----------------------------
DROP TABLE IF EXISTS `bus_msg`;
CREATE TABLE `bus_msg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `content` text,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='客户留言';

-- ----------------------------
-- Records of bus_msg
-- ----------------------------
INSERT INTO `bus_msg` VALUES ('3', '4', '你们的服务太棒了真好', '2020-05-13 11:10:22');

-- ----------------------------
-- Table structure for bus_order
-- ----------------------------
DROP TABLE IF EXISTS `bus_order`;
CREATE TABLE `bus_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `orderNo` varchar(50) DEFAULT NULL,
  `repairId` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='结算单';

-- ----------------------------
-- Records of bus_order
-- ----------------------------
INSERT INTO `bus_order` VALUES ('4', '1', '1589294891764', '2', '100', '2', '2020-05-12 22:48:11');
INSERT INTO `bus_order` VALUES ('6', '4', '1589340657067', '3', '2100', '2', '2020-05-13 11:30:57');
INSERT INTO `bus_order` VALUES ('7', '4', '1589344670060', '5', '1000', '2', '2020-05-13 12:37:50');

-- ----------------------------
-- Table structure for bus_order_device
-- ----------------------------
DROP TABLE IF EXISTS `bus_order_device`;
CREATE TABLE `bus_order_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orderId` int(50) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL,
  `name` varchar(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='售卖汽车配件记录';

-- ----------------------------
-- Records of bus_order_device
-- ----------------------------
INSERT INTO `bus_order_device` VALUES ('3', '4', '1', '汽车轮毂', '100', '1', '2020-05-12 22:48:11');
INSERT INTO `bus_order_device` VALUES ('4', '6', '4', '汽车尾灯', '100', '1', '2020-05-13 11:30:57');
INSERT INTO `bus_order_device` VALUES ('5', '6', '4', '特斯拉前车灯', '1000', '2', '2020-05-13 11:30:57');
INSERT INTO `bus_order_device` VALUES ('6', '7', '4', '汽车保险杠', '1000', '1', '2020-05-13 12:37:50');

-- ----------------------------
-- Table structure for bus_repair_order
-- ----------------------------
DROP TABLE IF EXISTS `bus_repair_order`;
CREATE TABLE `bus_repair_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '用户id',
  `ysAmount` varchar(11) DEFAULT NULL COMMENT '客户预算',
  `busId` int(11) DEFAULT NULL COMMENT '客户的车',
  `status` int(11) DEFAULT NULL COMMENT '1 处理中',
  `payStatus` int(11) DEFAULT NULL,
  `sjAmount` int(11) DEFAULT NULL,
  `repairUser` int(11) DEFAULT NULL,
  `delFlag` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL COMMENT '客户备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bus_repair_order
-- ----------------------------
INSERT INTO `bus_repair_order` VALUES ('1', '1', '1000', '1', '1', '1', null, null, '1', '2020-05-12 16:20:09', '速度处理');
INSERT INTO `bus_repair_order` VALUES ('2', '1', '1000', '2', '3', '1', null, '3', '0', '2020-05-12 17:12:12', '保险杠坏了4545354');
INSERT INTO `bus_repair_order` VALUES ('3', '4', '2000', '3', '3', '1', null, '3', '0', '2020-05-13 11:18:06', '前车灯后车灯更换');
INSERT INTO `bus_repair_order` VALUES ('4', '4', '10000', '4', '1', '1', null, null, '1', '2020-05-13 12:35:45', '更换前置保险杠');
INSERT INTO `bus_repair_order` VALUES ('5', '4', '1000', '4', '3', '1', null, '5', '0', '2020-05-13 12:36:14', '更换汽车保险杠');

-- ----------------------------
-- Table structure for bus_repair_paijian
-- ----------------------------
DROP TABLE IF EXISTS `bus_repair_paijian`;
CREATE TABLE `bus_repair_paijian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `repairId` int(11) DEFAULT NULL COMMENT '预约维修的id',
  `wuLiaoId` int(11) DEFAULT NULL COMMENT '配件id',
  `amount` int(11) DEFAULT NULL COMMENT '配件数量',
  `repairUser` int(11) DEFAULT NULL COMMENT '维修人员',
  `type` int(11) DEFAULT NULL COMMENT 'type 1 配件 2工具',
  `createTime` datetime DEFAULT NULL COMMENT '客户备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='维修派件';

-- ----------------------------
-- Records of bus_repair_paijian
-- ----------------------------
INSERT INTO `bus_repair_paijian` VALUES ('1', '汽车轮毂', '100', '2', '3', '2', '3', '1', '2020-05-12 21:12:49');
INSERT INTO `bus_repair_paijian` VALUES ('2', '1号扳手', '0', '2', '5', '3', '3', '2', '2020-05-12 21:12:56');
INSERT INTO `bus_repair_paijian` VALUES ('3', '汽车尾灯', '100', '3', '4', '2', '3', '1', '2020-05-13 11:27:45');
INSERT INTO `bus_repair_paijian` VALUES ('4', '特斯拉前车灯', '1000', '3', '5', '2', '3', '1', '2020-05-13 11:27:52');
INSERT INTO `bus_repair_paijian` VALUES ('5', '汽车保险杠', '1000', '5', '6', '3', '5', '1', '2020-05-13 12:37:23');
INSERT INTO `bus_repair_paijian` VALUES ('6', '1号扳手', '0', '5', '5', '1', '5', '2', '2020-05-13 12:37:32');

-- ----------------------------
-- Table structure for bus_repair_tool
-- ----------------------------
DROP TABLE IF EXISTS `bus_repair_tool`;
CREATE TABLE `bus_repair_tool` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `balance` int(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `createUser` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='维修工具表';

-- ----------------------------
-- Records of bus_repair_tool
-- ----------------------------
INSERT INTO `bus_repair_tool` VALUES ('5', '1号扳手', '5', '5', '1', '2020-05-12 12:48:43');
INSERT INTO `bus_repair_tool` VALUES ('6', '千斤顶', '10', '2', '1', '2020-05-13 12:32:47');

-- ----------------------------
-- Table structure for bus_repair_tool_inventory
-- ----------------------------
DROP TABLE IF EXISTS `bus_repair_tool_inventory`;
CREATE TABLE `bus_repair_tool_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toolId` int(50) DEFAULT NULL COMMENT 'bus_tool主键',
  `amount` int(11) DEFAULT NULL COMMENT '库存',
  `version` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='维修工具库存表';

-- ----------------------------
-- Records of bus_repair_tool_inventory
-- ----------------------------

-- ----------------------------
-- Table structure for bus_repair_tool_operate
-- ----------------------------
DROP TABLE IF EXISTS `bus_repair_tool_operate`;
CREATE TABLE `bus_repair_tool_operate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `toolId` int(50) DEFAULT NULL COMMENT 'bus_device 主键',
  `operateAmount` int(255) DEFAULT NULL COMMENT '操作数量',
  `balanceAmount` int(11) DEFAULT NULL COMMENT '剩余数量',
  `version` int(11) DEFAULT NULL,
  `type` int(50) DEFAULT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `createUser` int(11) DEFAULT NULL,
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='维修工具操作记录表';

-- ----------------------------
-- Records of bus_repair_tool_operate
-- ----------------------------
INSERT INTO `bus_repair_tool_operate` VALUES ('4', '5', '5', '0', null, '1', '初始入库', '1', '2020-05-12 12:48:43');
INSERT INTO `bus_repair_tool_operate` VALUES ('5', '5', '1', '5', null, '2', '维修领用出库', '3', '2020-05-12 21:12:56');
INSERT INTO `bus_repair_tool_operate` VALUES ('6', '5', '2', '4', null, '2', '维修领用出库', '3', '2020-05-12 21:20:54');
INSERT INTO `bus_repair_tool_operate` VALUES ('7', '5', '3', '2', null, '1', '维修完工工具入库', '3', '2020-05-12 22:48:11');
INSERT INTO `bus_repair_tool_operate` VALUES ('8', '6', '10', '0', null, '1', '初始入库', '1', '2020-05-13 12:32:47');
INSERT INTO `bus_repair_tool_operate` VALUES ('9', '6', '1', '10', null, '1', '手动入库', '1', '2020-05-13 12:32:53');
INSERT INTO `bus_repair_tool_operate` VALUES ('10', '5', '1', '5', null, '2', '维修领用出库', '5', '2020-05-13 12:37:32');
INSERT INTO `bus_repair_tool_operate` VALUES ('11', '6', '1', '11', null, '2', '维修领用出库', '5', '2020-05-13 12:37:37');
INSERT INTO `bus_repair_tool_operate` VALUES ('12', '5', '1', '4', null, '1', '维修完工工具入库', '5', '2020-05-13 12:37:50');

-- ----------------------------
-- Table structure for bus_user
-- ----------------------------
DROP TABLE IF EXISTS `bus_user`;
CREATE TABLE `bus_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) DEFAULT NULL COMMENT '用户名',
  `passWord` varchar(50) DEFAULT NULL COMMENT '密码',
  `realName` varchar(50) DEFAULT NULL,
  `role` int(11) DEFAULT NULL COMMENT '角色 1管理员 2维修工 3客户',
  `phone` varchar(50) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(50) DEFAULT NULL COMMENT '地址',
  `delFlag` int(11) DEFAULT NULL COMMENT '0 未删除 1已删除',
  `createTime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bus_user
-- ----------------------------
INSERT INTO `bus_user` VALUES ('1', 'admin', '111111', '管理员111', '1', '188888', '测试地址2222', '0', '2020-05-12 14:29:42');
INSERT INTO `bus_user` VALUES ('2', 'w001', '111111', '修理工人1', '2', '15878962583', '测试地址', '1', '2020-05-12 14:46:31');
INSERT INTO `bus_user` VALUES ('3', 'w002', '111111', '修理工1', '2', '18798567563', '测试住址', '0', '2020-05-12 14:49:02');
INSERT INTO `bus_user` VALUES ('4', 'c001', '111111', '客户1222', '3', '15878962587', '客户测试地址', '0', '2020-05-13 10:51:55');
INSERT INTO `bus_user` VALUES ('5', 'w003', '111111', '维修工333', '2', '184646464487', '测试地址', '0', '2020-05-13 12:33:26');
