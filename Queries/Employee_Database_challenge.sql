-- 1-7 steps of the  Deliverable 1.
SELECT em.emp_no AS "employee num", 
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
ORDER BY "employee num";

-- 8-14 steps of the  Deliverable 1.
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title

INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no ASC, rt.to_date DESC;

-- 15-21 steps of the  Deliverable 1 
-- SELECT title, COUNT(title) AS "title_count"
SELECT COUNT(title) AS "title_count", title
INTO retiring_titles
FROM unique_titles
GROUP BY titles
ORDER BY "title_count" DESC;

SELECT * FROM retiring_titles
-- steps of the  Deliverable 2.
