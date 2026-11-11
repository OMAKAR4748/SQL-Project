CREATE DATABASE LibraryDB;
USE LibraryDB;

SELECT * FROM library_transactions;
DESC library_transactions;

# Basic Queries
-- 1: How many book borrowings happened in total
SELECT COUNT(*) AS total_transactions
FROM library_transactions;

-- 2: How many different members used the library
SELECT COUNT(DISTINCT Member_ID) AS total_members
FROM library_transactions;

-- 3: How many different books are borrowed
SELECT COUNT(DISTINCT Book_ID) AS total_books
FROM library_transactions;

-- 4: Shows all genres available in the library
SELECT DISTINCT Category
FROM library_transactions;

# Member Analysis
-- 5: Identifies most active readers
SELECT Member_ID, COUNT(*) AS books_borrowed
FROM library_transactions
GROUP BY Member_ID
ORDER BY books_borrowed DESC;

-- 6: Used for member engagement analysis
SELECT Member_ID, COUNT(*) AS total_books
FROM library_transactions
GROUP BY Member_ID
ORDER BY total_books DESC
LIMIT 10;

-- 7: Identifies members who frequently return books late
SELECT Member_ID, SUM(Late_Fee) AS total_late_fee
FROM library_transactions
GROUP BY Member_ID
ORDER BY total_late_fee DESC;

# Book Analysis
-- 8: Shows popular books
SELECT Book_Title, COUNT(*) AS borrow_count
FROM library_transactions
GROUP BY Book_Title
ORDER BY borrow_count DESC;

-- 9: Helps identify underused books.
SELECT Book_Title, COUNT(*) AS borrow_count
FROM library_transactions
GROUP BY Book_Title
ORDER BY borrow_count ASC;

-- 10: Helps understand reader preferences
SELECT Category, COUNT(*) AS total_borrowed
FROM library_transactions
GROUP BY Category
ORDER BY total_borrowed DESC;

# Time Analysis
-- 11: Shows seasonal reading trends
SELECT MONTH(Borrow_Date) AS month,
COUNT(*) AS total_borrows
FROM library_transactions
GROUP BY month
ORDER BY total_borrows DESC;

-- 12: Shows average reading time
SELECT AVG(DATEDIFF(Return_Date, Borrow_Date)) AS avg_borrow_days
FROM library_transactions;

-- 13: Measures late return frequency
SELECT COUNT(*) AS late_returns
FROM library_transactions
WHERE Late_Fee > 0;

-- 14: Identifies members causing delays
SELECT Member_ID, COUNT(*) AS late_returns
FROM library_transactions
WHERE Late_Fee > 0
GROUP BY Member_ID
ORDER BY late_returns DESC;

-- 15: Shows revenue from penalties
SELECT SUM(Late_Fee) AS total_late_fee
FROM library_transactions;

# Advanced Insights
-- 16: Shows which genre is returned late most often
SELECT Category, SUM(Late_Fee) AS late_fee_total
FROM library_transactions
GROUP BY Category
ORDER BY late_fee_total DESC;

-- 17: Shows reading duration by genre
SELECT Category,
AVG(DATEDIFF(Return_Date, Borrow_Date)) AS avg_days
FROM library_transactions
GROUP BY Category;

-- 18: Shows books returned quickly
SELECT Book_Title,
MIN(DATEDIFF(Return_Date, Borrow_Date)) AS fastest_return_days
FROM library_transactions
GROUP BY Book_Title
ORDER BY fastest_return_days;