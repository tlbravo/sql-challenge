CREATE TABLE departments (
	dept_no varchar(4) NOT NULL,
	dept_name varchar(20) NOT NULL,
	PRIMARY KEY(dept_no));
	
CREATE TABLE employees (
    emp_no int NOT NULL,
    emp_title varchar(5) NOT NULL,
    birth_date date NOT NULL,
    first_name varchar(40) NOT NULL,
    last_name varchar(40) NOT NULL,
    sex char(1) NOT NULL,
    hire_date date NOT NULL,
	PRIMARY KEY(emp_no));
	
CREATE TABLE dept_manager (
	dept_no varchar(4) NOT NULL,
	emp_no int NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no),
	FOREIGN KEY (dept_no) references departments(dept_no));
	
CREATE TABLE dept_emp (
	emp_no int NOT NULL,
	dept_no varchar(4) NOT NULL,
	FOREIGN KEY (emp_no) references employees (emp_no));
	
CREATE TABLE salaries (
	emp_no int NOT NULL,
	salary int NOT NULL);
	
CREATE TABLE titles (
	title_id varchar(5),
	title varchar(30));
	