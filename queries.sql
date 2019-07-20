CREATE TABLE departments(
	dept_no VARCHAR(5) PRIMARY KEY,
	dept_name VARCHAR(25)
);

CREATE TABLE employees(
	emp_no INTEGER PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	gender VARCHAR(1),
	hire_date DATE
);

CREATE TABLE dept_emp(
	emp_no INTEGER,
	dept_no VARCHAR(5),
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(5),
	emp_no INTEGER,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE titles(
	emp_no INTEGER,
	title VARCHAR(255),
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE salaries(
	emp_no INTEGER,
	salary INTEGER,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);


-- List the following details of each employee: 
-- employee number, last name, first name, gender, and salary.

CREATE VIEW emp_list AS
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
JOIN salaries AS s ON
e.emp_no=s.emp_no;

SELECT * FROM emp_list;

-- List employees who were hired in 1986.

CREATE VIEW hired_1986 AS
SELECT emp_no, first_name, last_name
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

SELECT * FROM hired_1986;

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name, and start and end employment dates.

CREATE VIEW manager_list AS
SELECT e.emp_no, e.first_name, e.last_name, dpt.dept_no, dpt.dept_name, dm.from_date, dm.to_date 
FROM employees AS e
JOIN dept_manager AS dm 
ON (e.emp_no=dm.emp_no)
	JOIN departments AS dpt
	ON (dm.dept_no = dpt.dept_no);

SELECT * FROM manager_list;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

CREATE VIEW emp_depts AS
SELECT e.emp_no, e.last_name, e.first_name, dpt.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no=de.emp_no)
	JOIN departments AS dpt
	ON (de.dept_no = dpt.dept_no);
	
SELECT * FROM emp_depts;


-- List all employees whose first name is "Hercules" and last names begin with "B."

CREATE VIEW hercules_b AS
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'b%';

SELECT * FROM hercules_b;


-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.

CREATE VIEW sales_emps AS
SELECT e.emp_no, e.last_name, e.first_name, dpt.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no=de.emp_no)
	JOIN departments AS dpt
	ON (de.dept_no=dpt.dept_no)
	WHERE dept_name = 'Sales';
	
SELECT * FROM sales_emps;

-- List all employees in the Sales and Development departments, 
-- including their employee number, last name, first name, and department name.

CREATE VIEW sales_and_dev_emps AS
SELECT e.emp_no, e.last_name, e.first_name, dpt.dept_name
FROM employees AS e
JOIN dept_emp AS de
ON (e.emp_no=de.emp_no)
	JOIN departments AS dpt
	ON (de.dept_no=dpt.dept_no)
	WHERE dept_name = 'Sales'
	OR dept_name = 'Development';

SELECT * FROM sales_and_dev_emps;

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

CREATE VIEW last_name_frequency AS
SELECT last_name, COUNT(last_name) AS "Frequency"
FROM employees
GROUP BY last_name
ORDER BY "Frequency" DESC;

SELECT * FROM last_name_frequency;

