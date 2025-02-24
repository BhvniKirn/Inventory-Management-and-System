--- Creating Customer Table
CREATE TABLE Customer(
c_email VARCHAR(255) PRIMARY KEY,
c_name VARCHAR(255),
c_phn VARCHAR(20),
c_address VARCHAR(255),
c_creditlimit DECIMAL(10,2)
);
select * from customer;

--- Creating Employee Table
CREATE TABLE Employee (
e_email VARCHAR(255) PRIMARY KEY,
e_name VARCHAR(255),
e_phnno VARCHAR(20),
e_hiredate DATE,
e_jobtitle VARCHAR(255)
);
select * from employee;

---Creating Product Table
CREATE TABLE Product (
p_name VARCHAR(255) PRIMARY KEY,
p_description VARCHAR(255),
p_standard VARCHAR(255),
p_profit DECIMAL(10, 2),
p_list DECIMAL(10,2)
);

---Creating Warehouse Table
CREATE TABLE Warehouse(
w_name VARCHAR(255) PRIMARY KEY,
w_address VARCHAR(255),
w_postalcode INT,
FOREIGN KEY (w_postalcode)REFERENCES Warehouse_Address(postal_id)
);
SELECT * FROM Warehouse;

---Creating Warehouse_Address Table
CREATE TABLE Warehouse_Address(
postal_id INT PRIMARY KEY,
region_name VARCHAR(255),
country_name VARCHAR(255),
state_name VARCHAR(255),
city VARCHAR(255)
);
SELECT * FROM Warehouse_Address;

---Creating Trasaction_Details Table
CREATE TABLE Transaction_Details (
	ID INT PRIMARY KEY,
	Warehouse_name VARCHAR(255),
	Employee_name VARCHAR(255),
	Product_name VARCHAR(255),
	Customer_email VARCHAR(255),
	Status VARCHAR(50),
	Order_dt DATE,
	Order_quantity INT,
	perunit_price DECIMAL(10, 2)
	FOREIGN KEY (Warehouse_name) REFERENCES Warehouse(w_name),
	FOREIGN KEY (Employee_name) REFERENCES Employee(e_email),
	FOREIGN KEY (Product_name) REFERENCES Product(p_name),
	FOREIGN KEY (Customer_email) REFERENCES Customer(c_email)	
);
Select * FROM Transaction_Details;

--- Creating Order_Details Table
CREATE TABLE Order_Details (
    order_id INT PRIMARY KEY,
    customer_email VARCHAR(255),
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (customer_email) REFERENCES Customer(c_email)
);
Select * FROM Order_Details;

---Creating Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_date DATE,
    amount_paid DECIMAL(10,2),
    payment_method VARCHAR(100),
    FOREIGN KEY (order_id) REFERENCES Order_Details(order_id)
);
Select * from Payment;

--- Creating Shipment Table
CREATE TABLE Shipment (
    shipment_id INT PRIMARY KEY,
    order_id INT,
    shipment_date DATE,
    warehouse_name VARCHAR(255),
    shipping_address VARCHAR(255),
    FOREIGN KEY (order_id) REFERENCES Order_Details(order_id)
);
select * from Shipment;

---Creating Product_Stock Table
CREATE TABLE Product_Stock (
    product_name VARCHAR(255),
    warehouse_name VARCHAR(255),
    quantity_in_stock INT
    FOREIGN KEY (product_name) REFERENCES Product(p_name),
    FOREIGN KEY (warehouse_name) REFERENCES Warehouse(w_name),
    PRIMARY KEY (product_name, warehouse_name)
);
Select * from Product_stock;


