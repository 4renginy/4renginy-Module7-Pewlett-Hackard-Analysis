SELECT e.emp_no,
    e.first_name,
	e.last_name,
    t.title,
	t.from_date,
	t.to_Date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY(e.emp_no);


-- Use Dictinct with Orderby to remove duplicate rows

SELECT DISTINCT ON (emp_no ) rt.emp_no,
							rt.first_name,
							rt.last_name,
							rt.title
				INTO unique_titles
				FROM retirement_titles as rt
				ORDER BY rt.emp_no asc, to_date desc ;

--SELECT 90398  Query returned successfully

SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY ut.title
ORDER BY COUNT(ut.emp_no) DESC;


SELECT DISTINCT ON (e.emp_no )e.emp_no,
    e.first_name,
	e.last_name,
	e.birth_date,
    de.from_date,
	de.to_date,
	ti.title
--INTO mentorship_eligibilty
FROM employees as e
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no)
INNER JOIN titles as ti
ON (e.emp_no= ti.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
ORDER BY(e.emp_no);