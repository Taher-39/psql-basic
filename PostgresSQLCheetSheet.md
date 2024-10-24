Here's a PostgreSQL cheat sheet that covers essential commands and features, from basic to advanced levels. This will help you understand PostgreSQL and effectively work with databases.

---

### **PostgreSQL Cheat Sheet (Zero to Advanced)**

---

### **1. Basic SQL Operations**

#### Connecting to a PostgreSQL Database
```bash
psql -U username -d dbname
```

#### Creating a Database
```sql
CREATE DATABASE dbname;
```

#### Connecting to a Database
```bash
\c dbname;
```

#### Creating a Table
```sql
CREATE TABLE table_name (
  column1 data_type PRIMARY KEY,
  column2 data_type NOT NULL,
  column3 data_type DEFAULT default_value
);
```

#### Inserting Data into a Table
```sql
INSERT INTO table_name (column1, column2) VALUES (value1, value2);
```

#### Querying Data from a Table
```sql
SELECT column1, column2 FROM table_name WHERE condition;
```

#### Updating Data in a Table
```sql
UPDATE table_name SET column1 = value1 WHERE condition;
```

#### Deleting Data from a Table
```sql
DELETE FROM table_name WHERE condition;
```

---

### **2. Data Types**

- **Integer**: `INTEGER`, `SERIAL`
- **String**: `VARCHAR(n)`, `TEXT`
- **Boolean**: `BOOLEAN`
- **Date and Time**: `DATE`, `TIMESTAMP`
- **Monetary**: `MONEY`
- **Decimal**: `DECIMAL(p, s)` or `NUMERIC(p, s)`

---

### **3. Constraints**

- **Primary Key**: Uniquely identifies rows.
```sql
CREATE TABLE example (
  id SERIAL PRIMARY KEY
);
```

- **Foreign Key**: Links one table to another.
```sql
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(customer_id)
);
```

- **Unique**: Ensures all values in a column are distinct.
```sql
CREATE TABLE example (
  email VARCHAR(100) UNIQUE
);
```

- **Not Null**: Ensures a column cannot be `NULL`.
```sql
CREATE TABLE example (
  name VARCHAR(50) NOT NULL
);
```

- **Check**: Validates data based on a condition.
```sql
CREATE TABLE products (
  price DECIMAL CHECK (price > 0)
);
```

---

### **4. Joins**

- **Inner Join** (default join type):
```sql
SELECT * FROM table1
JOIN table2 ON table1.id = table2.id;
```

- **Left Join**:
```sql
SELECT * FROM table1
LEFT JOIN table2 ON table1.id = table2.id;
```

- **Right Join**:
```sql
SELECT * FROM table1
RIGHT JOIN table2 ON table1.id = table2.id;
```

- **Full Join**:
```sql
SELECT * FROM table1
FULL JOIN table2 ON table1.id = table2.id;
```

---

### **5. Advanced SQL Features**

#### Grouping and Aggregation
```sql
SELECT column, COUNT(*)
FROM table_name
GROUP BY column;
```

- **Common Aggregate Functions**: `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`

#### Filtering with HAVING
```sql
SELECT column, COUNT(*)
FROM table_name
GROUP BY column
HAVING COUNT(*) > 1;
```

#### Subqueries
```sql
SELECT column1 FROM table_name
WHERE column2 IN (SELECT column2 FROM another_table WHERE condition);
```

#### Case Statement
```sql
SELECT column,
  CASE
    WHEN condition THEN 'Result1'
    ELSE 'Result2'
  END AS alias
FROM table_name;
```

#### Window Functions
```sql
SELECT column, ROW_NUMBER() OVER (PARTITION BY column ORDER BY column) FROM table_name;
```

---

### **6. Transactions and Concurrency**

#### Starting a Transaction
```sql
BEGIN;
```

#### Committing a Transaction
```sql
COMMIT;
```

#### Rolling Back a Transaction
```sql
ROLLBACK;
```

#### Savepoints
```sql
SAVEPOINT savepoint_name;
ROLLBACK TO savepoint_name;
```

---

### **7. Indexing**

#### Creating an Index
```sql
CREATE INDEX index_name ON table_name (column);
```

#### Creating a Unique Index
```sql
CREATE UNIQUE INDEX index_name ON table_name (column);
```

---

### **8. Views**

#### Creating a View
```sql
CREATE VIEW view_name AS
SELECT column1, column2 FROM table_name WHERE condition;
```

#### Dropping a View
```sql
DROP VIEW view_name;
```

---

### **9. User and Permissions Management**

#### Create a User
```sql
CREATE USER username WITH PASSWORD 'password';
```

#### Grant Privileges
```sql
GRANT ALL PRIVILEGES ON DATABASE dbname TO username;
```

#### Revoke Privileges
```sql
REVOKE ALL PRIVILEGES ON DATABASE dbname FROM username;
```

---

### **10. Backup and Restore**

#### Backup a Database
```bash
pg_dump dbname > backup.sql
```

#### Restore a Database
```bash
psql dbname < backup.sql
```

---

### **11. Advanced Data Types**

- **JSON**:
```sql
SELECT column->>'key' FROM table_name;
```

- **Array**:
```sql
SELECT column[1] FROM table_name;
```

- **UUID**:
```sql
CREATE TABLE example (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid()
);
```

---

### **12. Extensions**

#### Installing an Extension (e.g., pg_trgm for full-text search)
```sql
CREATE EXTENSION IF NOT EXISTS pg_trgm;
```

---

### **13. Performance Tuning**

#### Explain Query Plan
```sql
EXPLAIN ANALYZE SELECT * FROM table_name WHERE condition;
```

#### Vacuum (for table cleanup and optimization)
```sql
VACUUM FULL table_name;
```

#### Analyze (collects statistics for query optimization)
```sql
ANALYZE table_name;
```

---

### **14. Useful Meta Commands in psql**

- **List Databases**:
```bash
\l
```

- **List Tables**:
```bash
\dt
```

- **Describe Table**:
```bash
\d table_name
```

- **List Users**:
```bash
\du
```

---

### **15. Full-Text Search (FTS)**

#### Create Full-Text Search Configuration
```sql
SELECT to_tsvector('english', 'The quick brown fox');
```

#### Query Using FTS
```sql
SELECT * FROM table_name WHERE to_tsvector(column) @@ to_tsquery('search_term');
```

---

### **16. CTE (Common Table Expressions)**

#### Creating a CTE
```sql
WITH cte_name AS (
  SELECT column1, column2 FROM table_name WHERE condition
)
SELECT * FROM cte_name;
```

---

### **17. Triggers**

#### Creating a Trigger
```sql
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
FOR EACH ROW EXECUTE FUNCTION function_name();
```

---

### **18. Partitioning**

#### Creating a Partitioned Table
```sql
CREATE TABLE table_name (
  column1 INT,
  column2 VARCHAR
) PARTITION BY RANGE (column1);
```

---

### **19. Foreign Data Wrapper (FDW)**

#### Installing the Extension
```sql
CREATE EXTENSION postgres_fdw;
```

#### Creating a Foreign Server
```sql
CREATE SERVER foreign_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'localhost', dbname 'other_db');
```

#### Creating a Foreign Table
```sql
CREATE FOREIGN TABLE foreign_table_name (
  column1 INT,
  column2 TEXT
) SERVER foreign_server OPTIONS (table_name 'other_table');
```

---

### **20. Backup & Restore Large Data**

- **Dump only schema**:
```bash
pg_dump -s dbname > schema.sql
```

- **Restore only schema**:
```bash
psql dbname < schema.sql
```

- **Parallel restore**:
```bash
pg_restore -j 4 -d dbname dumpfile.tar
```

---

### Summary

This cheat sheet covers the most important and commonly used PostgreSQL commands, from basic to advanced levels. Whether you are just starting or diving into more complex features like transactions, indexing, partitioning, or extensions, this guide provides a useful reference for your daily PostgreSQL tasks.