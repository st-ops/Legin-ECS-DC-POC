ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root';

USE products;


CREATE TABLE products (
    name VARCHAR(255) NOT NULL,
    price INT NOT NULL,
    amount INT NOT NULL
);
