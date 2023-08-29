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
	
-- List the employee number, last name, first name, sex, and salary of each employee.

SELECT s.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
Inner Join salaries as s 
ON s.emp_no = e.emp_no
ORDER BY s.emp_no;

-- List the first name, last name, and hire date for the employees who were hired in 1986.
--https://www.w3schools.com/sql/func_mysql_extract.asp
SELECT first_name, last_name, hire_date
FROM employees 
WHERE EXTRACT (YEAR FROM hire_date) = 1986;

--List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT DISTINCT ON (dm.dept_no) d.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
Inner Join departments d 
ON dm.dept_no = d.dept_no
Inner Join employees as e 
ON dm.emp_no = e.emp_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.last_name, e.first_name, d.dept_name, de.dept_no
FROM employees AS e 
Left Join dept_emp as de 
ON e.emp_no = de.emp_no
Inner Join departments d
ON d.dept_no = de.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT e.last_name, e.first_name, e.sex
FROM employees AS e 
WHERE e.first_name = 'Hercules' AND e.last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM departments as d 
Left Join dept_emp as de 
ON d.dept_no = de.dept_no
Inner Join employees e
on e.emp_no = de.emp_no
WHERE d.dept_name = 'Sales';

--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT d.dept_name, e.emp_no, e.last_name, e.first_name
FROM employees as e 
Inner Join dept_emp as de 
ON e.emp_no = de.emp_no
Inner Join departments as d 
on de.dept_no  = d.dept_no
WHERE d.dept_name In ('Sales', 'Development')
GROUP BY d.dept_name, e.emp_no, e.last_name, e.first_name;

--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
--https://www.c-sharpcorner.com/blogs/sql-query-to-find-out-the-frequency-of-each-element-in-a-column1
SELECT last_name, COUNT (*) as Frequency 
FROM employees
GROUP BY last_name 
ORDER BY Frequency DESC;
