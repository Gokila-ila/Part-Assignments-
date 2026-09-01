CREATE DATABASE employee1;
USE employee1;
CREATE TABLE departments(                     # The departments table is created with department_id and department_name in the employee database 
department_id INT PRIMARY KEY,   
department_name varchar(100) NOT NULL
);     
CREATE TABLE location(                       # Location table is created in the employee database
location_id INT PRIMARY KEY,                 # Primary ensures location ID has unique ID
location_name varchar(30)                    #Location name set variable character 100 to store location name 
);    
drop table location;
CREATE TABLE employees(                                    # Creation of employees table contains employee details as follows,
employee_id INT  PRIMARY KEY,                               # Employee Id is set as as Primary key unqueily identifies each row in the table
employee_name varchar(50) NOT NULL,                       # The employee name stored as Variable character & it won,t allow null data 
gender enum("M","F"),                                      # enum allows only gender as "M" or "F" ,NOT NULL->its prevents the null values
age INT,                                                   # Age is used to store the employee age as interger(whole number) Data type
hire_date DATE,                                            # Stores the hire date of the employee
designation varchar(100) NOT NULL,                          # Designation is used to store employee designation and it won't allow null values
salary DECIMAL(10,2),                                      # Stores the Employees salary with 2 decimal points
department_id INT,                                         # store ID of department associate with the Employee
location_id INT,
CONSTRAINT fk_employee1_departments                                    #Gives the name to the foreign key constraint
FOREIGN KEY (department_id) REFERENCES departments(department_id),   #Make the department_id as foreign key in the employee table connect to department+id of deparment table
CONSTRAINT fk_employee1_location                                     #Gives the name to foreign key constraint
FOREIGN KEY (location_id) REFERENCES location(location_id)          #Make a location_id as foreign key in the employee table connect it to location table
                                     
);
                                       # The location table ensures the location_ID is unique identifier and not allows null values

INSERT INTO departments
(department_id,department_name)
VALUES (1,'IT'),
	   (2,'HR'),
       (3,'FINANCE'),
       (4,'MARKETING'),
       (5,'SALES');   ## Inserts departmentid and department name  details into the employees table.
INSERT INTO location
(location_id,location_name)
VALUES(1,'CHENNAI'),
      (2,'BANGALORE'),
      (3,'MUMBAI'),
      (4,'HYDERABAD'),
      (5,'COIMBATORE');## Inserts location details into the location table.
SELECT *FROM departments ASCE;
SELECT *FROM location;
INSERT INTO employees
(employee_id,employee_name,gender,age,hire_date,designation,salary,department_id,location_id)
VALUES(101,'Arun Kumar', 'M', 25, '2022-06-15', 'Data Analyst', 45000,1,2),
	  (102, 'Priya Devi', 'F', 28, '2021-03-10', 'HR Executive', 40000,2,1),
      (103, 'Rahul Raj', 'M', 30, '2020-08-20', 'Software Developer', 55000,3,4),
      (104, 'Divya Sri', 'F', 26, '2023-01-12', 'Financial Analyst', 48000,4,2),
      (105, 'Karthik S', 'M', 32, '2019-11-05', 'Sales Manager', 60000,5,1),
      (106, 'Sneha Priya', 'F', 28, '2018-09-15', 'Marketing Analyst', 58000,4,4),
	  (107,'Dhashini Priya','F',27,'2018-03-12','Data Analyst',59000,1,3),
      (108,'Anitha A','F',30,'2017-02-14','Software Developer',58000,1,3),
      (109, 'Rahul Raj', 'M', 32, '2014-09-10', 'Software Engineer', 75000,1,3),
      (110, 'Karthik M', 'M', 35, '2013-04-18', 'Financial Analyst', 70000,2,2);## Inserts employee details into the employees table.

SELECT *FROM employees;  ## Displays all employee records.
SELECT salary FROM employees; 
##Clause and Operators
##---Task 1--> DISTINCT VALUES
SELECT DISTINCT salary FROM employees;    # Retrieve distinct salaries from the Employees table, distinct removes duplicate
##---Task 2--> ALIAS (AS                 
SELECT age AS Employee_Age,
       salary AS Employee_Salary         ## AS gives a temporary name to a column in the output here age will diplay as Employee-age and salary will display as Employee_salary
       FROM employees;
##--Task 3--> Where Clause Operator      ## Retrieves employees earning at least 50000 and hired before 2016.
SELECT * FROM employees WHERE salary>=50000 AND hire_date <'2016-01-01';  ## AND → both conditions must be true
SELECT * FROM employees WHERE designation IS NULL;
##--Sorting and Grouping--
#---Task 1-->Order By
SELECT * FROM employees 
              ORDER BY department_id ASC,
              salary DESC;               ## Sorts employees by department ID in ascending order and salary in descending order
##---Task 2-->Limit
SELECT * FROM employees 
         WHERE YEAR(hire_date) = 2018
         ORDER BY hire_date ASC                       ##extracts the year.
         LIMIT 5;                                     ## LIMIT 5 → displays only 5 records.
         UPDATE employees
SET designation = 'Data Scientist'                  ##Updates missing designations and replaces NULL with Data Scientist.
            WHERE designation IS NULL;
##---Task 3-->Aggregate Functions 
##--Calculate the sum of all salaries in the Finance department--
SELECT SUM(e.salary) AS Total_Finance_salary 
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
WHERE d.department_name = 'Finance';  ## Its calculate the total salary of employees in the Finance department(555000).
##--Find the minimum age among all employees--
SELECT MIN(age) AS Min_Age FROM employees;   ## MIN() returns the smallest value.
##--Task 4--> Group BY--
SELECT location_id,MAX(salary) as MaximumSalary
FROM employees GROUP BY location_id;  ## GROUP BY location_id--> creates a separate group for each location.
##--For each location Maximum salary
SELECT l.location_name,
       MAX(e.salary) AS MaximumSalary
FROM employees e
INNER JOIN location l
ON e.location_id = l.location_id
GROUP BY l.location_id, l.location_name;        ## Displays the maximum salary for each location along with its location name.
##--Calculate the average salary for each designation containing the word 'Analyst'--
SELECT designation, avg(salary) as AVERAGE_SALARY 
FROM employees  WHERE designation LIKE '%Analyst%'
GROUP BY designation;         ## LIKE '%Analyst%' finds any designation containing Analyst.
##Task 5--Having--
  ##--Find departments with less than 3 employees--
SELECT department_id, COUNT(employee_id) as EmployeeCount
FROM employees GROUP BY department_id 
Having count(employee_id) < 3;                   ## HAVING filters the grouped results.  
##--Locations with female employees whose average age is below 30--
SELECT location_id, avg(age) as AverageAge
FROM employees WHERE gender = 'F'   ##  selects female employees.
GROUP BY location_id        ## Group them by location.
Having avg(age) < 30 ;   ## avg(age)-->calculates average age.##Having avg(age)keeps locations with average age below 30.
SELECT * FROM employees WHERE gender = 'F'; 
SELECT location_id, age, gender
FROM employees;
##--Joins:
##--Task 1 INNER JOIN
USE employee1;
SELECT * FROM employees;
SELECT e.employee_name,
e.designation,
d.department_name 
from employees e
INNER JOIN departments d         ##  Inner Join returns only matching records from both tables.
ON e.department_id = d.department_id;
##--Task 2 Left join
SELECT d.department_name,
COUNT(e.employee_id) as EmployeeCount
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id  ## departments with no employees are also displayed.
GROUP BY d.department_id,d.department_name;
##--Task 3 Right join
SELECT l.location_name,e.employee_name
FROM employees e
RIGHT JOIN location l  ## Right join ensures that all locations are displayed.
ON e.location_id = l.location_id;
##--Task 4 Cross join
SELECT d.department_name,l.location_name
FROM departments d
CROSS JOIN location l;  ## It displays all possible combinations of departments and locations.
##--Task 5 Self Join
SELECT 
e1.employee_name as Employee1,
e2.employee_name as Employee2,
e1.department_id
FROM employees e1
INNER JOIN employees e2
ON e1.department_id = e2.department_id  ## finds employees working in the same department
AND e1.employee_id < e2.employee_id;  ##Here e1 and e2 are not new tables.They are simply two aliases for the same employees table.
## --Windows function--
##--TASK 1 Write a window function query to rank employees by salary using rank().
SELECT employee_id,employee_name,salary,
RANK() OVER(order by salary DESC) as salary_Rank
FROM employees;   ## RANK()-->gives the same rank to employees with the same salary.
##--Task 2 Write a window function query to rank employees by salary within each department using DENSE_RANK()
SELECT employee_id,employee_name,
department_id,salary,
DENSE_RANK() OVER(PARTITION BY                     ## creates separate ranking for each department.
department_id ORDER BY salary DESC                 ## creates separate ranking for each department.
) as Dept_SalaryRank                               ## DENSE_RANK()-->It does not skip rank numbers after ties.
FROM employees;
##--Task 3 Write a window function query, Running total salary by department
SELECT employee_id,
employee_name,department_id,
salary,hire_date,
SUM(salary)OVER(                                                           ##total salary of employees within each department(cummulative).
                PARTITION BY department_id ORDER BY hire_date DESC           ## PARTITION BY department_id separates employees into different departments.
				) AS running_totalsalary                                      ## The running_totalsalary column shows the cumulative salary amount for each department
FROM employees;
     
                

