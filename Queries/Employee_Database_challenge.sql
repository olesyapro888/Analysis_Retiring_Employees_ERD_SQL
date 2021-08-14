-- 1-7 nstructions below to complete Deliverable 1.
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
