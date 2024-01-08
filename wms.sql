/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80022
 Source Host           : localhost:3306
 Source Schema         : wms

 Target Server Type    : MySQL
 Target Server Version : 80022
 File Encoding         : 65001

 Date: 16/02/2023 15:30:11
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
                          `id` int NOT NULL AUTO_INCREMENT,
                          `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                          `storage` int NOT NULL,
                          `goodsType` int NOT NULL,
                          `count` int NULL DEFAULT NULL,
                          `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 'Toothbrush', 2, 3, 198, 'Oral_B');
INSERT INTO `goods` VALUES (2, 'Iphone', 1, 1, 1008, 'Apple');
INSERT INTO `goods` VALUES (3, 'Tylenol', 3, 2, 10933, 'CVS');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
                              `id` int NOT NULL AUTO_INCREMENT,
                              `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                              `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                              PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES (1, 'Electronics', 'Iphone, Tablet, Laptop');
INSERT INTO `goodstype` VALUES (2, 'Medicals', 'Cold, Fever, Allergy');
INSERT INTO `goodstype` VALUES (3, 'Households', 'toothbrush, towels, shampoo');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
                         `id` int NOT NULL,
                         `menuCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `menuName` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `menuLevel` varchar(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `menuParentCode` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `menuClick` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `menuRight` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT ' 0 super admin，1 admin，2 user',
                         `menuComponent` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `menuIcon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '001', '管理员管理', '1', NULL, 'Admin', '0', 'admin/AdminManage.vue', 'el-icon-s-custom');
INSERT INTO `menu` VALUES (2, '002', '用户管理', '1', NULL, 'User', '0,1', 'user/UserManage.vue', 'el-icon-user-solid');
INSERT INTO `menu` VALUES (3, '003', '仓库管理', '1', NULL, 'Storage', '0,1', 'storage/StorageManage', 'el-icon-office-building');
INSERT INTO `menu` VALUES (4, '004', '物品分类管理', '1', NULL, 'Goodstype', '0,1', 'goodstype/GoodstypeManage', 'el-icon-menu');
INSERT INTO `menu` VALUES (5, '005', '物品管理 ', '1', NULL, 'Goods', '0,1,2', 'goods/GoodsManage', 'el-icon-s-management');
INSERT INTO `menu` VALUES (6, '006', '记录管理', '1', NULL, 'Record', '0,1,2', 'record/RecordManage', 'el-icon-s-order');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
                           `id` int NOT NULL AUTO_INCREMENT,
                           `goods` int NOT NULL,
                           `userId` int NULL DEFAULT NULL,
                           `admin_id` int NULL DEFAULT NULL,
                           `count` int NULL DEFAULT NULL,
                           `createtime` datetime NULL DEFAULT NULL,
                           `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 2, 4, 1, 9, '2023-02-16 15:26:02', 'half price');
INSERT INTO `record` VALUES (2, 1, 3, 1, 99, '2023-02-16 15:26:29', 'brand');
INSERT INTO `record` VALUES (3, 3, 5, 1, 999, '2023-02-16 15:27:04', 'in mess');
INSERT INTO `record` VALUES (4, 3, 4, 1, -65, '2023-02-16 15:28:06', 'urgent');

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage`  (
                            `id` int NOT NULL AUTO_INCREMENT,
                            `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                            `remark` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES (1, 'shanghai warehouse', 'shanghai warehouse management');
INSERT INTO `storage` VALUES (2, 'hangzhou warehouse', 'hangzhou warehouse management');
INSERT INTO `storage` VALUES (3, 'suzhou warehouse', 'suzhou warehouse management');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
                         `id` int NOT NULL AUTO_INCREMENT,
                         `no` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                         `password` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
                         `age` int NULL DEFAULT NULL,
                         `sex` int NULL DEFAULT NULL,
                         `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
                         `role_id` int NULL DEFAULT NULL,
                         `isValid` varchar(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'Y',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'Super Admin', 'root', 18, 1, '13215227869', 0, 'Y');
INSERT INTO `user` VALUES (2, 'sa', 'Admin', 'root', 19, 0, '13215223466', 1, 'Y');
INSERT INTO `user` VALUES (3, 'gaze', 'User1', '123456', 29, 1, '13215228462', 2, 'Y');
INSERT INTO `user` VALUES (4, 'marin', 'User2', '123456', 18, 1, '18866669998', 2, 'Y');
INSERT INTO `user` VALUES (5, 'susic', 'User3', '123456', 22, 0, '13700000044', 2, 'Y');
INSERT INTO `user` VALUES (6, 'suke', 'User4', '123456', 32, 1, '18866669998', 1, 'Y');

SET FOREIGN_KEY_CHECKS = 1;
