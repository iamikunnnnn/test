CREATE TABLE books(
    book_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(50) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE readers(
    reader_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    reader_name VARCHAR(50) NOT NULL,
    tel INT NOT NULL
);

CREATE TABLE borrow_records(
    borrow_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    reader_id INT NOT NULL ,
    book_id INT NOT NULL,
    borrow_time DATETIME NOT NULL ,
    status TINYINT COMMENT '0已归还 1未归还 2逾期',
    FOREIGN KEY (reader_id) REFERENCES readers(reader_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

# 修改字段
ALTER TABLE readers
## CHANGE 原字段名 新字段名 类型 约束tb
CHANGE tel tel  BIGINT NOT NULL;






-- 插入 books 表数据
INSERT INTO books (book_name, stock, price) VALUES
('数据库原理', 10, 59.90),
('算法导论', 5, 89.00),
('Python编程', 12, 69.50),
('人工智能基础', 8, 99.00),
('机器学习实战', 7, 79.00),
('数据结构与算法', 6, 75.50),
('C++入门', 9, 65.00),
('Java核心技术', 4, 85.00),
('操作系统概念', 5, 95.00),
('计算机网络', 10, 55.50),
('深度学习入门', 6, 120.00),
('前端开发指南', 7, 45.00);

-- 插入 readers 表数据
INSERT INTO readers (reader_name, tel) VALUES
('张三', 13800000001),
('李四', 13800000002),
('王五', 13800000003),
('赵六', 13800000004),
('钱七', 13800000005),
('孙八', 13800000006),
('周九', 13800000007),
('吴十', 13800000008),
('郑十一', 13800000009),
('冯十二', 13800000010),
('陈十三', 13800000011),
('褚十四', 13800000012);

-- 插入 borrow_records 表数据
INSERT INTO borrow_records (reader_id, book_id, borrow_time, status) VALUES
(1, 1, '2025-08-01 10:00:00', 1),
(2, 3, '2025-08-02 11:30:00', 0),
(3, 5, '2025-08-03 14:20:00', 1),
(4, 2, '2025-08-04 09:15:00', 2),
(5, 4, '2025-08-05 16:45:00', 0),
(6, 6, '2025-08-06 13:00:00', 1),
(7, 7, '2025-08-07 12:30:00', 1),
(8, 8, '2025-08-08 15:10:00', 0),
(9, 9, '2025-08-09 10:50:00', 2),
(10, 10, '2025-08-10 17:20:00', 1),
(11, 11, '2025-08-11 11:00:00', 0),
(12, 12, '2025-08-12 14:40:00', 1),
(1, 2, '2025-08-13 09:30:00', 1),
(2, 4, '2025-08-14 13:15:00', 0),
(3, 6, '2025-08-15 10:25:00', 1);

# 1 查询readers的reader_name列
SELECT readers.reader_name FROM readers;

# 2 查询id为前五行的reader_name
SELECT readers.reader_name  FROM readers
WHERE reader_id<=5 ;

# 3 查询id为前五行的reader_name,并按照id降序
SELECT readers.reader_id,readers.reader_name  FROM readers
WHERE reader_id<=5
ORDER BY reader_id DESC ;

# 4 查询id为前五行的reader_name,按照id降序,并从降序后的第三行开始读取两行
SELECT readers.reader_id,readers.reader_name  FROM readers
WHERE reader_id<=8
ORDER BY reader_id DESC
LIMIT 2,3; # 等价于 LIMIT 3 OFFSET 2

# 5 分组聚合,返回每个状态的书的最早/最晚借书时间
SELECT
    status,
    MAX(borrow_time) AS 最晚借书时间,
    MIN(borrow_time) AS 最早借书时间
FROM borrow_records
GROUP BY status ;

# 6 分组聚合,在每个状态的书的最早/最晚借书时间的基础上,再计算全表最早/最晚的结束时间
SELECT
    status,
    MAX(borrow_time) AS 最晚借书时间,
    MIN(borrow_time) AS 最早借书时间,
    MAX(MAX(borrow_time)) OVER() AS 全表最晚借书时间,
    MIN(MIN(borrow_time)) OVER() AS 全表最早借书时间
FROM borrow_records
GROUP BY status;

# 7 左外连接
SELECT books.book_id,borrow_records.status ,books.book_name FROM borrow_records
LEFT JOIN books on borrow_records.book_id = books.book_id;

# 8 ANY 子查询 价格大于'任意价格大于73的书的价格'  的id,状态,名字 (就是大于75，因为大于73的书最便宜的就是75块)
SELECT books.book_id,borrow_records.status ,books.book_name,books.price FROM borrow_records
LEFT JOIN books on borrow_records.book_id = books.book_id
WHERE books.price > ANY (SELECT books.price FROM books WHERE price>= 73);

# 9 ALL 子查询 大于 所有状态为1的书的价格 的书
SELECT books.book_id,borrow_records.status ,books.book_name FROM borrow_records
LEFT JOIN books on borrow_records.book_id = books.book_id
WHERE books.price > ALL (SELECT books.price FROM books WHERE status = 1);

# 10 EXISTS 查询存在借书记录未归还的书籍：
SELECT *
FROM books b
WHERE EXISTS (
    SELECT 1
    FROM borrow_records br
    WHERE br.book_id = b.book_id AND br.status = 1
);
