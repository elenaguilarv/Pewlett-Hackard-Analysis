-- Challenge: Table 1 Part 1
-- Total number of employees retiring by title
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	ti.title,
	ti.from_date,
	ti.to_date,
	s.salary
INTO titles_ri
FROM retirement_info AS ri
INNER JOIN titles as ti
ON (ri.emp_no = ti.emp_no)
INNER JOIN salaries as s
ON (ri.emp_no = s.emp_no);

SELECT * FROM titles_ri
SELECT COUNT (*) FROM clean_ri_titles;

-- partition the data to show most recent titles per employee
SELECT emp_no,
 		first_name,
		last_name,
		title,
 		from_date
INTO clean_ri_titles
FROM
 (SELECT emp_no,
 	first_name,
	last_name,
	title,
  	from_date,
ROW_NUMBER () OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM titles_ri
 ) tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM clean_ri_titles
SELECT COUNT (*) FROM clean_ri_titles;

-- Challenge Table 2 of Part 1
-- Retirement numbers categorized by Title
SELECT COUNT(rit.emp_no), rit.title
INTO ri_titles2
FROM clean_ri_titles as rit
GROUP BY rit.title;

SELECT * FROM ri_titles2

-- Current Employees born between 1952-1955
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	ti.title,
	s.salary,
	s.from_date
-- INTO info_emp_52-55
FROM employees as e
INNER JOIN titles as ti
ON (e.emp_no = ti.emp_no)
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31');
	 

-- Challenge Part 2: Mentorship Eligibility
-- Select specific to be retired employee info
SELECT e.emp_no, 
		e.first_name, 
		e.last_name,
		e.birth_date,
		ti.title,
		de.from_date, 
		de.to_date
INTO mentor
FROM employees as e
INNER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
INNER JOIN dept_emp as de
	ON (e.emp_no = de.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31');

SELECT * FROM mentor 

-- partition the data to show most recent titles per employee
SELECT emp_no,
 		first_name,
		last_name,
		title,
 		from_date, 
		to_date
INTO mentor_elig
FROM
 (SELECT emp_no,
 	first_name,
	last_name,
	title,
  	from_date,
  	to_date,
ROW_NUMBER () OVER
 (PARTITION BY (emp_no)
 ORDER BY to_date DESC) rn
 FROM mentor
 ) tmp WHERE rn = 1
ORDER BY emp_no;

SELECT * FROM mentor_elig