## ASSIGNMENT 1-SQL DDL COMMANDS AND CONSTRAINTS
## DDL COMMANDS
#--1-DATABASE AND TABLE CREATION--
CREATE DATABASE employee;                     # Database is created as Employee to store the tables
USE employee;                                 # Select the employee database so that the following sql querries will run inside the employee  database

CREATE TABLE departments(                     # The departments table is created with department_id and department_name in the employee database 
department_id INT PRIMARY KEY,   
department_name varchar(50) NOT NULL
);                                  /* The query is to create the departments table including 
									  1)department_id stored as integer & Primary key values-> used to aloow only unique & not null values. 
							          2)department_name is used to store department name and it should not be null.  
									*/
USE employee;                                # Select the employee database so that the following sql querries will run inside the employee  database.

CREATE TABLE location(                       # Location table is created in the employee database
location_id INT PRIMARY KEY,                 # Primary ensures location ID has unique ID
location_name varchar(50)                    #Location name set variable character 100 to store location name 
);                                           # The location table ensures the location_ID is unique identifier and not allows null values

CREATE TABLE employees(                                    # Creation of employees table contains employee details as follows,
employee_id INT PRIMARY KEY,                               # Employee Id is set as as Primary key unqueily identifies each row in the table
employee_name varchar(100) NOT NULL,                       # The employee name stored as Variable character & it won,t allow null data 
gender enum("M","F"),                                      # enum allows only gender as "M" or "F" ,NOT NULL->its prevents the null values
age INT,                                                   # Age is used to store the employee age as interger(whole number) Data type
department_id INT,                                         # store ID of department associate with the Employee
location_id INT,                                           # Store ID of the location associates with Employee
hire_date DATE,                                            # Stores the hire date of the employee
designation varchar(50) NOT NULL,                          # Designation is used to store employee designation and it won't allow null values
salary DECIMAL(10,2)                                       # Stores the Employees salary with 2 decimal points
);

##--2-TABLE ALTERATION--
ALTER TABLE employees ADD COLUMN email varchar(100);                # Adds anew column named email
ALTER TABLE employees MODIFY COLUMN designation varchar(100);       #The query changes the designation size 50 into 100 character
ALTER TABLE employees DROP COLUMN age;                              #Permanantely removes the age column from the table
ALTER TABLE employees RENAME COLUMN hire_date TO date_of_joining;   #Query changes the Column name from hire_date to date_of_joining without deleting data
#--3-TABLE RENAMING--
RENAME TABLE departments TO departments_info;                       #Changes the table name from departments to departments_info
RENAME TABLE location TO locations;                                 #This query changes table name loction into locations
#--4-TRUNCATING TABLE---                        
TRUNCATE TABLE employees;                                           #This query delete all records from the table but keeps structure,column
#--5-DATABASE AND TABLE DROPPING--                                  
DROP TABLE employees;                                               #Remove entire table including structure & all stored data in it
DROP DATABASE employee;                                             #Delete the entire employee database including all tables which is stored in it
#--Task->Constraints--
#--1)DATABASE RECREATION--
DROP DATABASE employee;                                             #If database employee exist it will drop the database ortherwise it will move to next query
CREATE DATABASE employee;                                           #Already dropped the database employee so,recreate the employee database
USE employee;                                                       #Select the database to use to store the tables
#--2)DEPARTMENTS TABLE CREATION--
CREATE TABLE departments(                                           #Department table is recreated 
department_id INT PRIMARY KEY,                                      #Stores the unique ID of each department,Unique cannot be null
department_name varchar(100) NOT NULL UNIQUE                        #This store the department name upto 100 characters and unique,prevents duplicates,Shouldnot be null
);
#--3)LOCATIONS TABLE CREATION--
CREATE TABLE locations(                                             #Recreation of location table
location_id INT AUTO_INCREMENT PRIMARY KEY,                         #Stores location Id,automaticallu generates IDs,Each locationID is unique
location_name varchar(100) NOT NULL UNIQUE                          #Store location name not allow the null and location should be unique
);
#--4)EMPLOYEES TABLE CREATION--                         
CREATE TABLE employees(                            #Created the employee table 
employee_id INT PRIMARY KEY,                       #Creates unique idetifier for every employee.Primary key is used to prevents duplicates and Null IDs
employee_name varchar(100) NOT NULL,               #Stores the employee's name and every employee must have name 
gender ENUM("M","F") NOT NULL,                     #The enum allows gender as"M","F",Not null prevents empty value
age INT NOT NULL CHECK( age>=18),                  #Stores the employee age and the check the constraint as employee age is 18 or above
hire_date DATE DEFAULT(CURRENT_DATE),              #It stores the employees joining date if there is no date is inserted then will take joining date as current date
department_id INT NOT NULL,                        #Stores the department Id associate with the employee,Not null shows every employee has department
location_id INT NOT NULL,                          #stores the location Id associate with employee,it should not be null value
CONSTRAINT chk_gender                              #Gives the name to the constraint as chk_gender
CHECK (gender IN("M","F")),                        #check theenter value follows the given condition,it allows only "M","F"
CONSTRAINT fk_employee_department                  #Gives the name to the foreign key constraint
FOREIGN KEY (department_id) REFERENCES departments(department_id),   #Make the department_id as foreign key in the employee table connect to department+id of deparment table
CONSTRAINT fk_employee_locations                                     #Gives the name to foreign key constraint
FOREIGN KEY (location_id) REFERENCES locations(location_id)          #Make a location_id as foreign key in the employee table connect it to location table
);


