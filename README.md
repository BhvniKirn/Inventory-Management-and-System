# Inventory Management System 

## 📌 Project Overview
This project is an **Inventory Management System** designed using **Data Manipulation and Query Language**. It helps in managing inventory efficiently by allowing users to create, read, update, and delete inventory records using SQL queries.

## ⚡ Features
- 📋 **Add new inventory items**
- 🔍 **View available stock**
- ✏️ **Update inventory details**
- ❌ **Delete inventory records**
- 📊 **Generate inventory reports**

## 🛠️ Technologies Used
- **SQL** for database management
- **DMQL** for data querying and manipulation
- **GitHub** for version control

## 📂 Data Models and Query Languages PHASE 2

### Data Source
The dataset used in this project is available at: [Kaggle Inventory Management Dataset](https://www.kaggle.com/datasets/hetulparmar/inventory-management-dataset/data)

### **** Importing Dataset into PGAdmin ****
- Importing a CSV file into PostgreSQL database using pgAdmin’s Import/Export tool.

### **** create.sql ****
- It contains all the relations that are created in the database.

### **** load.sql ****
- The load.sql file contains Insert queries, Delete queries, Update queries, Select queries.
- Query Analysis Execution - Using Trigger Functions, Indexing Concepts.

## 🚀 Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/Inventory-Management-DMQL.git
   ```
2. Navigate to the project folder:
   ```bash
   cd Inventory-Management-DMQL
   ```
3. Open and execute the SQL files (`Create.sql`, `Load.sql`) in your database.
4. Run queries to manage the inventory.

## **** How to Run Website *****

1. **Set up PostgreSQL and PGAdmin**
   - Install PostgreSQL and PGAdmin.
   - Ensure all the data is loaded and tables are created.

2. **Install Flask and psycopg2**
   - Execute the following command in the terminal:
     ```bash
     pip install flask psycopg2
     ```

3. **Run the Flask application:**
   - Navigate to the website directory and open it in command prompt.
   - Run the App.py file using the command:
     ```bash
     python App.py
     ```
   - The live website starts running at **localhost:5000**.

- Once the website is running, enter various queries to get the corresponding output.

## 📂 Project Structure
```
├── Create.sql    # SQL script to create tables
├── Load.sql      # SQL script to insert initial data
├── FINAL_REPORT_DMQL.pdf  # Project report
├── website/      # (If applicable) Website frontend/backend files
├── README.md     # Project documentation
```



