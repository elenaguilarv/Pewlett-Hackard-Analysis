-- Retirement info for Sales team "d007"
-- List to include: emp_no, first & last name, dept_no
SELECT * FROM ri;
SELECT * FROM ri_dept;

SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,	
	de.dept_no
INTO sales_dept_ri
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE dept_no = 'd007';

SELECT * FROM sales_dept_ri

SELECT sd.emp_no,
		sd.first_name,
		sd.last_name,
		d.dept_name
INTO clean_sales_ri
FROM departments as d
LEFT join sales_dept_ri as sd
ON d.dept_no = sd.dept_no

SELECT * FROM clean_sales_ri

-- Retirement info for employees in Sales and Development
-- List to include: emp_no, first & last name, dept_no
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,	
	de.dept_no
INTO ri_dev_sales
FROM retirement_info AS ri
LEFT JOIN dept_emp AS de
ON ri.emp_no = de.emp_no
WHERE dept_no IN ('d007','d005');

SELECT * FROM ri_dev_sales

SELECT ds.emp_no,
		ds.first_name,
		ds.last_name,
		d.dept_name
INTO clean_sales_dev_ri
FROM departments as d
LEFT join ri_dev_sales as ds
ON d.dept_no = ds.dept_no;

SELECT * FROM clean_sales_dev_ri
