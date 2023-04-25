CREATE DATABASE EDA_supermarket_sales;
/* Attribute information
Invoice id: Computer generated sales slip invoice identification number
Branch: Branch of supercenter (3 branches are available identified by A, B and C).
City: Location of supercenters
Customer type: Type of customers, recorded by Members for customers using member card and Normal for without member card.
Gender: Gender type of customer
Product line: General item categorization groups - Electronic accessories, Fashion accessories, Food and beverages, Health and beauty, Home and lifestyle, Sports and travel
Unit price: Price of each product in $
Quantity: Number of products purchased by customer
Tax: 5% tax fee for customer buying
Total: Total price including tax
Date: Date of purchase (Record available from January 2019 to March 2019)
Time: Purchase time (10am to 9pm)
Payment: Payment used by customer for purchase (3 methods are available – Cash, Credit card and Ewallet)
COGS: Cost of goods sold
Gross margin percentage: Gross margin percentage
Gross income: Gross income
Rating: Customer stratification rating on their overall shopping experience (On a scale of 1 to 10)
*/


-- 1. Display the first 5 rows from the dataset

SELECT * from supermarket_sales LIMIT 5 ;


-- 2. Display the last 5 rows from the dataset

SELECT grossincome FROM supermarket_sales
ORDER BY 'Invoice ID' DESC LIMIT 5;



-- 3. Display random 5 rows from the dataset

SELECT * FROM supermarket_sales ORDER BY rand() LIMIT 5;   # This will give us random values each time when executed.

-- 4. Display count,min,max,and std values for a column in the dataset.

-- UNIVARIATE ANALYSIS
SELECT COUNT(grossincome) AS total,
min(grossincome) AS min_value,
avg(grossincome) AS avg_value, 
std(grossincome) AS std_deviation
 FROM supermarket_sales;

-- 5. Find the number of missing values. 

SELECT COUNT(*) FROM supermarket_sales
WHERE branch IS NULL;    # This means there is no null value in the dataset.



-- 6. Count the number of occurences of each city

SELECT city,COUNT(city) FROM supermarket_sales
GROUP BY city;

-- 7. Find the most frequently used payment method.

SELECT payment ,COUNT(payment) AS total_count FROM supermarket_sales
GROUP BY payment
ORDER BY total_count DESC;

-- 8. Does the cost of goods sold affect the ratings that the customers provide?

SELECT rating,cogs FROM supermarket_sales;  # We can also visualize this in excel or google sheet



-- 9. Find the  most profitable branch as per gross income.

SELECT branch, ROUND(SUM(grossincome),2) AS sum_gross_income
FROM supermarket_sales
GROUP BY branch
ORDER BY sum_gross_income DESC;



-- 10. Find the most used payment method city-wise

SELECT city,
	   SUM(CASE WHEN payment="Cash" THEN 1 ELSE 0 END) AS "Cash",
       SUM(CASE WHEN PAYMENT="Ewallet" THEN 1 ELSE 0 END) AS "Ewallet",
       SUM(CASE WHEN payment="Credit card" THEN 1 ELSE 0 END) "Credit card"
FROM supermarket_sales
GROUP BY city;    # We can also visualize this using MS-Excel or Google Sheets 


-- 11. Find the product line purchased in the highest quantity

SELECT `Product line`, SUM(Quantity) AS total_quantity FROM supermarket_sales
GROUP BY `Product line`
ORDER BY total_quantity DESC;  # We can also visualize this using MS-Excel or Google Sheets


-- 12. Display the daily sales by day of the week
UPDATE supermarket_sales
SET date =str_to_date(Date,'%m/%d/%Y');

SELECT dayname(date), dayofweek(date), SUM(total)  FROM supermarket_sales
GROUP BY dayofweek(date),dayname(date);


-- 13. Find the month with the highest sales

SELECT MONTHNAME(date) AS month_name, MONTH(date) AS  month, SUM(Total) as total FROM supermarket_sales
GROUP BY month_name, month ORDER BY total DESC;  # We can also visualize this using MS-Excel or Google Sheets


-- 14. Find the time at which sales are highest

SELECT HOUR(Time) AS hour, SUM(total) AS total_sales FROM supermarket_sales
GROUP BY hour 
ORDER BY total_sales DESC;


-- 15. Which gender spends more on average?

SELECT Gender, AVG(grossincome) AS avg_spending FROM supermarket_sales
GROUP BY Gender;  # We can also visualize this using MS-Excel or Google Sheets



