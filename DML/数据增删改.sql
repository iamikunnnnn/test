# ---------------插入（增）-----------------
## INSERT INTO的列名可以不写，但建议写，写了之后表结构变动时sql语言仍能生效
# 1. 单行插入
INSERT INTO students (id ,name,age,height,gender, cls_id,is_delete)
VALUES (1,'张三', 18,19,'男',1,0);
# 2. 多行插入（对于自增长的字段，可以不用赋值）
INSERT INTO teachers (id, name)
VALUES (1,'刘姥姥'),(3,'张大爷');

# 用SELECT 单行插入
INSERT INTO teachers (id, name)
SELECT 5,'飞老师';

# 用SELECT 多行插入
INSERT INTO teachers (id, name)
SELECT 6, '朴卡卡'
UNION ALL
SELECT 7, '梦老师';

# ---------------删除（删）-------------------------
# 删除数据,DELETE在事件中可回滚(DROP是删除字段)
DELETE FROM teachers
WHERE id=1;

# -------------------修改（改）---------------------
# **不加where会修改整张表，用where筛选可指定对应的记录进行修改**
UPDATE teachers
SET name='李叔叔',id=2
WHERE id=3;


