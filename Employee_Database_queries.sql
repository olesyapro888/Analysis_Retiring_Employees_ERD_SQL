-- 1-7 steps of the  Deliverable 1 (create a Retirement Titles table that holds all 
-- the titles of current employees who were born between January 1, 1952 and December 31, 1955).
SELECT em.emp_no, 
       em.first_name, 
       em.last_name,
       ti.title, 
       ti.from_date,
       ti.to_date
INTO retirement_titles
FROM employees AS em
    INNER JOIN titles AS ti
      ON (em.emp_no = ti.emp_no)
    WHERE em.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY em.emp_no;

-- 8-14 steps of the  Deliverable 1 (use the DISTINCT ON statement to create a table 
-- that contains the most recent title of each employee).
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

SELECT * FROM unique_titles

-- 15-21 steps of the  Deliverable 1  (use the COUNT() function to create a final table 
-- that has the number of retirement-age employees by most recent job title).
SELECT COUNT(title) AS "title_count", title
INTO retiring_titles
FROM unique_titles
GROUP BY titles
ORDER BY "title_count" DESC;

SELECT * FROM retiring_titles

-- 1-11 steps of the Deliverable 2 (create a Mentorship Eligibility table for current employees 
-- who were born between January 1, 1965 and December 31, 1965).
SELECT DISTINCT ON (em.emp_no) em.emp_no AS "emp_no", 
					em.first_name, 
					em.last_name, 
					em.birth_date,
					de.from_date, 
					de.to_date, 
					ti.title
INTO mentorship_eligibilty
FROM employees AS em
	INNER JOIN dept_employees AS de 
		ON (em.emp_no = de.emp_no)
	INNER JOIN titles AS ti 
		ON (em.emp_no = ti.emp_no)
	WHERE de.to_date = ('9999-01-01') AND
	(em.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY "emp_no";

SELECT * FROM mentorship_eligibilty

-- Deliverable 3. Results. Current employees in Retirement_titles
SELECT COUNT(emp_no) AS "emp_count",
		title
FROM retirement_titles
WHERE to_date = ('9999-01-01')
GROUP BY title
ORDER BY "emp_count" DESC;

-- TTl mentorship_eligibilty
SELECT COUNT(emp_no) AS "emp_count",
		title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY "emp_count" DESC;

SELECT count(*) 
FROM mentorship_eligibilty

-- Deliverable 3. Summsary. Additional query. Retiring_years
SELECT DISTINCT ON (em.emp_no) em.emp_no AS "emp_no", 
					em.first_name, 
					em.last_name, 
					em.birth_date,
					de.from_date, 
					de.to_date, 
					ti.title
INTO retiring_years
FROM employees AS em
	INNER JOIN dept_employees AS de 
		ON (em.emp_no = de.emp_no)
	INNER JOIN titles AS ti 
		ON (em.emp_no = ti.emp_no)
	WHERE de.to_date = ('9999-01-01') AND
	(em.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY "emp_no";

SELECT COUNT(emp_no), 
	   EXTRACT(YEAR FROM birth_date) AS birth_year
FROM retiring_years
GROUP BY birth_year
ORDER BY birth_year ASC;

-- Deliverable 3. Summary. Additional query 2. Mentorship_eligibilty_dept
SELECT count(title),
		d.dept_name
INTO mentorship_eligibilty_dept
FROM mentorship_eligibilty AS me
	INNER JOIN dept_employees AS de ON (me.emp_no = de.emp_no)
	INNER JOIN departments AS d ON (d.dept_no = de.dept_no)
GROUP BY d.dept_name

SELECT * FROM mentorship_eligibilty_dept

