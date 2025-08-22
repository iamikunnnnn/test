CREATE TABLE books(
    book_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    book_name VARCHAR(50) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    price DECIMAL(10,2) NOT NULL
);

CREATE TABLE readers(
    reader_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    reader_name VARCHAR(20) NOT NULL,
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