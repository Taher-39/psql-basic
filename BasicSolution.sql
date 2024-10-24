-- Active: 1729749757999@@127.0.0.1@5432@postgres
-- Create departement table
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

--Select all active employees.
SELECT * from employees WHERE is_active = TRUE
--Find all employees in the Finance department.
SELECT e.*, d.*
FROM employees e
    JOIN departments d ON e.department_id = d.department_id
WHERE
    department_name = 'Finance';

--Calculate the total salary for employees in the Engineering department.
SELECT * from departments;

SELECT d.department_name, SUM(e.salary) AS total_salary
FROM employees e
    JOIN departments d ON e.department_id = d.department_id
WHERE
    d.department_name = 'Finance'
GROUP BY
    d.department_name;

--Determine the average salary for all employees.
SELECT AVG(salary) as avarage_salary from employees

--Select employee names and salaries, aliasing first_name as First Name and salary as Employee Salary.
SELECT
    first_name AS "First Name",
    salary AS "Employee Salary"
FROM employees;

--Sort employees by their hire date in descending order.
SELECT * from employees ORDER BY hire_date DESC


--List all departments where the manager_id is NULL (if any records exist).

SELECT * FROM departments WHERE manager_id = NULL

--Find all employees whose last_name starts with "J".
select * from employees where last_name ILIKE 'J%' 

--Get employees hired between 2021-01-01 and 2022-12-31

SELECT * from employees WHERE hire_date BETWEEN '2021-01-01' AND '2022-12-31' ORDER BY hire_date DESC

--Use ALTER TABLE to add a new column, phone_number, to the employees table.
ALTER TABLE employees ADD COLUMN phone_number VARCHAR(15);

UPDATE employees
SET phone_number = '123-456-7890';

--Modify the salary column to increase its precision if necessary.
ALTER Table employees alter COLUMN salary type decimal(10, 4);

--Drop the is_active column from the employees table.

ALTER table employees drop COLUMN phone_number

--delete employee where is_active false

DELETE from employees WHERE is_active = FALSE

--Write a query to join the employees and departments tables to display the department name for each employee.
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

--Find all employees and their manager's name (self-join if managers are also employees).
SELECT e.first_name AS employee_first_name, 
       e.last_name AS employee_last_name, 
       m.first_name AS manager_first_name, 
       m.last_name AS manager_last_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;


--Find the highest-paid employee using a subquery.    
 SELECT * from employees WHERE salary = (SELECT MAX(salary) from employees )
 

--Retrieve all employees whose salary is above the average salary.
SELECT * from employees WHERE salary > (SELECT AVG(salary) from employees)

--Retrieve all employees whose salary is above the average salary. also show in a column the avg salary
SELECT e.*, avg_salary.avg_salary
FROM employees e
JOIN (SELECT AVG(salary) AS avg_salary FROM employees) avg_salary
ON e.salary > avg_salary.avg_salary;

--Create a view called active_employees that shows only active employees and their departments.
select e.first_name as "First Name", e.last_name as "Last Name", d.department_name as "Department Name" from employees e join departments d on e.department_id = d.department_id where e.is_active = true

CREATE VIEW active_employees AS
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.is_active = true;

--Select all data from the created view.
SELECT * from active_employees


--Create an index on the last_name column of the employees table to speed up search queries.

create index idx_last_name on employees(last_name)

--Drop the index if needed.
drop INDEX idx_last_name

--Write a query to fetch the first 2 employees ordered by employee_id, and then implement pagination using LIMIT and OFFSET(skip) 
SELECT *
FROM employees
ORDER BY employee_id
LIMIT 2 offset 2
