---SETTING UP TABLES AND SCHEMA---

CREATE TABLE Departments (
    dept_no VARCHAR(255) PRIMARY KEY NOT NULL,
    dept_name VARCHAR(255) NOT NULL
);


CREATE TABLE Titles (
    title_id VARCHAR(255) PRIMARY KEY NOT NULL,
    title VARCHAR(255) NOT NULL
);


CREATE TABLE Employees (
    emp_no INT PRIMARY KEY NOT NULL,
    emp_title_id VARCHAR(255) NOT NULL,
	FOREIGN KEY (emp_title_id) REFERENCES Titles(title_id),
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex VARCHAR(255) NOT NULL,
    hire_date DATE NOT NULL
);


CREATE TABLE Salaries (
    emp_no INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    salary INT NOT NULL
);


CREATE TABLE Department_Employee (
	emp_no INT NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
    dept_no VARCHAR(255) NOT NULL,
  	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
	PRIMARY KEY (dept_no, emp_no)
);


CREATE TABLE Department_Manager (
  dept_no VARCHAR(255) NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
  emp_no INTEGER NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
  PRIMARY KEY (dept_no, emp_no)
);

--Imported Data---
--Data Analysis--
----List the employee number, last name, first name, sex, and salary of each employee----
SELECT Employees.emp_no, Employees.last_name, Employees.first_name, Employees.sex, Salaries.salary
FROM Employees
JOIN Salaries ON Employees.emp_no = Salaries.emp_no;

----List the first name, last name, and hire date for the employees who were hired in 1986.----
SELECT first_name, last_name, hire_date
FROM Employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

----List the manager of each department along with their department number, department name, employee number, last name, and first name----
SELECT Department_Manager.dept_no, Department_Manager.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Department_Manager
JOIN Departments ON Department_Manager.dept_no = Departments.dept_no
JOIN Employees ON Department_Manager.emp_no = Employees.emp_no;

----List the department number for each employee along with that employee’s employee number, last name, first name, and department name.----
SELECT Department_Employee.emp_no, Department_Employee.dept_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Department_Employee
JOIN Departments ON Department_Employee.dept_no = Departments.dept_no
JOIN Employees ON Department_Employee.emp_no = Employees.emp_no;

----List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.----
SELECT first_name, last_name, sex
FROM Employees
WHERE first_name = 'Hercules' 
AND last_name LIKE 'B%';

----List each employee in the Sales department, including their employee number, last name, and first name.----
SELECT Department_Employee.emp_no, Employees.last_name, Employees.first_name
FROM Department_Employee
JOIN Departments ON Department_Employee.dept_no = Departments.dept_no
JOIN Employees ON Department_Employee.emp_no = Employees.emp_no
WHERE dept_name = 'Sales';

----List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.----
SELECT Department_Employee.emp_no, Employees.last_name, Employees.first_name, Departments.dept_name
FROM Department_Employee
JOIN Departments ON Department_Employee.dept_no = Departments.dept_no
JOIN Employees ON Department_Employee.emp_no = Employees.emp_no
WHERE dept_name = 'Sales'OR dept_name = 'Development';

----List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name----
SELECT last_name, COUNT(*)
FROM Employees
GROUP BY last_name
ORDER BY count DESC;

