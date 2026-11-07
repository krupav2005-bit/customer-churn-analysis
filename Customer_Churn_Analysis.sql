USE customer_churn_project;
SELECT COUNT(*) AS total_records
FROM customer_churn_raw_data;
DESCRIBE customer_churn_raw_data;
SELECT COUNT(*) AS total_columns
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'customer_churn_project'
  AND TABLE_NAME = 'customer_churn_raw_data';
  SELECT *
FROM customer_churn_raw_data
ORDER BY customerID DESC
LIMIT 5;
SHOW COLUMNS FROM customer_churn_raw_data;
USE customer_churn_project;

SELECT COUNT(*) AS total_records
FROM customer_churn_raw_data_fixed2;
DESCRIBE customer_churn_raw_data_fixed2;
USE customer_churn_project;

SHOW COLUMNS FROM customer_churn_raw_data_fixed2;
ALTER TABLE customer_churn_raw_data_fixed2
RENAME COLUMN `ï»¿customerID` TO `customerID`;
SHOW COLUMNS FROM customer_churn_raw_data_fixed2;

USE customer_churn_project;

SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN customerID IS NULL OR TRIM(customerID) = '' THEN 1 ELSE 0 END) AS missing_customer_ids,
    SUM(CASE WHEN TotalCharges IS NULL OR TRIM(TotalCharges) = '' THEN 1 ELSE 0 END) AS missing_total_charges
FROM customer_churn_raw_data_fixed2;
SELECT
    Churn,
    COUNT(*) AS customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn_raw_data_fixed2), 2) AS percentage
FROM customer_churn_raw_data_fixed2
GROUP BY Churn;

SELECT
    Contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY Contract
ORDER BY churn_rate_percentage DESC;

SELECT
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY tenure_group
ORDER BY MIN(tenure);

SELECT
    PaymentMethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY PaymentMethod
ORDER BY churn_rate_percentage DESC;

SELECT
    CASE
        WHEN CAST(MonthlyCharges AS DECIMAL(10,2)) <= 25
            THEN '0-25'
        WHEN CAST(MonthlyCharges AS DECIMAL(10,2)) <= 50
            THEN '25.01-50'
        WHEN CAST(MonthlyCharges AS DECIMAL(10,2)) <= 75
            THEN '50.01-75'
        ELSE '75+'
    END AS monthly_charges_group,

    COUNT(*) AS total_customers,

    SUM(CASE
        WHEN Churn = 'Yes' THEN 1
        ELSE 0
    END) AS churned_customers,

    ROUND(
        100.0 * SUM(CASE
            WHEN Churn = 'Yes' THEN 1
            ELSE 0
        END) / COUNT(*),
        2
    ) AS churn_rate_percent

FROM customer_churn_raw_data_fixed2

GROUP BY
    CASE
        WHEN CAST(MonthlyCharges AS DECIMAL(10,2)) <= 25
            THEN '0-25'
        WHEN CAST(MonthlyCharges AS DECIMAL(10,2)) <= 50
            THEN '25.01-50'
        WHEN CAST(MonthlyCharges AS DECIMAL(10,2)) <= 75
            THEN '50.01-75'
        ELSE '75+'
    END

ORDER BY MIN(CAST(MonthlyCharges AS DECIMAL(10,2)));
SELECT
    InternetService,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY InternetService
ORDER BY churn_rate_percentage DESC;

SELECT
    SeniorCitizen,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY SeniorCitizen
ORDER BY SeniorCitizen;

SELECT
    Partner,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY Partner
ORDER BY churn_rate_percentage DESC;

SELECT
    Dependents,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY Dependents
ORDER BY churn_rate_percentage DESC;

SELECT
    PaperlessBilling,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY PaperlessBilling
ORDER BY churn_rate_percentage DESC;

SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(AVG(MonthlyCharges), 2) AS average_monthly_charges,
    ROUND(AVG(tenure), 1) AS average_tenure_months
FROM customer_churn_raw_data_fixed2
GROUP BY Churn;

SELECT
    Churn,
    COUNT(*) AS total_customers,
    ROUND(
        AVG(
            CASE
                WHEN TRIM(TotalCharges) <> ''
                THEN CAST(TotalCharges AS DECIMAL(12,2))
                ELSE NULL
            END
        ), 2
    ) AS average_total_charges
FROM customer_churn_raw_data_fixed2
GROUP BY Churn;

SELECT
    Contract,
    CASE
        WHEN tenure <= 12 THEN '0-12 months'
        WHEN tenure <= 24 THEN '13-24 months'
        WHEN tenure <= 48 THEN '25-48 months'
        ELSE '49+ months'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
    ROUND(
        SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*), 2
    ) AS churn_rate_percentage
FROM customer_churn_raw_data_fixed2
GROUP BY Contract, tenure_group
HAVING COUNT(*) >= 20
ORDER BY churn_rate_percentage DESC;

SELECT
    COUNT(*) AS total_customers,
    SUM(
        CASE
            WHEN TotalCharges IS NULL OR TRIM(TotalCharges) = ''
            THEN 1 ELSE 0
        END
    ) AS blank_total_charges,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM customer_churn_raw_data_fixed2;

