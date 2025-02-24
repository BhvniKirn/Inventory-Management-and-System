---Performing Insertion Queries 

--- Insert data in Customer Table
SELECT * FROM Customer;
INSERT INTO Customer (c_email, c_name, c_phn, c_address, c_creditlimit)
VALUES ('Naruto@buffalo.edu', 'Naruto', '1576567890', '164 Plm St, Buffalo City', 9000.00);
--- Insert data in Product Table
SELECT * FROM Product;
INSERT INTO Product (p_name, p_description, p_standard, p_profit, p_list)
VALUES ('iwatch', 'Apple red  series 4', 8354.11, 554.00, 2432.90);
--- Insert Records into Payment Table
INSERT INTO Payment (order_id, payment_id, payment_date, amount_paid, payment_method) VALUES
(1, 1001, '2024-04-01', 50.00, 'Credit Card'),
(2, 1002, '2024-04-02', 75.25, 'PayPal'),
(3, 1003, '2024-04-03', 100.00, 'Cash'),
(4, 1004, '2024-04-04', 120.50, 'Credit Card'),
(5, 1005, '2024-04-05', 95.75, 'PayPal'),
(6, 1006, '2024-04-06', 60.00, 'Cash'),
(7, 1007, '2024-04-07', 85.25, 'Credit Card'),
(8, 1008, '2024-04-08', 110.00, 'PayPal'),
(9, 1009, '2024-04-09', 70.50, 'Cash'),
(10, 1010, '2024-04-10', 65.75, 'Credit Card'),
(11, 1011, '2024-04-11', 90.00, 'PayPal'),
(12, 1012, '2024-04-12', 55.25, 'Cash'),
(13, 1013, '2024-04-13', 80.00, 'Credit Card'),
(14, 1014, '2024-04-14', 95.25, 'PayPal'),
(15, 1015, '2024-04-15', 120.50, 'Cash'),
(16, 1016, '2024-04-16', 75.75, 'Credit Card'),
(17, 1017, '2024-04-17', 100.00, 'PayPal'),
(18, 1018, '2024-04-18', 110.25, 'Cash'),
(19, 1019, '2024-04-19', 65.00, 'Credit Card'),
(20, 1020, '2024-04-20', 85.25, 'PayPal');

-- Performing Deletion Queries

-- Delete an employee from Employee Table
SELECT * FROM Employee;
DELETE FROM Employee WHERE e_email = 'rose.stephens@example.com';
-- Delete a product from Product Table
SELECT * FROM Product;
DELETE FROM Product WHERE p_name = 'Intel Xeon E5-2699 V3 (OEM/Tray)';

-- Performing Update Queries 

--Upadte a Customer creditlimit from Customer Table
SELECT * FROM Customer;
UPDATE Customer SET c_creditlimit = 7500.00 WHERE c_email = 'flor.stone@raytheon.com';
-- Update P_list of a product from Product Table
SELECT * FROM Product WHERE p_list = 3005.11;
UPDATE Product SET p_list = 3005.11 WHERE p_name = 'Intel Xeon E5-2697 V4';

--- SELECT QUERIES 
---1. To fetch customer details 
SELECT * FROM Customer WHERE c_creditlimit > 3000;
---2. Join query between Customer and Order table
Select * From Order_details;
SELECT Customer.c_name, Order_details.order_date, Order_details.total_amount
FROM Customer
JOIN Order_details ON Customer.c_email = Order_details.customer_email
WHERE Order_details.status = 'Shipped';
---3. Using GROUP BY to find total sales per product:
SELECT Product_name, SUM(perunit_price * Order_quantity) AS Total_Sales
FROM Transaction_Details
GROUP BY Product_name;
---4. Using ORDER BY to sort employees by hire date:
SELECT e_name, e_hiredate FROM Employee
ORDER BY e_hiredate DESC;
---5. Subquery to find customers who have placed orders above a certain amount
SELECT c_name, c_email
FROM Customer
WHERE c_email IN (SELECT c_email FROM Order_details WHERE total_amount > 1000);
---6. JOIN and GROUP BY to find the number of products sold by each warehouse
SELECT Warehouse.w_name, COUNT(Transaction_Details.ID) AS Total_Products_Sold
FROM Transaction_Details
JOIN Warehouse ON Transaction_Details.Warehouse_name = Warehouse.w_name
GROUP BY Warehouse.w_name;

--- Query Analysis Execution
CREATE or replace FUNCTION update_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Product_Stock
    SET quantity_in_stock = quantity_in_stock - NEW.Order_quantity
    WHERE product_name = NEW.Product_name AND warehouse_name = NEW.Warehouse_name;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER UpdateStockAfterTransaction
AFTER INSERT ON Transaction_Details
FOR EACH ROW
EXECUTE FUNCTION update_stock();

CREATE OR REPLACE FUNCTION check_credit()
RETURNS TRIGGER AS $$
DECLARE
    credit_limit DECIMAL(10,2);
BEGIN
    SELECT c_creditlimit INTO credit_limit FROM Customer WHERE c_email = NEW.customer_email;
    IF credit_limit < NEW.total_amount THEN
        RAISE EXCEPTION 'Credit limit exceeded for this order.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER CheckCreditBeforeOrder
BEFORE INSERT ON Order_details
FOR EACH ROW
EXECUTE FUNCTION check_credit();

CREATE OR REPLACE FUNCTION log_job_title_change()
RETURNS TRIGGER AS $$
BEGIN
    IF OLD.e_jobtitle <> NEW.e_jobtitle THEN
        INSERT INTO EmployeeChanges(employee_email, old_jobtitle, new_jobtitle, change_date)
        VALUES (NEW.e_email, OLD.e_jobtitle, NEW.e_jobtitle, CURRENT_DATE);
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER LogJobTitleChange
AFTER UPDATE ON Employee
FOR EACH ROW
EXECUTE FUNCTION log_job_title_change();

----------------
DROP TRIGGER IF EXISTS UpdateStockAfterTransaction ON Transaction_Details;
DROP TRIGGER IF EXISTS CheckCreditBeforeOrder ON Order_details;
DROP TRIGGER IF EXISTS LogJobTitleChange ON Employee;

SELECT trigger_name, event_object_table, event_manipulation
FROM information_schema.triggers
WHERE trigger_schema NOT IN ('pg_catalog', 'information_schema');
---------

---Indexing
--1. 
CREATE INDEX idx_customer_creditlimit ON Customer(c_creditlimit);
--2. Creating a hash index for faster lookup
CREATE INDEX idx_employee_hiredate ON Employee USING hash(e_hiredate);
--3. 
CREATE INDEX idx_warehouse_postalcode ON Warehouse(w_postalcode);


SELECT * FROM pg_indexes
WHERE indexname = 'idx_customer_creditlimit' or indexname = 'idx_employee_hiredate' 
or indexname = 'idx_warehouse_postalcode' ;

-- Using pagination to load data in smaller chunks
SELECT * FROM customer LIMIT 100 OFFSET 0;

-- Employing data compression techniques

ALTER TABLE customer COMPRESS;

-- Utilizing temporary tables for intermediate results to reduce memory usage
CREATE TEMPORARY TABLE temp_table AS
SELECT * FROM Customer WHERE c_creditlimit > 3000;
SELECT * FROM Temp_table;





