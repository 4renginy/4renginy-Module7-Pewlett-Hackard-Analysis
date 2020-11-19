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
				--INTO unique_titles
				FROM retirement_titles as rt
				ORDER BY rt.emp_no asc, to_date desc ;

--SELECT 90398  Query returned successfully

				SELECT COUNT(ut.emp_no), ut.title
				INTO retiring_titles
				FROM unique_titles as ut
				GROUP BY ut.title
				ORDER BY COUNT(ut.emp_no) DESC;
				
_______________MENTORSHIP ELIGIBILITY__________________________	

SELECT DISTINCT ON (e.emp_no )e.emp_no,
							e.first_name,
							e.last_name,
							e.birth_date,
							de.from_date,
							de.to_date,
							ti.title
				INTO mentorship_eligibilty
				FROM employees as e
				INNER JOIN dept_emp as de
				ON (e.emp_no = de.emp_no)
				INNER JOIN titles as ti
				ON (e.emp_no= ti.emp_no)
				WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
				ORDER BY(e.emp_no);



_____________ADDITIONAL QUERIES________________
			
			CURRENT RETIREEES QUERY

SELECT DISTINCT ON (emp_no ) rt.emp_no,
						rt.first_name,
						rt.last_name,
						rt.title,
						rt.from_date,
						rt.to_date
				--INTO rettit_current
				FROM retirement_titles as rt
				where (to_date='9999/01/01')
				ORDER BY rt.emp_no asc, to_date desc ;
	
--SELECT 72458   Query returned successfully 

______________CURRENT RETIREE COUNT_______________
	
SELECT COUNT (rettit_current.emp_no), rettit_current.title 
				--INTO rettit_count_current
				FROM rettit_current
				GROUP BY rettit_current.title
				ORDER BY COUNT desc;

--SELECT 7  Query returned successfully

___________________CURRENT RETIREES BY DEPARTMENT__________________				
				
SELECT DISTINCT ON (emp_no ) rt.emp_no,
						rt.first_name,
						rt.last_name,
						rt.title,
						rt.from_date,
						rt.to_date,
						d.dept_name
				INTO currentret_bydept
				FROM retirement_titles as rt
				inner join dept_emp as de
				on (rt.emp_no=de.emp_no)
				inner join departments as d
				on (de.dept_no=d.dept_no)
				where (rt.to_date='9999/01/01')
				ORDER BY rt.emp_no asc, to_date desc ;
				
--SELECT 72458    Query returned successfully

	
SELECT COUNT (dept_name), cb.dept_name
				INTO current_ret_by_dept1
				FROM currentret_bydept as cb
				GROUP BY dept_name;
--SELECT 9   Query returned successfully


		______________MENTORSHIP COUNT BY TITLE___________				

SELECT DISTINCT ON (e.emp_no )e.emp_no,
							e.first_name,
							e.last_name,
							e.birth_date,
							de.from_date,
							de.to_date,
							ti.title,
							d.dept_name
				INTO mentorship_eligibilty1
				FROM employees as e
				INNER JOIN dept_emp as de
				ON (e.emp_no = de.emp_no)
				INNER JOIN titles as ti
				ON (e.emp_no= ti.emp_no)
				inner join departments as d
				ON de.dept_no=d.dept_no
				WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (de.to_date = '9999-01-01')
				ORDER BY(e.emp_no);
				
SELECT COUNT(dept_name), dept_name
				INTO mentorship_eligibilityby_dept
				FROM mentorship_eligibilty1 as me
				GROUP BY dept_name;			
			
				
SELECT COUNT(emp_no), title

				--INTO eligibility_count
				FROM mentorship_eligibilty
				GROUP BY title
				ORDER BY COUNT(emp_no ) desc;
				


