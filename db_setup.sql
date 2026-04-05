drop database auto_sales;
-- =============================================================
-- AUTO SALES DATABASE
-- =============================================================

CREATE DATABASE IF NOT EXISTS auto_sales;
USE auto_sales;

-- -------------------------------------------------------------
-- TABLE: product_lines
-- -------------------------------------------------------------
CREATE TABLE product_lines (
    product_line_id INT AUTO_INCREMENT PRIMARY KEY,
    product_line    VARCHAR(50) NOT NULL UNIQUE
);

-- -------------------------------------------------------------
-- TABLE: products
-- -------------------------------------------------------------
CREATE TABLE products (
    product_code    VARCHAR(20)     PRIMARY KEY,
    product_line_id INT             NOT NULL,
    msrp            DECIMAL(10,2)   NOT NULL,
    CONSTRAINT fk_product_line FOREIGN KEY (product_line_id) REFERENCES product_lines(product_line_id)
);

-- -------------------------------------------------------------
-- TABLE: customers
-- -------------------------------------------------------------
CREATE TABLE customers (
    customer_id         INT AUTO_INCREMENT PRIMARY KEY,
    customer_name       VARCHAR(100)    NOT NULL,
    contact_last_name   VARCHAR(50),
    contact_first_name  VARCHAR(50),
    phone               VARCHAR(30),
    address_line1       VARCHAR(150),
    city                VARCHAR(50),
    postal_code         VARCHAR(20),
    country             VARCHAR(50)
);

-- -------------------------------------------------------------
-- TABLE: orders
-- -------------------------------------------------------------
CREATE TABLE orders (
    order_number            INT             PRIMARY KEY,
    customer_id             INT             NOT NULL,
    order_date              DATE            NOT NULL,
    days_since_last_order   INT,
    status                  ENUM('Shipped','Disputed','In Process','Cancelled','On Hold','Resolved') NOT NULL,
    CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- -------------------------------------------------------------
-- TABLE: order_items
-- -------------------------------------------------------------
CREATE TABLE order_items (
    order_item_id       INT AUTO_INCREMENT PRIMARY KEY,
    order_number        INT             NOT NULL,
    order_line_number   INT             NOT NULL,
    product_code        VARCHAR(20)     NOT NULL,
    quantity_ordered    INT             NOT NULL,
    price_each          DECIMAL(10,2)   NOT NULL,
    sales               DECIMAL(12,2)   NOT NULL,
    deal_size           ENUM('Small','Medium','Large') NOT NULL,
    CONSTRAINT fk_item_order   FOREIGN KEY (order_number)  REFERENCES orders(order_number),
    CONSTRAINT fk_item_product FOREIGN KEY (product_code)  REFERENCES products(product_code),
    CONSTRAINT uq_order_line   UNIQUE (order_number, order_line_number)
);