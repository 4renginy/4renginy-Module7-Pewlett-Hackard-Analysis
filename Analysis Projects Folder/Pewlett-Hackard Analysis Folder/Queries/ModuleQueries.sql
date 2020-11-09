CREATE TABLE Departments (
			dept_no VARCHAR(4) NOT NULL,
			dept_name VARCHAR (40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE 	(dept_name)
);

________________________________________________________________________________________
CREATE TABLE Employees(			
			emp_no INT NOT NULL,
     		birth_date DATE NOT NULL,
     		first_name VARCHAR NOT NULL,
     		last_name VARCHAR NOT NULL,
     		gender VARCHAR NOT NULL,
     		hire_date DATE NOT NULL,
     		PRIMARY KEY (emp_no)
);
	
ALTER TABLE Employees ADD FOREIGN KEY (emp_no) REFERENCES salaries (emp_no);
select * from employees;	
______________________________________________________________________________________
CREATE TABLE Dept_Manager(
			dept_no VARCHAR(4) NOT NULL,
			emp_no INT NOT NULL,
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
			PRIMARY KEY (emp_no, dept_no),
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
			);
_______________________________________________________________________________________________
	
CREATE TABLE dept_emp (
   		emp_no INT NOT NULL,
		dept_no VARCHAR(4) NOT NULL,
    	from_date DATE NOT NULL,
    	to_date DATE NOT NULL,
		UNIQUE
		FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
		FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);
________________________________________________________________________________________
CREATE TABLE salaries (
  			emp_no INT NOT NULL,
  			salary INT NOT NULL,
  			from_date DATE NOT NULL,
  			to_date DATE NOT NULL,
			--PRIMARY KEY (emp_no),
			FOREIGN KEY (emp_no) REFERENCES dept_emp (emp_no)
	);
_____________________________________________________________________________________

CREATE TABLE Titles(
			emp_no int NOT NULL,
			title VARCHAR NOT NULL,
			from_date date NOT NULL,
			to_date date NOT NULL,
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
	);	
	
select * from titles;
_____________________________________________________________________________________
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

___________________________________________________________________________________________
-- Retirement eligibility
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');
___________________________________________________________________________________________
-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--41380 the count of employees
--to add the employee number drop the table first then recreate it 
DROP TABLE retirement_info;

___________________________________________________________________________________________
-- Create new table for retiring employees
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Check the table
SELECT * FROM retirement_info;

--41380 records 
___________________________________________________________________________________________
--Joining departments and dept_manager tables
SELECT departments.dept_name,
	dept_manager.emp_no,
	dept_manager.from_date,
	dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no=dept_manager.dept_no;


--writing the same query with aliases.

SELECT d.dept_name,
		dm.emp_no,
		dm.from_date,
		dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no=dm.dept_no;

___________________________________________________________________________________________

-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    	retirement_info.first_name,
		retirement_info.last_name,
    	dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

--writing the same statment with allies

SELECT ri_info.emp_no,
	ri_info.first_name,
	ri_info.last_name
	de.to_date
FROM retirement_info AS ri
LEFT JOIN dept_emp as de
ON ri.emp_no=de.emp_no
___________________________________________________________________________________________

SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_emp as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--SELECT 33118 query returned successfully in 389 msec.
_____________________________________________________________________________________________
-- Employee count by department number

SELECT COUNT (ce.emp_no),de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;
________________________________________________________________________
CREATE TABLE countret_bydept as (
SELECT COUNT (ce.emp_no),de.dept_no
FROM current_emp as ce
LEFT JOIN dept_emp as de
ON ce.emp_no=de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no);

--SELECT * FROM countret_bydept;

__________________________________________________________________________________________
--Employee Information
--A list of employees containing their unique employee number, their last name, first name,
--gender, and salary

SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info
FROM employees as e
INNER JOIN salary as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31') AND (de.to_date = '9999-01-01');
___________________________________________________________________________________________

--Management information
--A list of managers for each department, including the department number, 
--name, and the manager's employee number, last name, first name, and the starting 
--and ending employment dates

-- List of managers per department
SELECT  dm.dept_no, d.dept_name, dm.emp_no,ce.last_name,ce.first_name,
       	dm.from_date, dm.to_date
INTO manager_info
FROM dept_manager AS dm
	INNER JOIN 	departments AS d
	ON (dm.dept_no=d.dept_no)
	INNER JOIN current_emp AS ce
	ON (dm.emp_no=ce.emp_no);
--Select 5 query returned
___________________________________________________________________________________________

--Department Retirees: 
--An updated current_emp list that includes everything it currently has, 
--but also the employee's departments
SELECT  ce.emp_no,
		ce.first_name,
		ce.last_name,
		d.dept_name
INTO dept_info
FROM current_emp as ce
	INNER JOIN dept_emp AS de
	ON (ce.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no = d.dept_no);
	
________________________________________________________________________________________________
SELECT ri.emp_no,
    	ri.first_name,
    	ri.last_name,
		d.dept_name
INTO tailored_for_sales
FROM retirement_info as ri
	LEFT JOIN dept_emp as de
	ON (ri.emp_no = de.emp_no)
	INNER JOIN departments as d
	ON (de.dept_no=d.dept_no)
	WHERE d.dept_name='Sales';
--Successfully run.7301 rows affected.	
___________________________________________________________________________________________
SELECT ri.emp_no,
    	ri.first_name,
    	ri.last_name,
		d.dept_name
INTO tailored_for_SalesDevelopment
FROM retirement_info AS ri
	LEFT JOIN dept_emp AS de
	ON (ri.emp_no = de.emp_no)
	INNER JOIN departments AS d
	ON (de.dept_no=d.dept_no)
	WHERE d.dept_name IN ('Sales','Development');
	
--Successfully run.18928 rows affected.
___________________________________________________________________________________________

