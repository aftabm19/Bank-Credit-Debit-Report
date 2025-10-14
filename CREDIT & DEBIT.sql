/*1-Total Credit Amount:*/
SELECT SUM(Amount) AS Total_Credit_Amount
FROM `debit and credit banking_data`
WHERE `Transaction Type` = 'Credit';

/*2-Total Debit Amount:*/
select sum(Amount) As 'Total Debit Amount'
From `debit and credit banking_data`
WHERE `Transaction Type` = 'Debit';

/*3-Credit to Debit Ratio:*/
SELECT 
    (SUM(CASE WHEN `Transaction Type`= 'Credit' THEN Amount ELSE 0 END) * 1.0) /
    NULLIF(SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END), 0) 
    AS Credit_Debit_Ratio
FROM `debit and credit banking_data`;

/*4-Net Transaction Amount:*/
SELECT 
    SUM(CASE WHEN `Transaction Type` = 'Credit' THEN Amount ELSE 0 END) -
    SUM(CASE WHEN `Transaction Type` = 'Debit' THEN Amount ELSE 0 END) 
    AS Net_Transaction_Amount
FROM `debit and credit banking_data`;

/*5-Account Activity Ratio:*/
SELECT 
    `Customer Name`,
    COUNT(`Account Number`) * 1.0 / AVG(`Balance`) AS Account_Activity_Ratio
FROM `debit and credit banking_data`
GROUP BY `Customer Name`
ORDER BY Account_Activity_Ratio DESC
LIMIT 10;

/*6-Transactions per Day/Week/Month:*/
-- per Day 
SELECT 
    CAST(`Transaction Date` AS DATE) AS Day,
    COUNT(*) AS Transactions_Per_Day
FROM `debit and credit banking_data`
GROUP BY CAST(`Transaction Date` AS DATE)
ORDER BY Day;
-- Per Month:
SELECT 
    YEAR(`Transaction Date`) AS Year,
    MONTH(`Transaction Date`) AS Month,
    COUNT(*) AS Transactions_Per_Month
FROM `debit and credit banking_data`
GROUP BY YEAR(`Transaction Date`), MONTH(`Transaction Date`)
ORDER BY Year, Month;
-- per Week:
SELECT 
    YEAR(`Transaction Date`) AS Year,
    MONTH(`Transaction Date`) AS Month,
    week(`Transaction Date`) as Week,
    COUNT(*) AS Transactions_Per_week
FROM `debit and credit banking_data`
GROUP BY YEAR(`Transaction Date`), MONTH(`Transaction Date`), WEEK(`Transaction Date`)
ORDER BY Year, Month, Week;

/*8-Total Transaction Amount by Branch:*/
SELECT 
    Branch,
    SUM(Amount) AS Total_Transaction_Amount
FROM  `debit and credit banking_data`
GROUP BY Branch
ORDER BY Total_Transaction_Amount DESC;

/*8-Transaction Volume by Bank:*/
SELECT 
    `Bank Name`,
    SUM(Amount) AS Total_Transaction_Amount
FROM `debit and credit banking_data`
GROUP BY `Bank Name`
ORDER BY Total_Transaction_Amount DESC;

/*9-Transaction Method Distribution:*/
-- SELECT 
--     `Transaction Method`,
--     COUNT(*) AS Transaction_Count
-- FROM `debit and credit banking_data`
-- GROUP BY  `Transaction Method`;
SELECT 
    `Transaction Method`,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM `debit and credit banking_data`) AS Percentage_Of_Total
FROM `debit and credit banking_data`
GROUP BY  `Transaction Method`;

/*10-Branch Transaction Growth:*/


/*11-High-Risk Transaction Flag*/
SELECT 
    RISK_FLAG,
    COUNT(*) AS Transaction_Count
FROM (
    SELECT 
        CASE 
            WHEN AMOUNT > 4800 THEN 'HIGH-RISK' 
            ELSE 'NORMAL' 
        END AS RISK_FLAG
    FROM `debit and credit banking_data`
) AS t
GROUP BY RISK_FLAG;



/*12-Suspicious Transaction Frequency:*/
SELECT 
    'Customer Name',
    COUNT(*) AS Suspicious_Transactions
FROM `debit and credit banking_data`
WHERE Amount > 4800
GROUP BY 'CustomerName'
ORDER BY Suspicious_Transactions DESC;




