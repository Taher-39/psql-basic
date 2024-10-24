
# SQL Concepts and Tasks: Employees and Departments Database (PostgreSQL)

## Introduction

In this session, we will explore fundamental SQL concepts using PostgreSQL by creating and manipulating two related tables: `employees` and `departments`. The `employees` table will store information about employees, including their names, hire dates, salaries, and active status. The `departments` table will hold details about various departments within an organization. 

Through a series of tasks, we will practice SQL operations such as creating tables, inserting data, defining constraints, querying information, and modifying tables. This hands-on approach will enhance your understanding of SQL and its practical applications in database management using PostgreSQL.

## Sample Data

### Table 1: employees

| employee_id | first_name | last_name | hire_date  | salary   | department_id | is_active |
|-------------|------------|-----------|------------|----------|---------------|-----------|
| 1           | John       | Doe       | 2021-05-10 | 50000.00 | 1             | TRUE      |
| 2           | Jane       | Smith     | 2022-03-15 | 62000.00 | 2             | TRUE      |
| 3           | Alice      | Johnson   | 2023-01-20 | 55000.00 | 1             | FALSE     |
| 4           | Bob        | Davis     | 2020-11-30 | 72000.00 | 3             | TRUE      |

### Table 2: departments

| department_id | department_name   | manager_id |
|---------------|-------------------|------------|
| 1             | Human Resources    | 1          |
| 2             | Finance           | 2          |
| 3             | Engineering       | 4          |

## Task List Based on the Above Tables

### Task 1: Creating Tables with Multiple Columns and Data Types

- Create the `employees` table with various data types like `VARCHAR`, `DATE`, `BOOLEAN`, and `NUMERIC`.
- Create the `departments` table with a `SERIAL` type for the primary key and a `VARCHAR` type for the department name.
- Ensure that the `first_name`, `last_name`, and `department_name` columns are `NOT NULL`.
- Add a `PRIMARY KEY` constraint to `employee_id` and `department_id`.
- Add a `FOREIGN KEY` constraint on `department_id` in the `employees` table that references `department_id` in the `departments` table.

### Task 2: Inserting Data and Checking Constraints

- Insert sample records (as shown above) into the `employees` and `departments` tables.
- Attempt to insert a record where `first_name` is `NULL` to validate the `NOT NULL` constraint.
- Try to insert a record with a non-existent `department_id` to test the `FOREIGN KEY` constraint.
```sql
---create departments table
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    manager_id INT
);

-- create employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    hire_date DATE NOT NULL,
    salary NUMERIC(10, 2) NOT NULL,
    department_id INT REFERENCES departments (department_id),
    is_active BOOLEAN
);

-- insert data into departments table
INSERT INTO
    departments (department_name, manager_id)
VALUES ('Human Resources', 1),
    ('Finance', 2),
    ('Engineering', 4);

SELECT * FROM departments;

-- insert data into employees table
INSERT INTO
    employees (
        first_name,
        last_name,
        hire_date,
        salary,
        department_id,
        is_active
    )
VALUES (
        'John',
        'Doe',
        '2021-05-10',
        50000.00,
        1,
        TRUE
    ),
    (
        'Jane',
        'Smith',
        '2022-03-15',
        62000.00,
        2,
        TRUE
    ),
    (
        'Alice',
        'Johnson',
        '2023-01-20',
        55000.00,
        1,
        FALSE
    ),
    (
        'Bob',
        'Davis',
        '2020-11-30',
        72000.00,
        3,
        TRUE
    ),
    (
        'Shafayet',
        'Bhai',
        '2021-05-10',
        50000.00,
        2,
        TRUE
    );

SELECT * FROM employees;

INSERT INTO
    employees (
        first_name,
        last_name,
        hire_date,
        salary,
        department_id,
        is_active
    )
VALUES (
        'Shafayet',
        'Bhai',
        '2021-05-10',
        50000.00,
        25,
        TRUE
    );
```

### Task 3: Querying the Data

**Basic Queries:**

- Select all active employees.
    ```sql
    SELECT * FROM employees WHERE is_active = TRUE;
    ```
- Find all employees in the Finance department.
    ```sql
    SELECT e.*, d.* FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE d.department_name = 'Finance';
    ```

**Aggregate Functions:**

- Calculate the total salary for employees in the Engineering department.
    ```sql
    SELECT SUM(salary) FROM employees WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Engineering');
    ```
- Determine the average salary for all employees.
    ```sql
    SELECT AVG(salary) AS average_salary FROM employees;
    ```

**Sorting and Aliasing:**

- Select employee names and salaries, aliasing `first_name` as `First Name` and `salary` as `Employee Salary`.
    ```sql
    SELECT first_name AS "First Name", salary AS "Employee Salary" FROM employees;
    ```
- Sort employees by their hire date in descending order.
    ```sql
    SELECT * FROM employees ORDER BY hire_date DESC;
    ```

**NULL Filtering:**

- List all departments where the `manager_id` is `NULL` (if any records exist).
    ```sql
    SELECT * FROM departments WHERE manager_id IS NULL;
    ```

**Using LIKE and BETWEEN:**

- Find all employees whose last name starts with "J".
    ```sql
    SELECT * FROM employees WHERE last_name ILIKE 'J%';
    ```
- Get employees hired between 2021-01-01 and 2022-12-31.
    ```sql
    SELECT * FROM employees WHERE hire_date BETWEEN '2021-01-01' AND '2022-12-31';
    ```

### Task 4: Modifying Tables

- Use `ALTER TABLE` to add a new column, `phone_number`, to the `employees` table.
    ```sql
    ALTER TABLE employees ADD COLUMN phone_number VARCHAR(15);
    ```
- Modify the salary column to increase its precision if necessary.
    ```sql
    ALTER TABLE employees ALTER COLUMN salary TYPE DECIMAL(10, 4);
    ```
- Drop the `is_active` column from the `employees` table.
    ```sql
    ALTER TABLE employees DROP COLUMN is_active;
    ```

### Task 5: JOIN Operations

- Write a query to join the `employees` and `departments` tables to display the department name for each employee.
    ```sql
    SELECT e.first_name, e.last_name, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id;
    ```
- Find all employees and their manager's name (self-join if managers are also employees).
    ```sql
    SELECT e.first_name AS employee_first_name, e.last_name AS employee_last_name, m.first_name AS manager_first_name, m.last_name AS manager_last_name FROM employees e LEFT JOIN employees m ON e.manager_id = m.employee_id;
    ```

### Task 6: Subqueries

- Find the highest-paid employee using a subquery.
    ```sql
    SELECT * FROM employees WHERE salary = (SELECT MAX(salary) FROM employees);
    ```
- Retrieve all employees whose salary is above the average salary.
    ```sql
    SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);
    ```

### Task 7: Views

- Create a view called `active_employees` that shows only active employees and their departments.
    ```sql
    CREATE VIEW active_employees AS SELECT e.first_name, e.last_name, d.department_name FROM employees e JOIN departments d ON e.department_id = d.department_id WHERE e.is_active = TRUE;
    ```
- Select all data from the created view.
    ```sql
    SELECT * FROM active_employees;
    ```

### Task 8: Indexing

- Create an index on the `last_name` column of the `employees` table to speed up search queries.
    ```sql
    CREATE INDEX idx_last_name ON employees(last_name);
    ```
- Drop the index if needed.
    ```sql
    DROP INDEX idx_last_name;
    ```

### Task 9: Pagination

- Write a query to fetch the first 2 employees ordered by `employee_id`, and then implement pagination using `LIMIT` and `OFFSET(skip)`.
    ```sql
    SELECT * FROM employees ORDER BY employee_id LIMIT 2 OFFSET 2;
    ```

