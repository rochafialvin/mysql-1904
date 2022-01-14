SHOW DATABASES;

CREATE DATABASE noodles;

USE noodles;

SHOW TABLES;

CREATE TABLE products(
	id INT AUTO_INCREMENT PRIMARY KEY, -- PRIMARY KEY harus adalah sebuah kolom yang nilainya unique, AUTO_INCREMENT agar nilai pada id bertambah secara otomatis
	variant VARCHAR(30), -- Varchar (string) dengan maksimal 30 karakter
    price DECIMAL(3, 2), -- Jumlah digit total yang dimiliki maksimal adalah tiga digit, dengan dua digit di belakang koma
    -- 3.50, 1.00
    -- DECIMAL (5, 2) -- Maksimal terdapat 5 digit, dengan 2 digit di belakang koma
    -- benar : 3.50 , 23.34, 234.99,
    -- salah : 7689.99
    origin VARCHAR(20)
);

CREATE TABLE customers(
	id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    gender ENUM('M', 'F'), -- ENUM memungkinkan kita untuk menentukan value apa saja yang dapat disimpan pada suatu kolom
	phone_number VARCHAR(13)
);


CREATE TABLE orders(
	id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT, -- FOREIGN KEY untuk customer
    product_id INT, -- FOREIGN KEY untuk product
    order_time DATETIME,
    -- kolom customer_id merupakan foreign key yang akan menyimpan data dari kolom id milik tabel customers
    CONSTRAINT FK_CustomerId FOREIGN KEY (customer_id) REFERENCES customers(id) ON UPDATE CASCADE ON DELETE SET NULL,
    -- kolom product_id merupakan foreign key yang akan menyimpan data dari kolom id milik tabel products
    CONSTRAINT FK_ProductId FOREIGN KEY (product_id) REFERENCES products(id) ON UPDATE CASCADE ON DELETE SET NULL
);