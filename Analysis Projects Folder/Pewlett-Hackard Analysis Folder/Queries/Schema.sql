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
     		PRIMARY KEY (emp_no),
			FOREIGN KEY (emp_no) REFERENCES salaries (emp_no);
);
	
--ALTER TABLE Employees PRIMARY KEY (emp_no);	
--ALTER TABLE Employees ADD FOREIGN KEY (emp_no) REFERENCES salaries (emp_no);
	
______________________________________________________________________________________
CREATE TABLE Dept_Manager(
			dept_no VARCHAR(4) NOT NULL,
			emp_no INT NOT NULL,
			from_date DATE NOT NULL,
			to_date DATE NOT NULL,
			PRIMARY KEY (emp_no, dept_no),
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			FOREIGN KEY (dept_no) REFERENCES departments (dept_no);
			);
--ALTER TABLE Dept_Manager ADD PRIMARY KEY (emp_no, dept_no)
--ALTER TABLE Dept_Manager ADD FOREIGN KEY (emp_no) REFERENCES employees (emp_no);
--ALTER TABLE Dept_Manager ADD FOREIGN KEY (dept_no) REFERENCES departments (dept_no);
_____________________________________________________________________________________

CREATE TABLE salaries (
  			emp_no INT NOT NULL,
  			salary INT NOT NULL,
  			from_date DATE NOT NULL,
  			to_date DATE NOT NULL,
			PRIMARY KEY (emp_no)
			FOREIGN KEY (emp_no) REFERENCES dept_emp (emp_no)
	);
	
--ALTER TABLE salaries ADD FOREIGN KEY (emp_no) REFERENCES dept_emp (emp_no);
	
_______________________________________________________________________________________________
	
CREATE TABLE dept_emp (
			emp_no int NOT NULL, 
			dept_no varchar NOT NULL,
			from_date date NOT NULL,
			to_date date NOT NULL,
			UNIQUE (dept_no),
			PRIMARY KEY (emp_no),
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
			FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
	);
--ALTER TABLE dept_emp ADD UNIQUE (dept_no);
--ALTER TABLE dept_emp ADD PRIMARY KEY (emp_no);
--ALTER TABLE dept_emp ADD FOREIGN KEY (emp_no) REFERENCES employees (emp_no);
--ALTER TABLE dept_emp ADD FOREIGN KEY (dept_no) REFERENCES departments (dept_no);
________________________________________________________________________________________
	
	
CREATE TABLE Titles(
			emp_no int NOT NULL,
			title VARCHAR NOT NULL,
			from_date date NOT NULL,
			to_date date NOT NULL
			PRIMARY KEY (emp_no),
			FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
	);
--ALTER TABLE Titles ADD PRIMARY KEY (emp_no);	
--ALTER TABLE Titles ADD FOREIGN KEY (emp_no) REFERENCES employees (emp_no);

