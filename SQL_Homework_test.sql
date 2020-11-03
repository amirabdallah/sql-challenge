
--Create employees table
CREATE TABLE employees (
    emp_no int PRIMARY KEY,
    emp_title_id VARCHAR(10), --FK >- titles.title_id
    birth_date date,
    first_name VARCHAR(30) NOT NULL,
    last_name  VARCHAR(30) NOT NULL,
    sex VARCHAR(1),
    hire_date date
);

--complete Import of Employees

-- Create salary table
CREATE TABLE salary (
    emp_no int,
    Primary KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no), --FK >- employees.emp_no
    salary money
);
--comeplete Import of Salaries

-- select all salaries for employee numbers in the employees table (test foreign key)
select employees.emp_no, salary.salary
FROM employees
JOIN salary AS salary
  ON employees.emp_no = salary.emp_no

--create titles table
CREATE TABLE titles (
    title_id VARCHAR,
    PRIMARY KEY (title_id),
    title VARCHAR(30)
)

--complete import of titles

--create departments table
CREATE TABLE departments (
    dept_no VARCHAR(10),
    PRIMARY KEY (dept_no),
    dept_name VARCHAR(30)
);

--IMPORT departments data

--Create dept_emp table
CREATE TABLE dept_emp (
    emp_no int,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    dept_no VARCHAR(10),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    PRIMARY KEY (emp_no, dept_no) -- Creates a compsite key to have both values looked at as a primary key (unqiue record identifier)
);

--import dept_emp table csv

--Create dept_manager table
CREATE TABLE dept_manager(
	dept_no VARCHAR(10),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    emp_no int,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    PRIMARY KEY (dept_no,emp_no) -- Creates a compsite key to have both values looked at as a primary key (unqiue record identifier)
);

--note that the difference between the dept_manager table and dept_emp table
--dept_no is looked at first when creating a unique record where as in the dept
--_emp tabl the employee number is looked at first this makes a difference of how
--the data can be read in both tables when importing csv

--Import dept_manager data

1. List the following details of each employee: employee number, last name, first name, sex, and salary.

select employees.emp_no,employees.first_name, employees.last_name,employees.sex, salary.salary
FROM employees
JOIN salary AS salary
  ON employees.emp_no = salary.emp_no

2. List first name, last name, and hire date for employees who were hired in 1986.

select first_name, last_name, hire_date 
from employees
where hire_date between '01/01/1986' and '12/31/1986'

3. List the manager of each department with the following information: department number, department name, the managers employee number, last name, first name.

select dept_manager.emp_no, dept_manager.dept_no, departments.dept_name, employees.first_name, employees.last_name
from dept_manager
JOIN employees
  ON dept_manager.emp_no = employees.emp_no
JOIN departments 
  ON dept_manager.dept_no = departments.dept_no

4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp
  ON employees.emp_no = dept_emp.emp_no
JOIN departments
  ON departments.dept_no = dept_emp.dept_no

5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select first_name,last_name, sex 
from employees
where first_name = 'Hercules' and last_name like '%B%'

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp
  ON employees.emp_no = dept_emp.emp_no
JOIN departments
  ON departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales'

7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select employees.emp_no, employees.first_name, employees.last_name, departments.dept_name
FROM employees
JOIN dept_emp
  ON employees.emp_no = dept_emp.emp_no
JOIN departments
  ON departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales' or dept_name = 'Development'

8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

SELECT  last_name,  COUNT(*) occurrences
FROM employees
GROUP BY
last_name