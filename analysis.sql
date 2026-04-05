-- Which products generate the most revenue?
SELECT
	product_code,
    SUM(quantity_ordered * price_each) AS revenue
FROM order_items
GROUP BY product_code
ORDER BY revenue DESC;

-- Which products are ordered the most often?
SELECT 
	 product_code,
    SUM(quantity_ordered) AS total_ordered,
    RANK() OVER (ORDER BY SUM(quantity_ordered) DESC) AS product_rank
FROM order_items
GROUP BY product_code
ORDER BY total_ordered DESC;

-- Who are the top 20% of customers?
WITH customer_revenue AS (
	SELECT
		c.customer_id,
		c.customer_name,
		SUM(oi.quantity_ordered * oi.price_each) AS revenue
	FROM customers AS c
	LEFT JOIN orders AS o
	ON c.customer_id = o.customer_id
	LEFT JOIN order_items AS oi
	ON o.order_number = oi.order_number
	GROUP BY customer_id) 
 
SELECT *
FROM ( 
	SELECT 
		customer_id,
		customer_name,
        revenue,
		NTILE(5) OVER (ORDER BY revenue DESC) AS top_twenty_percent
	FROM customer_revenue) AS top_customers
WHERE top_twenty_percent = 1
ORDER BY revenue DESC;

-- Which country has the most customers?
SELECT
    country,
    COUNT(customer_id) AS number_of_customers
FROM customers
GROUP BY country
ORDER BY number_of_customers DESC;

-- Find the top five cities with the most customers
SELECT
    country,
    city,
    COUNT(customer_id) AS number_of_customers
FROM customers
GROUP BY country, city
ORDER BY number_of_customers DESC;

-- Which product line generates the most revenue?
WITH order_revenue AS (
	SELECT 
		product_code,
        SUM(quantity_ordered * price_each) AS revenue
	FROM order_items
    GROUP BY product_code),

product_line_revenue AS (
SELECT
	pl.product_line_id,
    pl.product_line,
    SUM(orev.revenue) AS total_revenue
FROM product_lines AS pl
LEFT JOIN products AS p
ON p.product_line_id = pl.product_line_id
LEFT JOIN order_revenue AS orev
ON p.product_code = orev.product_code
GROUP BY product_line_id)

SELECT
	product_line_id,
    product_line,
    total_revenue,
    RANK () OVER (ORDER BY total_revenue DESC) AS revenue_rank
FROM product_line_revenue
ORDER BY revenue_rank;

-- What product generates the most revenue?
WITH order_revenue AS (
	SELECT 
		product_code,
        SUM(quantity_ordered * price_each) AS revenue
	FROM order_items
    GROUP BY product_code)

SELECT 
	product_code,
    revenue,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM order_revenue
GROUP BY product_code
ORDER BY revenue_rank;

-- Which products are sold in the highest quantity?

WITH products_sold AS (
	SELECT
		p.product_code,
        COUNT(p.product_code) AS number_sold
	FROM products AS p
	LEFT JOIN order_items AS oi
	ON p.product_code = oi.product_code
	LEFT JOIN orders AS o
	ON oi.order_number = o.order_number
    GROUP BY p.product_code)

SELECT 
	product_code,
    number_sold,
    RANK() OVER (ORDER BY number_sold DESC) AS product_sales_rank
FROM products_sold
GROUP BY product_code;