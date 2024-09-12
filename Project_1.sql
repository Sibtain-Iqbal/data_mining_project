use onlineretailsegmentation;
describe online_retail;

--      What is the distribution of order values across all customers in the dataset?

SELECT CustomerID, SUM(Quantity * UnitPrice) AS OrderValue
FROM online_retail
GROUP BY CustomerID;

 -- How many unique products has each customer purchased?
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProducts
FROM online_retail
GROUP BY CustomerID;

-- Which customers have only made a single purchase from the company?
SELECT CustomerID
FROM online_retail
GROUP BY CustomerID
HAVING COUNT(DISTINCT StockCode) = 1;

-- select InvoiceNo from online_retail where CustomerID = '12748';
-- select InvoiceNo from online_retail where CustomerID = '12748';


-- Which products are most commonly purchased together by customers in the dataset?

SELECT CustomerID,COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency,
       CASE 
          WHEN COUNT(DISTINCT InvoiceNo) > 10 THEN 'High Frequency'
          WHEN COUNT(DISTINCT InvoiceNo) BETWEEN 5 AND 10 THEN 'Medium Frequency'
          ELSE 'Low Frequency'
       END AS FrequencySegment
FROM online_retail
GROUP BY CustomerID;

--    Which products are most commonly purchased together by customers in the dataset?

SELECT p1.StockCode AS Product1, p2.StockCode AS Product2, COUNT(*) AS PairCount
FROM online_retail p1
JOIN online_retail p2 
  ON p1.InvoiceNo = p2.InvoiceNo 
 AND p1.StockCode != p2.StockCode
GROUP BY p1.StockCode, p2.StockCode
ORDER BY PairCount DESC;


-- 1.      Customer Segmentation by Purchase Frequency

SELECT CustomerID, 
       COUNT(DISTINCT InvoiceNo) AS PurchaseFrequency,
       CASE 
          WHEN COUNT(DISTINCT InvoiceNo) > 10 THEN 'High Frequency'
          WHEN COUNT(DISTINCT InvoiceNo) BETWEEN 5 AND 10 THEN 'Medium Frequency'
          ELSE 'Low Frequency'
       END AS FrequencySegment
FROM online_retail
GROUP BY CustomerID;

--  Average Order Value by CountryCalculate the average order value for each country to identify where your most valuable customers are located.


SELECT Country, 
       AVG(Quantity * UnitPrice) AS AvgOrderValue
FROM online_retail
GROUP BY Country
ORDER BY AvgOrderValue DESC;

-- 4Determine which products are often purchased together by calculating the correlation between product purchases.

SELECT p1.StockCode AS Product1, p2.StockCode AS Product2, COUNT(*) AS PairCount
FROM online_retail p1
JOIN online_retail p2 
  ON p1.InvoiceNo = p2.InvoiceNo 
 AND p1.StockCode != p2.StockCode
GROUP BY p1.StockCode, p2.StockCode
ORDER BY PairCount DESC;


--  5. Time-based Analysis Explore trends in customer behavior over time, such as monthly or quarterly sales patterns.
 
--  Monthly Sales:

SELECT YEAR(InvoiceDate) AS Year, MONTH(InvoiceDate) AS Month, SUM(Quantity * UnitPrice) AS TotalSales
FROM online_retail
GROUP BY YEAR(InvoiceDate), MONTH(InvoiceDate)
ORDER BY Year, Month;

--  Quarterly Sales:

SELECT YEAR(InvoiceDate) AS Year, QUARTER(InvoiceDate) AS Quarter, SUM(Quantity * UnitPrice) AS TotalSales
FROM online_retail
GROUP BY YEAR(InvoiceDate), QUARTER(InvoiceDate)
ORDER BY Year, Quarter;

