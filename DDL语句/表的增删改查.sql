-- 建议关键词大写,表名数据库名字段名小写

#================================数据库操作=============================================

# --------------- 查看数据库---------------
SHOW DATABASES;

# -------------创建数据库-------------
CREATE DATABASE test_db;

# ------------删除数据库----------------
DROP DATABASE test_db;

# ================================表操作=============================================

# -------------------新建表（增）-----------------------
# 创建表tb1
CREATE TABLE tb1(
    ## AUTO_INCREMENT表示自增 UNSIGNED表示无符号 PRIMARY KEY表示主键 NOT NULL表示非空
    id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
    ## DEFAULT表示默认
    name VARCHAR(20) DEFAULT NULL ,
    age TINYINT UNSIGNED NOT NULL DEFAULT 0 ,
    height DECIMAL(5,2) NOT NULL DEFAULT 0.00 ,
    gender ENUM('男','女','保密') DEFAULT NULL
    ## FOREIGN KEY 表示外键
);

# 展示创建表的代码
SHOW CREATE TABLE tb1;



# ------------------查看表结构（查）---------------------
# 查看表结构
DESC tb1;   # 查看表结构

# --------------------------展示表(查)---------------------

SHOW TABLE STATUS ;

# -----------------修改表名（改）---------------------
RENAME TABLE tb1 TO tb; # 修改表名
#------------------修改表结构(改)-------------------
# 增加字段
ALTER TABLE tb
## ADD 新字段名 类型 约束
ADD aaa INT UNSIGNED;  # 增加字段

# 修改字段
ALTER TABLE tb
## CHANGE 原字段名 新字段名 类型 约束tb
CHANGE name stu_name VARCHAR(10) UNIQUE ;

# 删除字段
ALTER TABLE tb
DROP COLUMN aaa;

# ----------------清空表（删）-----------------
TRUNCATE TABLE tb;

# ----------------删除表（删）-------------------
# 删除数据表
DROP TABLE tb;



# ======================================================
# 创建删除表时最好加上判，如：
#（ 1.可用于删除和创建的判断。）
# 删除指定表格，如果XXXX表存在
DROP TABLE IF EXISTS XXXX;

# 创建表格,如果aaa表不存在
CREATE TABLE IF NOT EXISTS aaa(
    id INT  PRIMARY KEY ,
    name VARCHAR(20)
);