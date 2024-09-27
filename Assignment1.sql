create database assignment1;
use assignment1;

CREATE TABLE employee_details (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT,
    hire_date DATE
);

CREATE TABLE department_details (
    dept__id INT,
    dept_name VARCHAR(100)
);

CREATE TABLE salaries (
    emp_id INT,
    salary DOUBLE,
    bonus DOUBLE
);

insert into employee_details values(001,"Alice",1,"2024-01-03");
insert into employee_details values(002,"Bob",1,"2024-02-04");
insert into employee_details values(003,"Mathew",1,"2024-03-05");
insert into employee_details values(004,"Paul",1,"2024-05-08");
insert into employee_details values(005,"Alex",3,"2024-05-08");
insert into employee_details values(006,"Brew",4,"2024-02-04");
insert into employee_details values(007,"Henry",2,"2024-06-04");
insert into employee_details values(008,"Olive",3,"2024-08-07");

insert into department_details values(1,"IT");
insert into department_details values(2,"HR");
insert into department_details values(3,"Finance");
insert into department_details values(4,"Purchase");

insert into salaries values(001, 60000,30000);
insert into salaries values(002, 61000,32000);
insert into salaries values(003, 62000,34000);
insert into salaries values(004, 63000,24000);
insert into salaries values(005, 50000,21000);
insert into salaries values(006, 40000,36500);
insert into salaries values(007, 30000,22100);
insert into salaries values(008, 45000,25000);


SELECT 
    *
FROM
    employee_details
WHERE
    (LEFT(UPPER(emp_name), 1) IN ('a' , 'e', 'i', 'o', 'u'))
        AND (RIGHT(UPPER(emp_name), 1) NOT IN ('a' , 'e', 'i', 'o', 'u'));
        
        
        
SELECT d.dept_name, e.emp_name, (s.salary + s.bonus)
 AS total_salary,SUM(s.salary+s.bonus) 
 OVER(PARTITION BY d.dept__id) AS salary_expenditure,
 AVG(s.salary+s.bonus) OVER(PARTITION BY d.dept__id) AS 
 avg_sal,MAX(s.salary+s.bonus) OVER(PARTITION BY d.dept__id)
 AS max_salary FROM employee_details e 
 JOIN department_details d ON e.dept_id=d.dept__id 
 JOIN salaries s ON e.emp_id=s.emp_id;
 
 ALTER TABLE employee_details ADD COLUMN manager_id int;
 
UPDATE employee_details 
SET 
    manager_id = 001
WHERE
    (emp_id IN (002 , 003, 004));
UPDATE employee_details 
SET 
    manager_id = 007
WHERE
    (emp_id IN (005 , 006, 008));

SELECT 
    e.emp_name,
    d.dept_name,
    m.emp_name AS manager_name,
    s.salary + s.bonus AS total_salary
FROM
    employee_details e
        JOIN
    department_details d ON e.dept_id = d.dept__id
        JOIN
    salaries s ON e.emp_id = s.emp_id
        LEFT JOIN
    employee_details m ON e.manager_id = m.emp_id;


WITH RECURSIVE EmployeeHierarchy AS (
    SELECT 
        e.emp_id,
        e.emp_name,
        e.manager_id,
        CAST(NULL AS CHAR(100)) AS manager_name,  
        1 AS level
    FROM 
        employee_details e
    WHERE 
        e.manager_id IS NULL

    UNION ALL


    SELECT 
        e.emp_id,
        e.emp_name,
        e.manager_id,
        m.emp_name AS manager_name,
        eh.level + 1 AS level
    FROM 
        employee_details e
    JOIN 
        EmployeeHierarchy eh ON e.manager_id = eh.emp_id
    LEFT JOIN 
        employee_details m ON e.manager_id = m.emp_id
)


SELECT 
    emp_id,
    emp_name,
    COALESCE(manager_name, 'No Manager') AS manager_name,
    level
FROM 
    EmployeeHierarchy
ORDER BY 
    level, emp_name;


 
SELECT 
    e.emp_id, e.emp_name, s.salary
FROM
    employee_details e
        JOIN
    salaries s ON e.emp_id = s.emp_id
WHERE
    s.salary > 50000;
    
CREATE INDEX idx_emp_salary ON salaries (salary, emp_id) ;
EXPLAIN SELECT 
    e.emp_id,
    e.emp_name,
    s.salary
FROM 
    employee_details e
JOIN 
    salaries s ON e.emp_id = s.emp_id
WHERE 
    s.salary > 50000;
;



CREATE TEMPORARY TABLE temp_sales_report (
    product_id INT,
    product_name VARCHAR(100),
    total_sales DECIMAL(10, 2),
    avg_sales_per_customer DECIMAL(10, 2),
    top_salesperson VARCHAR(100)
);

CREATE TABLE salespeople (
    salesperson_id INT PRIMARY KEY,
    salesperson_name VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);


CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    salesperson_id INT,
    customer_id INT,
    sale_amount DECIMAL(10 , 2 ),
    sale_date DATE,
    FOREIGN KEY (product_id)
        REFERENCES products (product_id),
    FOREIGN KEY (salesperson_id)
        REFERENCES salespeople (salesperson_id),
    FOREIGN KEY (customer_id)
        REFERENCES customers (customer_id)
);


INSERT INTO salespeople (salesperson_id, salesperson_name)
VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');


INSERT INTO products (product_id, product_name)
VALUES (101, 'Laptop'), (102, 'Smartphone'), (103, 'Tablet');


INSERT INTO customers (customer_id, customer_name)
VALUES (201, 'Customer A'), (202, 'Customer B'), (203, 'Customer C');


INSERT INTO sales (sale_id, product_id, salesperson_id, customer_id, sale_amount, sale_date)
VALUES 
(1, 101, 1, 201, 1000.00, '2024-09-25'),
(2, 102, 2, 202, 1500.00, '2024-09-26'),
(3, 103, 3, 203, 2000.00, '2024-09-27'),
(4, 101, 1, 202, 1200.00, '2024-09-28'),
(5, 102, 3, 201, 1600.00, '2024-09-29'),
(6, 103, 2, 203, 2100.00, '2024-09-30');

INSERT INTO temp_sales_report (product_id, product_name, total_sales, avg_sales_per_customer, top_salesperson)
SELECT 
    p.product_id,
    p.product_name,
    
    SUM(s.sale_amount) AS total_sales,
    AVG(s.sale_amount) AS avg_sales_per_customer,
    (
        SELECT sp.salesperson_name
        FROM sales s2
        JOIN salespeople sp ON s2.salesperson_id = sp.salesperson_id
        WHERE s2.product_id = p.product_id
        GROUP BY sp.salesperson_name
        ORDER BY SUM(s2.sale_amount) DESC
        LIMIT 1
    ) AS top_salesperson
    
FROM 
    sales s
JOIN 
    products p ON s.product_id = p.product_id
GROUP BY 
    p.product_id, p.product_name;
    
SELECT 
    *
FROM
    temp_sales_report;

DROP TEMPORARY TABLE IF EXISTS temp_sales_report;


