CREATE TABLE Departments (
			dept_no VARCHAR(4) NOT NULL,
			dept_name VARCHAR (40) NOT NULL,
	PRIMARY KEY (dept_no),
	UNIQUE 	(dept_name)
);
CREATE TABLE dept_emp (
			emp_no int NOT NULL, 
			dept_no int NOT NULL,
			from_date date NOT NULL,
			to_date date NOT NULL,
			PRIMARY KEY (emp_no),
			UNIQUE (dept_no),
 
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);


CREATE TABLE Employees(			
			emp_no INT NOT NULL,
     		birth_date DATE NOT NULL,
     		first_name VARCHAR NOT NULL,
     		last_name VARCHAR NOT NULL,
     		gender VARCHAR NOT NULL,
     		hire_date DATE NOT NULL,
     		PRIMARY KEY (emp_no),			
FOREIGN KEY (emp_no) REFERENCES salaries (emp_no)
);

CREATE TABLE Dept_Manager(
			dept_no VARCHAR(4) NOT NULL,
			emp_no INT NOT NULL,
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

DROP TABLE EMPLOYEES CASCADE;

CREATE TABLE Titles(
			emp_no int NOT NULL,
			title VARCHAR NOT NULL,
			from_date date NOT NULL,
			to_date date NOT NULL,
	PRIMARY KEY (emp_no),
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
 FOREIGN KEY (emp_no) REFERENCES dept_emp (emp_no),
  PRIMARY KEY (emp_no)
);
SELECT * FROM DEPARTMENTS ;

SELECT * FROM EMPLOYEES;

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';


-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');



SELECT  first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

select * from retirement_info;
