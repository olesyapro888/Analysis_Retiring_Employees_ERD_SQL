--Determine Retirement Eligibility
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- Retirement eligibility with additioanal condition
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- COUNT() Function. Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--With SELECT INTO
SELECT first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--new table with +1 colomn
DROP TABLE retirement_info;

SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

--with aliases
SELECT d.dept_name,
     dm.emp_no,
     dm.from_date,
     dm.to_date
FROM departments as d
INNER JOIN dept_manager as dm
ON d.dept_no = dm.dept_no;


-- Joining retirement_info and dept_emp tables
SELECT retirement_info.emp_no,
    retirement_info.first_name,
retirement_info.last_name,
    dept_emp.to_date
FROM retirement_info
LEFT JOIN dept_emp
ON retirement_info.emp_no = dept_emp.emp_no;

-- add PK to retiring employees
ALTER TABLE retirement_info
ADD PRIMARY KEY (emp_no);

-- add FK to retiring employees

ALTER TABLE retirement_info
ADD FOREIGN KEY (emp_no) REFERENCES employees(emp_no);

-- Check the table
SELECT * FROM retirement_info;

-- Joining Left for current_emp and dept_employees tables
SELECT ri.emp_no,
    ri.first_name,
    ri.last_name,
	de.to_date
INTO current_emp
FROM retirement_info as ri
LEFT JOIN dept_employees as de
ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01');

--count() current_emp rows
SELECT COUNT(emp_no)
FROM current_emp

-- Employee count by department number
--We added COUNT() to the SELECT statement because we wanted a total number of employees
SELECT COUNT(ce.emp_no), de.dept_no
FROM current_emp as ce
--INTO new_current_emp
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

--order by
SELECT * FROM salaries
ORDER BY to_date DESC;

--new epm_info filtered table
SELECT emp_no,
    first_name,
    last_name,
    gender
INTO emp_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

--join INNER to the salaries table to add the to_date and Salary columns to our query.

--List 1: Employee Information
SELECT e.emp_no,
    e.first_name,
	e.last_name,
    e.gender,
    s.salary,
    de.to_date
--comment out the INTO line so that we don't run it with the res
INTO emp_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
--to_date
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
    AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
    --filter we need is the to_date of 999-01-01 from the dept_emp
    AND (de.to_date = '9999-01-01');

-- List 2 of managers per department
SELECT  dm.dept_no,
        d.dept_name,
        dm.emp_no,
        ce.last_name,
        ce.first_name,
        dm.from_date,
        dm.to_date
-- INTO manager_info
FROM dept_manager AS dm
    INNER JOIN departments AS d
        ON (dm.dept_no = d.dept_no)
    INNER JOIN current_emp AS ce
        ON (dm.emp_no = ce.emp_no);

-- List 3: Department Retirees
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no);

-- Sales info SKILLDRILL1

SELECT  di.dept_name,
        di.emp_no,
        ri.last_name,
        ri.first_name
INTO sales_info
FROM dept_info AS di
    INNER JOIN retirement_info AS ri
        ON (di.emp_no = ri.emp_no)
		WHERE di.dept_name='Sales' 
        

-- SELECT * FROM sales_info

-- Sales info SKILLDRILL2
SELECT  di.dept_name,
        di.emp_no,
        ri.last_name,
        ri.first_name
INTO sales_development_info_2
FROM dept_info AS di
    INNER JOIN retirement_info AS ri
        ON (di.emp_no = ri.emp_no)
        -- WHERE di.dept_name='Sales' OR di.dept_name='Sales'
		WHERE di.dept_name IN ('Sales', 'Development')

SELECT * FROM sales_development_info
-- SELECT film_id, title
-- FROM film 
-- WHERE film_id NOT IN
--   (SELECT film_id 
--    FROM inventory);


- Query 1

SELECT DISTINCT ON (r.customer_id) c.first_name, c.last_name, c.email, r.rental_date 
FROM rental AS r
JOIN customer AS c 
ON (r.customer_id=c.customer_id)
ORDER BY r.customer_id, r.rental_date DESC;


-- Query 2

SELECT DISTINCT ON (f.title ) f.title, r.rental_date
FROM rental AS r
JOIN inventory as i
ON (i.inventory_id = r.inventory_id)
JOIN film as f
ON (f.film_id = i.film_id)
ORDER BY f.title, r.rental_date DESC;

-- Bonus

SELECT film_id, title
FROM film 
WHERE film_id NOT IN
  (SELECT film_id 
   FROM inventory);