# 🧹 Data Cleaning in SQL

## 📌 Project Description
This project demonstrates how to clean and prepare raw data using **SQL**.  
The focus is on identifying common data quality issues and resolving them using
industry-standard SQL techniques.

The cleaned data can be directly used for **analytics, dashboards, and reporting**.

---

## 🎯 Objectives
- Handle missing and NULL values
- Remove duplicate records
- Standardize text and categorical data
- Fix incorrect data types
- Validate and clean invalid records

---

## 🗂 Dataset Overview
- **Data Type:** Structured customer data
- **Format:** Relational table
- **Common Issues Found:**
  - Missing values
  - Duplicate rows
  - Inconsistent text formats
  - Incorrect data types
  - Invalid age and salary values

---

## 🛠 Tools & Technologies
- SQL
- MySQL
- SQL IDE (MySQL Workbench)

---

## 🧪 Data Cleaning Process

### 1️⃣ Handling Missing Values
- Converted blank strings to NULL
- Removed records with critical missing data

### 2️⃣ Removing Duplicates
- Used `ROW_NUMBER()` with `PARTITION BY`
- Retained only unique records

### 3️⃣ Standardizing Data
- Trimmed extra spaces
- Standardized text using `UPPER()` and `INITCAP()`

### 4️⃣ Fixing Data Types
- Converted string dates to DATE
- Converted age and salary to numeric values

### 5️⃣ Validating Data
- Removed invalid age values
- Removed negative or zero salary records

---

## 🧠 SQL Concepts Used
- SELECT, WHERE, UPDATE, DELETE
- CASE WHEN
- CTEs (WITH clause)
- Window Functions
- Data type casting
- String functions

---

## 📂 Project Structure

Data-Cleaning-in-SQL/
│── README.md
│── raw_data.sql
│── data_cleaning.sql
│── cleaned_data.sql


---

## ✅ Final Output
- Cleaned and standardized dataset
- Improved data accuracy and consistency
- Ready for analysis and visualization

---

## 🚀 Future Enhancements
- Automate cleaning using stored procedures
- Add data validation checks
- Integrate with Power BI / Tableau
- Schedule cleaning jobs

---

## 👤 Author
**Pushpak Umale**  
Data Analyst | SQL | Power BI | Business Analytics
