# MSSS-SQL-layoffs-dataset-cleaning

This project focuses on cleaning and preparing a dataset containing layoff information. The dataset includes company names, locations, industries, and layoff details. The SQL script provided cleans and standardizes the data for further analysis.

## 🛠 Project Overview

The SQL script performs the following key tasks:

1. **Creating Staging Tables**  
   - Copies raw data into a staging table for transformation.

2. **Handling Duplicates**  
   - Identifies duplicate rows using `ROW_NUMBER()`  
   - Removes duplicates to keep only the first occurrence.

3. **Standardizing Data**  
   - Trims extra spaces from company names.  
   - Removes trailing periods from country names.  
   - Standardizes variations of "Crypto" into a single industry label.  
   - Converts and standardizes date formats.  

4. **Handling Missing Values**  
   - Replaces `NULL` or `"NULL"` values with empty strings.  
   - Uses stored procedures to update missing columns dynamically.  
   - Fills missing industry values for companies operating in the same location.  

5. **Finalizing Clean Data**  
   - Drops unnecessary columns (e.g., `row_num`).  
   - Copies the cleaned data into a final table for analytics.  

## 📂 Files

- `layoffs_cleaning.sql` – The SQL script containing all data cleaning operations.

## 🏗 Setup Instructions

1. Clone the repository:
   ```sh
   git clone https://github.com/yourusername/layoffs-cleaning.git

2. **Import the dataset into SQL Server.**  
3. **Run the SQL script `layoffs_cleaning.sql` step by step.**  
4. **Query the `layoffsFinal` table for further analysis.**  

---

## 📜 License

This project is open-source under the **MIT License**.

---

**Author:** [Omar Hashem](https://github.com/yourusername) 
