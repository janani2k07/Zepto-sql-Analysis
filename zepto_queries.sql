USE zepto_project;
-- 1.SELECT STATEMENT--------------------------------------
SELECT*
FROM zepto_sales_dataset

-- 2.sample data-------------------------------------------
SELECT*
FROM zepto_sales_dataset
LIMIT 12;

-- 3.count of rows------------------------------------------
SELECT COUNT(*)
FROM zepto_sales_dataset;

-- 4.distinct products---------------------------------------
SELECT DISTINCT City
FROM zepto_sales_dataset;

-- 5.count unique products-----------------------------------
SELECT COUNT(DISTINCT City)
AS unicity
FROM zepto_sales_dataset;

-- 6.Check NULL values---------------------------------------
SELECT COUNT(*) AS total_racords,
COUNT('Product Name') AS procount,
COUNT('Category') AS ccategory,
COUNT('City') AS ccity,
COUNT('Original Price') AS op,
COUNT('Current Price') AS cp,
COUNT('Discount') AS cdis,
COUNT('Orders') AS odd,
COUNT('Total Revenue') AS ctr,
COUNT('Influencer Active') AS cia
FROM zepto_sales_dataset;

-- 7.check duplicate products---------------------------------
SELECT City, COUNT(City) AS ccity
FROM zepto_sales_dataset
GROUP BY City
HAVING COUNT(City)>1;

-- 8.remove duplicate rows----------------------------------
SELECT 
COUNT(*) AS records
FROM zepto_sales_dataset
GROUP BY 'Product Name','Category','City','Original Price',
'Current Price','Discount','Orders','Total Revenue',
'Influencer Active'
HAVING COUNT(*)>1;

-- 9.check invalid price--------------------------------
SELECT *
FROM zepto_sales_dataset
WHERE 'Original Price' < 0 OR
'Current Price' < 0

-- 10.invalid discounts----------------------------------
SELECT *
FROM zepto_sales_dataset
WHERE Discount > 100

-- 11.top 10 city by orders------------------------------
SELECT City,Orders
FROM zepto_sales_dataset
ORDER BY Orders
LIMIT 10;


-- 12.top 10 city by revenue----------------------------
SELECT City, `Total Revenue`
FROM zepto_sales_dataset
ORDER BY `Total Revenue`
LIMIT 10;

-- 13.products with highest discount-------------------
select `Product Name`,Discount
FROM zepto_sales_dataset
ORDER BY Discount DESC
LIMIT 10;

-- 14.average original price--------------------------
SELECT AVG(`Original Price`) AS avgo
FROM zepto_sales_dataset;

-- 15.average current price---------------------------
SELECT AVG(`Current Price`) AS avgo
FROM zepto_sales_dataset;

-- 16.total orders------------------------------------
SELECT SUM(Orders) AS total_orders
FROM zepto_sales_dataset;

-- 17.total revenue------------------------------------
SELECT SUM(`total revenue`) AS total_revenue
FROM zepto_sales_dataset;

-- 18.number of products by category-------------------
SELECT category,COUNT(*) AS product_count
FROM zepto_sales_dataset
GROUP BY category;

-- 19.revenue by category--------------------------------
SELECT category,SUM(`total revenue`) AS total_revenue
FROM zepto_sales_dataset
GROUP BY category;

-- 20.order by category----------------------------------
SELECT category,SUM(`orders`) AS total_orders
FROM zepto_sales_dataset
GROUP BY category
ORDER BY total_orders DESC;

-- 21.AVERAGE DISCOUNT BY CATEGORY-------------------------
SELECT category,avg(`Discount`) AS avg_discount
FROM zepto_sales_dataset
GROUP BY category
ORDER BY avg_discount DESC;

-- 22.revenue by city---------------------------------------
SELECT city,sum(`Total Revenue`) AS total_revenue
FROM zepto_sales_dataset
GROUP BY city
ORDER BY total_revenue DESC;

-- 23.orders by city--------------------------------------
SELECT city,sum(`orders`) AS total_orders
FROM zepto_sales_dataset
GROUP BY city
ORDER BY total_orders DESC;

-- 24.top performing city----------------------------------
SELECT city,sum(`total revenue`) AS total_revenue
FROM zepto_sales_dataset
GROUP BY city
ORDER BY total_revenue DESC
LIMIT 1;

-- 25.most expensive product-----------------------------
SELECT 	`product name`,`original price`
FROM zepto_sales_dataset
ORDER BY `original price` DESC
LIMIT 10;

-- 27.cheapest product----------------------------------
SELECT 	`product name`,`Current price`
FROM zepto_sales_dataset
ORDER BY `current price` 
LIMIT 10;

-- 27.product with highest discount percentage-----------
SELECT 	`product name`,`discount`
FROM zepto_sales_dataset
ORDER BY `discount` DESC
LIMIT 10;

 -- 28.products with highest price difference-------------
SELECT `Product Name`,`Original Price`,`Current Price`,
(`Original Price` - `Current Price`) AS price_difference
FROM zepto_sales_dataset
ORDER BY `price_difference` DESC
LIMIT 10;

-- 29.products with high orders but low price-------------
SELECT `product name`,orders,`current price`
FROM zepto_sales_dataset
WHERE Orders >(SELECT AVG(Orders)
FROM zepto_sales_dataset)
AND `current price` < (SELECT AVG(`current price`)
FROM zepto_sales_dataset)
ORDER BY Orders DESC;

-- 30.influencer active products--------------------------
SELECT `product name`,`influencer active`
FROM zepto_sales_dataset
where `influencer active` = 'yes';

-- 31.revenue from ionfluencer active products-------------
SELECT SUM(`total revenue`) AS influencer_revenue
FROM zepto_sales_dataset
WHERE `influencer active` = 'yes';

-- 32.orders from influencer active products---------------
SELECT SUM(`orders`) AS influencer_orders
FROM zepto_sales_dataset
WHERE `influencer active` = 'yes';

-- 33.compare influencer vs non influencer products
SELECT `influencer active`,COUNT(*) AS product_count,
SUM(Orders) AS total_orders,
SUM(`total revenue`) AS total_revenue
FROM zepto_sales_dataset
GROUP BY `influencer active`;

-- 34.rank products by revenue------------------------
SELECT `product name`,`total revenue`,RANK() OVER(ORDER BY 
`TOTAL REVENUE` DESC) AS revenue_rank
FROM zepto_sales_dataset;

-- 35.rank products within each category----------------
SELECT `category`,`product name`,`total revenue`,RANK() OVER
(PARTITION BY category ORDER BY `TOTAL REVENUE` DESC) 
AS revenue_rank
FROM zepto_sales_dataset;

-- 36.top 3 products in each category-----------------
SELECT category,`product name`,`total revenue`
FROM (SELECT category,`product name`,`total revenue`,RANK() 
OVER(PARTITION BY category ORDER BY `total revenue` DESC)
AS revenue_rank
FROM zepto_sales_dataset) AS ranked_product
WHERE revenue_rank <= 3;

-- 37.city wise revenue ranking-----------------------
SELECT city,SUM(`total revenue`) AS total_revenue,
RANK() OVER(ORDER BY SUM(`total revenue`) DESC ) AS revenue_rank
FROM zepto_sales_dataset
GROUP BY city;

-- 38.revenue contribution percentage-----------------
SELECT category,
SUM(`total revenue`) AS total_revenue,
ROUND(SUM(`TOTAL REVENUE`)*100/(SELECT SUM(`total revenue`)
FROM zepto_sales_dataset),2) AS revenue_percentage
FROM zepto_sales_dataset
GROUP BY category
order by revenue_percentage desc;

-- 39.categorize products by orders------------------
SELECT `product name`,`orders`,
CASE 
    WHEN Orders >= 100 THEN 'HIGH'
	WHEN Orders >= 50 THEN 'MEDIUM'
ELSE 'LOW'
END AS order_category
FROM zepto_sales_dataset;

-- 40.dense rank-----------------------------------
SELECT city,SUM(`total revenue`) AS total_revenue,
DENSE_RANK() OVER(ORDER BY SUM(`total revenue`) DESC ) AS revenue_rank
FROM zepto_sales_dataset
GROUP BY city;

-- create table------------------------------------
 SELECT DISTINCT `product name`
FROM zepto_sales_dataset
LIMIT 10;

-- INSERT PRODUCT DETAILS-----------------------------
INSERT INTO product_details
(product_name, brand, ratinng, supplier)
VALUES
('Britannia cake', 'Britannia', 4.3, 'ABC Foods'),
('Fortune oil 1L', 'Fortune', 4.2, 'Adani Wilmar'),
('Pepsi 500ml', 'Pepsi', 4.4, 'PepsiCo'),
('Aashirvaad Atta', 'Aashirvaad', 4.5, 'ITC Foods'),
('Amul Milk 500ml', 'Amul', 4.6, 'Amul Dairy'),
('Maggi Noodles', 'Maggi', 4.5, 'Nestle India'),
('Oreo Biscuits', 'Oreo', 4.4, 'Mondelez'),
('Coca Cola 1L', 'Coca Cola', 4.3, 'Coca Cola India'),
('Parle-G', 'Parle', 4.2, 'Parle Products'),
('Nestle Munch', 'Nestle', 4.4, 'Nestle India');

select * from product_details;

==========================================================
=================JOINS====================================

-- -41.inner join--------------------------------
SELECT Z.`product name`,Z.orders,Z.`total revenue`,
P.brand,P.ratinng,P.supplier
FROM zepto_sales_dataset Z
INNER JOIN product_details P
ON Z.`product name` = P.product_name;

-- -42.left join---------------------------------
SELECT Z.`product name`,Z.orders,Z.`total revenue`,
P.brand,P.ratinng,P.supplier
FROM zepto_sales_dataset Z
LEFT JOIN product_details P
ON Z.`product name` = P.product_name;

-- 43.RIGHT JOIN-----------------------------
SELECT Z.`product name`,Z.orders,Z.`total revenue`,
P.brand,P.ratinng,P.supplier
FROM zepto_sales_dataset Z
RIGHT JOIN product_details P
ON Z.`product name` = P.product_name;

-- 44.REVENUE BY BRAND USING JOIN--------------
SELECT P.brand,SUM(Z.`total revenue`) AS total_revenue
FROM zepto_sales_dataset Z
INNER JOIN product_details P
ON Z.`product name` = P.product_name
GROUP BY P.brand
ORDER BY total_revenue DESC;

-- 45.BRANDS WITH REVENUE > 10000--------------------
SELECT p.brand,SUM(z.`total revenue`) AS total_revenue
FROM zepto_sales_dataset z
INNER JOIN product_details p
ON z.`product name` = p.product_name
GROUP BY p.brand
HAVING SUM(z.`total revenue`) > 10000
ORDER BY total_revenue DESC;

-- 46.PRODUCTS ABOVE AVERAGE REVENUE-----------------
SELECT z.`product name`,
       p.brand,
       z.`total revenue`
FROM zepto_sales_dataset z
INNER JOIN product_details p
ON z.`product name` = p.product_name
WHERE z.`total revenue` > (
    SELECT AVG(`total revenue`)
    FROM zepto_sales_dataset
)
ORDER BY z.`total revenue` DESC;

-- 47. CLASSIFY PRODUCTS BY REVENUE---------------------
SELECT z.`product name`,
       p.brand,
       z.`total revenue`,
       CASE
           WHEN z.`total revenue` > (
               SELECT AVG(`total revenue`)
               FROM zepto_sales_dataset
           )
           THEN 'High Revenue'
           ELSE 'Low Revenue'
       END AS revenue_category
FROM zepto_sales_dataset z
INNER JOIN product_details p
ON z.`product name` = p.product_name;

-- 48.RANK PRODUCTS WITHIN EACH BRAND------------------
SELECT p.brand,
       z.`product name`,
       z.`total revenue`,
       DENSE_RANK() OVER (
           PARTITION BY p.brand
           ORDER BY z.`total revenue` DESC
       ) AS revenue_rank
FROM zepto_sales_dataset z
INNER JOIN product_details p
ON z.`product name` = p.product_name;

-- 49.TOP PRODUCT IN EACH BRAND---------------------
SELECT brand,
       `product name`,
       `total revenue`,
       revenue_rank
FROM (
    SELECT p.brand,
           z.`product name`,
           z.`total revenue`,
           DENSE_RANK() OVER (
               PARTITION BY p.brand
               ORDER BY z.`total revenue` DESC
           ) AS revenue_rank
    FROM zepto_sales_dataset z
    INNER JOIN product_details p
    ON z.`product name` = p.product_name
) AS ranked_products
WHERE revenue_rank = 1;

-- 50.FINAL BRAND PERFORMANCE ANALYSIS-------------
SELECT p.brand,
       SUM(z.orders) AS total_orders,
       SUM(z.`total revenue`) AS total_revenue,
       ROUND(AVG(p.ratinng), 2) AS average_rating,
       DENSE_RANK() OVER (
           ORDER BY SUM(z.`total revenue`) DESC
       ) AS revenue_rank
FROM zepto_sales_dataset z
INNER JOIN product_details p
ON z.`product name` = p.product_name
GROUP BY p.brand
ORDER BY revenue_rank;

SET SQL_SAFE_UPDATES = 0;

-- 51.COMMIT-----------------------------------------
START TRANSACTION;
UPDATE zepto_sales_dataset
SET `Current Price` = 100
WHERE `Product Name` = 'Fortune Oil 1L';
COMMIT;

-- 52.ROLLBACK----------------------------------------
START TRANSACTION;
UPDATE zepto_sales_dataset
SET `Current Price` = 88
WHERE `Product Name` = 'Fortune Oil 1L';

-- 53.SAVEPOINT-----------------------------------------
START TRANSACTION;
UPDATE zepto_sales_dataset
SET `Current Price` = 99
WHERE `Product Name` = 'Pepsi 500ml';
SAVEPOINT price_change;
UPDATE zepto_sales_dataset
SET `Current Price` = 89
WHERE `Product Name` = 'Pepsi 500ml';
ROLLBACK TO price_change;
COMMIT;

-- 54.ROLLBACK TO SAVEPOINT----------------------
START TRANSACTION;
UPDATE zepto_sales_dataset
SET `Current Price` = 99
WHERE `Product Name` = 'Pepsi 500ml';
SAVEPOINT price_change;
UPDATE zepto_sales_dataset
SET `Current Price` = 89
WHERE `Product Name` = 'Pepsi 500ml';
ROLLBACK TO SAVEPOINT price_change;
COMMIT;

-- 55.TRUNCATE------------------------------------
CREATE TABLE truncate_demoo (
    id INT,
    stuname VARCHAR(50)
);
INSERT INTO truncate_demoo VALUES
(1, 'Janani'),
(2, 'Priya'),
(3, 'Anu');
SELECT * FROM truncate_demoo;
TRUNCATE TABLE truncate_demoo;
SELECT * FROM truncate_demoo;
 
 -- 56.ALTER TABLE-ADD COLUMN--------------------------
 ALTER TABLE zepto_sales_dataset
 ADD COLUMN stock_available int;
 
 DESCRIBE zepto_sales_dataset;
 
 -- 57.ALTER TABLE-MODIFY COLUMN-------------------------
 ALTER TABLE zepto_sales_dataset
 MODIFY COLUMN stock_available BIGINT;
 DESCRIBE zepto_sales_dataset;
 
 -- 58.ALTER TABLE-RENAME COLUMN-------------------------
 ALTER TABLE zepto_sales_dataset
 RENAME COLUMN stock_available TO available_stock;
 
 DESCRIBE zepto_sales_dataset;
 
-- 59.DROP TABLE------------------------------------------

CREATE TABLE drop_demo (
    id INT,
    name VARCHAR(50)
);

INSERT INTO drop_demo VALUES
(1, 'Janani'),
(2, 'Priya');

SELECT * FROM drop_demo;
DROP TABLE drop_demo;

-- 60.CREATE INDEX--------------------------------------
CREATE INDEX idx_product_name
on zepto_sales_dataset(City(100));

-- 61.CHECK/VIEW INDEX-----------------------------------
SHOW INDEX FROM zepto_sales_dataset;

-- 62,CREATE VIEW----------------------------------------
CREATE VIEW zepto_product_summary AS
SELECT
    `Product Name`,
    category,
    city,
    `Current Price`,
    orders,
    `Total Revenue`
FROM zepto_sales_dataset;

SHOW FULL TABLES;
SELECT *
FROM zepto_product_summary;

-- 63.CREATE PROCEDURE-------------------------------------
DELIMITER //
CREATE PROCEDURE get_products_by_cityy(IN city_name VARCHAR(100))
BEGIN
    SELECT category, orders
    FROM zepto_sales_dataset
    WHERE city = city_name;
END //
DELIMITER ;

-- 64.CALL PROCEDURE--------------------------------------
CALL get_products_by_cityy('Bangalore');

-- 65.GRANT------------------------------------------------
GRANT SELECT
ON zepto_project.zepto_sales_dataset
TO 'Janani'@'localhost';

-- 66.REVOKE-----------------------------------------------
REVOKE SELECT
ON zepto_project.zepto_sales_dataset
FROM 'Janani'@'localhost';

============================================================
================DATE AND TIME FUNCTIONS=====================

-- 67.DATE FUNCTIONS----------------------------------------
CREATE TABLE date_demo (
    id INT,
    product_name VARCHAR(100),
    sale_date DATE
);

INSERT INTO date_demo VALUES
(1, 'Pepsi 500ml', '2026-08-01'),
(2, 'Oreo Biscuits', '2026-08-05'),
(3, 'Maggi Noodles', '2026-08-10');

SELECT
    product_name,
    sale_date,
    CURDATE() AS today,
    YEAR(sale_date) AS sale_year,
    MONTH(sale_date) AS sale_month,
    DAY(sale_date) AS sale_day
FROM date_demo;

-- 68.TIME FUNCTIONS--------------------------------------
ALTER TABLE date_demo
ADD COLUMN sale_time TIME;

UPDATE date_demo
SET sale_time = '10:30:45'
WHERE id = 1;

UPDATE date_demo
SET sale_time = '14:15:20'
WHERE id = 2;

UPDATE date_demo
SET sale_time = '18:45:10'
WHERE id = 3;

SELECT
    product_name,
    sale_time,
    CURTIME() AS NOW_time,
    HOUR(sale_time) AS sale_hour,
    MINUTE(sale_time) AS sale_minute,
    SECOND(sale_time) AS sale_second
FROM date_demo;

-- 69. DATE CALCULATIONS--------------------------------
SELECT
    product_name,
    sale_date,
    DATEDIFF(CURDATE(), sale_date) AS days_difference,
    DATE_ADD(sale_date, INTERVAL 7 DAY) AS after_7_days,
    DATE_SUB(sale_date, INTERVAL 7 DAY) AS before_7_days
FROM date_demo;
 
-- 70. DATE_FORMAT()--------------------------------------
SELECT
    product_name,
    sale_date,
    DATE_FORMAT(sale_date, '%d-%m-%Y') AS formatted_date,
    DATE_FORMAT(sale_date, '%M %Y') AS month_year
FROM date_demo;

-- =========================================================
-- =========================================================


