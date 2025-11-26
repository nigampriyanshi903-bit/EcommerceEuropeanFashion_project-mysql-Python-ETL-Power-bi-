#task1:Total sales per country
SELECT country, SUM(total_amount) AS total_sales
FROM sales
GROUP BY country
ORDER BY total_sales DESC;
#task2:Total sales per channel
SELECT channel, SUM(total_amount) AS total_sales
FROM sales
GROUP BY channel
ORDER BY total_sales DESC;
#task3:Total sales per customer age range
SELECT c.age_range, SUM(s.total_amount) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.age_range
ORDER BY total_sales DESC;
#task4:Average sales per customer
SELECT AVG(customer_total) AS avg_sales_per_customer
FROM (
    SELECT customer_id, SUM(total_amount) AS customer_total
    FROM sales
    GROUP BY customer_id
) AS sub;
#task5:Total sales per month
SELECT DATE_FORMAT(sale_date, '%Y-%m') AS month, SUM(total_amount) AS total_sales
FROM sales
GROUP BY month
ORDER BY month;
#task6:Percentage of discounted vs non-discounted sales
SELECT discounted, COUNT(*) AS num_sales, 
       ROUND((COUNT(*) / (SELECT COUNT(*) FROM sales)) * 100, 2) AS percentage
FROM sales
GROUP BY discounted;

#task7:Top 10 customers by total purchase
SELECT c.customer_id, SUM(s.total_amount) AS total_purchase
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_purchase DESC
LIMIT 10;
#task8:Total sales per campaign (if applicable)
SELECT c.campaign_name, SUM(s.total_amount) AS total_sales
FROM sales s
JOIN campaigns c ON s.customer_id = c.campaign_id
GROUP BY c.campaign_name
ORDER BY total_sales DESC;
#task9:New customer signups per month
SELECT DATE_FORMAT(signup_date, '%Y-%m') AS month, COUNT(*) AS new_customers
FROM customers
GROUP BY month
ORDER BY month;

#task10:Customer distribution by country
SELECT country, COUNT(*) AS num_customers
FROM customers
GROUP BY country
ORDER BY num_customers DESC;
#task11:Top 10 best-selling products (by quantity)
SELECT p.product_name, SUM(si.quantity) AS total_quantity_sold
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY si.product_id
ORDER BY total_quantity_sold DESC
LIMIT 10;

#task12:Top 10 products by total sales amount
SELECT p.product_name, SUM(si.item_total) AS total_sales_amount
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY si.product_id
ORDER BY total_sales_amount DESC
LIMIT 10;

#task13:Total sales per product category
SELECT p.category, SUM(si.item_total) AS total_sales
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC;

#task14:Average discount percent per category

SELECT p.category, AVG(CAST(REPLACE(si.discount_percent, '%','') AS DECIMAL(5,2))) AS avg_discount_percent
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.category
ORDER BY avg_discount_percent DESC;

#task15:Stock quantity per product per country
SELECT p.product_name, s.country, s.stock_quantity
FROM stock s
JOIN products p ON s.product_id = p.product_id
ORDER BY s.country, s.stock_quantity DESC;

#task16:Products running low in stock (<50 units)
SELECT p.product_name, s.country, s.stock_quantity
FROM stock s
JOIN products p ON s.product_id = p.product_id
WHERE s.stock_quantity < 50
ORDER BY s.stock_quantity ASC;

#task17:Total sales per brand
SELECT p.brand, SUM(si.item_total) AS total_sales
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.brand
ORDER BY total_sales DESC;

#task18:Top 5 colors sold per category
SELECT p.category, p.color, SUM(si.quantity) AS total_sold
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.category, p.color
ORDER BY p.category, total_sold DESC;

#19:Top-selling size per gender
SELECT p.gender, p.size, SUM(si.quantity) AS total_sold
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.gender, p.size
ORDER BY p.gender, total_sold DESC;

#20:Average unit price per category
SELECT p.category, AVG(si.unit_price) AS avg_unit_price
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.category
ORDER BY avg_unit_price DESC;

#Campaigns & Channel Analysis
#21:Total sales per campaign
SELECT si.channel_campaigns AS campaign_name, SUM(si.item_total) AS total_sales
FROM salesitems si
GROUP BY si.channel_campaigns
ORDER BY total_sales DESC;


#22:Top 5 campaigns by number of items sold

SELECT si.channel_campaigns AS campaign_name, SUM(si.quantity) AS total_items_sold
FROM salesitems si
GROUP BY si.channel_campaigns
ORDER BY total_items_sold DESC
LIMIT 5;
#task23:Average discount percent per campaign
SELECT si.channel_campaigns AS campaign_name, 
       AVG(CAST(REPLACE(si.discount_percent, '%','') AS DECIMAL(5,2))) AS avg_discount
FROM salesitems si
GROUP BY si.channel_campaigns
ORDER BY avg_discount DESC;

#24:Total sales per channel
SELECT si.channel, SUM(si.item_total) AS total_sales
FROM salesitems si
GROUP BY si.channel
ORDER BY total_sales DESC;

#25:Top 3 channels by number of orders
SELECT s.channel, COUNT(*) AS total_orders
FROM sales s
GROUP BY s.channel
ORDER BY total_orders DESC
LIMIT 3;

#26:Campaign performance per channel

SELECT si.channel, si.channel_campaigns AS campaign_name, SUM(si.item_total) AS total_sales
FROM salesitems si
GROUP BY si.channel, si.channel_campaigns
ORDER BY si.channel, total_sales DESC;


#27:Discounted vs non-discounted sales per channel
SELECT si.channel, si.discounted, COUNT(*) AS total_sales_count
FROM salesitems si
GROUP BY si.channel, si.discounted
ORDER BY si.channel;

#28:Average item total per channel
SELECT si.channel, AVG(si.item_total) AS avg_item_total
FROM salesitems si
GROUP BY si.channel
ORDER BY avg_item_total DESC;

#29:Monthly sales per channel
SELECT si.channel, DATE_FORMAT(si.sale_date, '%Y-%m') AS month, SUM(si.item_total) AS monthly_sales
FROM salesitems si
GROUP BY si.channel, month
ORDER BY si.channel, month;
#30:Campaigns running in a specific channel
SELECT DISTINCT si.channel_campaigns AS campaign_name, si.channel
FROM salesitems si
WHERE si.channel = 'Online';  -- Replace 'Online' with any channel

#31:Top 10 countries by total sales

SELECT s.country, SUM(si.item_total) AS total_sales
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.country
ORDER BY total_sales DESC
LIMIT 10;
#Customer & Country Analysis
#31:Top 10 countries by total sales
SELECT s.country, SUM(si.item_total) AS total_sales
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.country
ORDER BY total_sales DESC
LIMIT 10;

#32:Top 5 countries by number of customers
SELECT country, COUNT(*) AS total_customers
FROM customers
GROUP BY country
ORDER BY total_customers DESC
LIMIT 5;

#33:Total sales per country per month
SELECT s.country, DATE_FORMAT(si.sale_date, '%Y-%m') AS month, SUM(si.item_total) AS monthly_sales
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.country, month
ORDER BY s.country, month;

#34:Average purchase per customer per country
SELECT s.country, s.customer_id, SUM(si.item_total) AS total_purchase
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.country, s.customer_id
ORDER BY s.country, total_purchase DESC;

#35:Number of new customers per month
SELECT DATE_FORMAT(signup_date, '%Y-%m') AS month, COUNT(*) AS new_customers
FROM customers
GROUP BY month
ORDER BY month;
#36:Customer distribution by age range per country
SELECT country, age_range, COUNT(*) AS num_customers
FROM customers
GROUP BY country, age_range
ORDER BY country, num_customers DESC;

#37:Top 10 customers by total purchase amount
SELECT s.customer_id, SUM(si.item_total) AS total_purchase
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.customer_id
ORDER BY total_purchase DESC
LIMIT 10;

#38:Percentage of discounted items sold per country
SELECT s.country, 
       ROUND(SUM(si.discounted)/COUNT(*)*100,2) AS percent_discounted
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.country
ORDER BY percent_discounted DESC;
#39:Average order value per country
SELECT s.country, AVG(si.item_total) AS avg_order_value
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
GROUP BY s.country
ORDER BY avg_order_value DESC;
#40:Top-selling products per country
SELECT s.country, p.product_name, SUM(si.quantity) AS total_quantity_sold
FROM salesitems si
JOIN sales s ON si.sale_id = s.sale_id
JOIN products p ON si.product_id = p.product_id
GROUP BY s.country, p.product_name
ORDER BY s.country, total_quantity_sold DESC;
#41:Total discount amount given per campaign
SELECT si.channel_campaigns AS campaign_name, SUM(si.discount_applied) AS total_discount
FROM salesitems si
GROUP BY si.channel_campaigns
ORDER BY total_discount DESC;
#42:Average discount percent per product category
SELECT p.category, AVG(CAST(REPLACE(si.discount_percent, '%','') AS DECIMAL(5,2))) AS avg_discount_percent
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.category
ORDER BY avg_discount_percent DESC;

#43:Profit per product
SELECT p.product_name, SUM((si.unit_price - p.cost_price) * si.quantity) AS total_profit
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_profit DESC;
#44:Top 10 most profitable products
SELECT p.product_name, SUM((si.unit_price - p.cost_price) * si.quantity) AS total_profit
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_profit DESC
LIMIT 10;
#45:Total sales per gender
SELECT p.gender, SUM(si.item_total) AS total_sales
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.gender
ORDER BY total_sales DESC;
#46:Top 5 brands by profit
SELECT p.brand, SUM((si.unit_price - p.cost_price) * si.quantity) AS total_profit
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.brand
ORDER BY total_profit DESC
LIMIT 5;
#47:Total items sold per size
SELECT p.size, SUM(si.quantity) AS total_sold
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.size
ORDER BY total_sold DESC;
#48:Total sales from discounted items vs non-discounted items
SELECT si.discounted, SUM(si.item_total) AS total_sales
FROM salesitems si
GROUP BY si.discounted;
#49:Monthly profit per product category
SELECT p.category, DATE_FORMAT(si.sale_date, '%Y-%m') AS month, 
       SUM((si.unit_price - p.cost_price) * si.quantity) AS monthly_profit
FROM salesitems si
JOIN products p ON si.product_id = p.product_id
GROUP BY p.category, month
ORDER BY p.category, month;
#50:Stock coverage: items in stock vs items sold
SELECT p.product_name, s.country, s.stock_quantity, 
       IFNULL(SUM(si.quantity), 0) AS total_sold,
       (s.stock_quantity - IFNULL(SUM(si.quantity),0)) AS remaining_stock
FROM stock s
JOIN products p ON s.product_id = p.product_id
LEFT JOIN salesitems si ON si.product_id = p.product_id AND si.channel = s.country
GROUP BY s.country, p.product_id
ORDER BY remaining_stock ASC;



