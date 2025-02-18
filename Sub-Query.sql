create database presentation;
show databases;
use presentation;
CREATE TABLE departments (department_id INT PRIMARY KEY, department_name VARCHAR(50));
INSERT INTO departments (department_id, department_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');
insert into departments values(4, 'sales');
CREATE TABLE employees (employee_id INT PRIMARY KEY,name VARCHAR(50),salary DECIMAL(10,2),department_id INT,manager_id INT NULL,FOREIGN KEY (department_id) REFERENCES departments(department_id),
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id));
INSERT INTO employees (employee_id, name, salary, department_id, manager_id) VALUES
(1, 'Alice', 60000, 1, NULL),
(2, 'Bob', 75000, 2, 1),
(3, 'Charlie', 50000, 2, 2),
(4, 'David', 90000, 3, 1),
(5, 'Eve', 65000, 3, 4),
(6, 'John', 72000, 2, 2);

select * from departments;         -- department_id, department_name
select * from employees;           -- employee_id, name, salary, department_id, manager_id

-- find the who all are get highest sal

select  name, salary from employees where salary>(select avg(salary) as maxsal from employees);

-- find the employee who are all getting more than charlie
select name, salary from employees where name='charlie';
select * from employees where salary>(select salary from employees where name='charlie');

/* multi - row query (in, any, all) */
-- Find employees working in the same department as john

select department_id from employees where name='john';
select * from employees where department_id in(select department_id from employees where name='john');

-- Find employees who earn more than at least one employee in department 2

SELECT name, min(salary) FROM employees group by department_id = 2;
SELECT * FROM employees WHERE salary > ANY (SELECT min(salary) FROM employees WHERE department_id = 2);

-- Find employees who earn more than all employees in department 2: 
SELECT name FROM employees WHERE salary > ALL (SELECT salary FROM employees WHERE department_id = 2);

-- Find employees who earn more than the average salary of their department
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;
select employee_id,name, department_id from employees e1 where salary>(select avg(salary) from employees e2 where e1.department_id=e2.department_id);

-- Find the second highest salary:

SELECT salary FROM employees ORDER BY salary DESC LIMIT 2;
SELECT min(salary) FROM (SELECT salary FROM employees ORDER BY salary DESC LIMIT 2) AS temp;

SELECT name, (SELECT department_name FROM departments WHERE department_id = e.department_id) AS dept_name 
FROM employees e;

-- Find employees who have subordinates:

SELECT department_name 
FROM departments d 
WHERE NOT EXISTS (
    SELECT 1 
    FROM employees e 
    WHERE e.department_id = d.department_id
);

SELECT department_name
FROM departments d 
WHERE EXISTS (
    SELECT 1 
    FROM employees e 
    WHERE e.department_id = d.department_id
);

select * from employees where department_id not in (select count(department_id) from employees e group by e.department_id having count(department_id) >1);
