
# SQL Portfolio Project - Superstore Data Analysis

Project Overview:

This project aims to analyze sales data from a hypothetical superstore using SQL. The primary objective is to clean and transform the raw data to extract meaningful insights and support informed decision-making.

Data Cleaning and Preparation:

Data Source: The project utilizes a dataset containing sales information, including order details, customer demographics, product categories, and sales metrics.

STEP-1
Data Cleaning:

Data Structure: The data is initially stored in two tables: OrdersList and EachOrderBreakdown. 
Data Normalization: The City, State, and Country columns have been split into separate columns for better data organization and analysis.
Data Enrichment: A new Category column have been added based on the first three characters of the ProductName column, classifying products into Technology, Office Supplies, and Furniture categories.
Data Cleaning: Duplicate rows within the EachOrderBreakdown table have been removed to ensure data accuracy. Missing values in the OrderPriority column of the OrdersList table have replaced with "NA".

STEP-2
Data Analysis and Insights:

Sales Performance: Analyze overall sales trends, top-selling products, and customer segments.
Customer Behavior: Explore customer demographics, purchase patterns, and order frequency.
Product Analysis: Investigate product performance, profitability, and popular categories.
Geographic Analysis: Analyze sales distribution by region, state, and city.
Tools and Technologies:



