#-----------------------------DML-------------------------------
-- 学生表
CREATE TABLE students(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    age INT,
    height FLOAT,
    gender CHAR(10),
    cls_id INT,
    is_delete INT
);

-- 教师表
CREATE TABLE teachers(
    id INT PRIMARY KEY,
    name VARCHAR(20)
);

-- 班级表
CREATE TABLE classes(
    id INT PRIMARY KEY,
    teacher_id INT,
    cls_content VARCHAR(100),
    cls_date DATETIME,
    name VARCHAR(50)
);

#-------------------------DQL----------------------------------
TRUNCATE students;
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (1, '小明', 18, 180, '女', 1, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (2, '小月月', 18, 180, '女', 2, 1);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (3, '彭于晏', 29, 185, '男', 1, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (4, '刘德华', 59, 175, '男', 2, 1);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (5, '黄蓉', 38, 160, '女', 1, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (6, '凤姐', 28, 150, '保密', 2, 1);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (7, '王祖贤', 18, 172, '保密', 1, 1);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (8, '周杰伦', 36, NULL, '男', 3, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (9, '程坤', 27, 181, '男', 2, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (10, '刘亦菲', 25, 166, '男', 2, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (11, '猪猪侠', 33, 162, '保密', 3, 1);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (12, '静香', 12, 180, '女', 2, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (13, '郭靖', 12, 170, '男', 3, 0);
INSERT INTO `students` (`id`, `name`, `age`, `height`, `gender`, `cls_id`, `is_delete`) VALUES (14, '周杰', 34, 176, '女', 1, 0);

TRUNCATE teachers;
INSERT INTO `teachers` (`id`, `name`) VALUES (1, '赵老师');
INSERT INTO `teachers` (`id`, `name`) VALUES (2, '孙老师');
INSERT INTO `teachers` (`id`, `name`) VALUES (3, '李老师');
INSERT INTO `teachers` (`id`, `name`) VALUES (4, '周老师');

TRUNCATE classes;
INSERT INTO `classes` (`id`, `teacher_id`, `cls_content`, `cls_date`, `name`) VALUES (1, 1, '班级学生有较强的学习能力', '2024-10-01 00:00:00', 'python_01期');
INSERT INTO `classes` (`id`, `teacher_id`, `cls_content`, `cls_date`, `name`) VALUES (2, 2, '班级学生比较顽皮', '2024-11-01 00:00:00', 'python_02期');
INSERT INTO `classes` (`id`, `teacher_id`, `cls_content`, `cls_date`, `name`) VALUES (3, 2, '数据结构班', '2024-11-01 00:00:00', 'data_struct_01期');