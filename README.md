# tradezone-sql-analysis
End-to-end SQL data analysis project for TradeZone e-commerce platform.


# TradeZone SQL Data Analysis Project

## Overview
End-to-end SQL data analysis for TradeZone, a fast-growing Nigerian 
e-commerce platform connecting buyers and sellers across Lagos, Abuja, 
Kano, Port Harcourt and Ibadan.

## Business Problem
Customer retention was dropping, seller quality was inconsistent and 
certain product categories were underperforming despite heavy 
promotion spend.

## What I Did
- Cleaned and prepared a 7-table PostgreSQL database
- Answered 8 business questions using SQL
- Delivered an analyst memo with findings and recommendations

## Database Schema
- customers — 865 records
- sellers — 90 records
- products — 280 records
- orders — 3,015 records
- order_items — 6,426 records
- payments — 2,262 records
- reviews — 817 records

## Data Cleaning (Part1.sql)
- Handled 16 NULL emails and 4 NULL unit prices
- Standardised city names across 6+ variations
- Normalised 7 product categories
- Flagged 124 orders with mismatched totals
- Removed invalid review ratings (-1, 0, 7)

## Business Questions Answered
| File | Question |
|------|----------|
| Q1.sql | Customer Acquisition & 30-Day Conversion |
| Q2.sql | Top 10 Products by Revenue |
| Q3.sql | Seller Fulfilment Efficiency |
| Q4.sql | Quarterly Revenue Trends 2023 vs 2024 |
| Q5.sql | Customer Spend Segmentation |
| Q6.sql | Payment Method Preferences by State |
| Q7.sql | Review Ratings and Sales Performance |
| Q8.sql | Top Seller Bonus Qualification |

## Key Findings
1. 99% of 2024 revenue came from just 551 High Spenders
2. Mid-rated products outsold high-rated products (₦1.64B vs ₦1.07B)
3. Q1 2024 recorded 1,573% revenue growth vs Q1 2023

## Tools Used
- PostgreSQL 18
- pgAdmin 4
- SQL (CTEs, Window Functions, CASE WHEN, DATE arithmetic)
- pg_dump for database export

## Files
- Part1.sql — Data cleaning script
- Q1.sql to Q8.sql — Business analysis queries
- cleaned_dump.sql — Full cleaned database export
- Analyst_Memo.pdf — Executive memo for leadership
