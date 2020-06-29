# Pewlett-Hackard-Analysis

## Summary of the Results:

### Queries Created and Why
1. 41,380 employees will be retiring and will need to have their roles filled at Pewlett Hackard.

- In order to find the number of retirement-ready employees, the primary key, "emp_no" (employee number) was used to track details about each employee among the different csv datasets. The first step was to create a table, "retirement_info", to include each employee by first and last name. This table was filtered using the *WHERE* function to determine their age and therefore their eligibility for retirement in the next few years. (Found under ri_by_dept.sql)

*SELECT emp_no, first_name, last_name*

*INTO retirement_info*

*FROM employees*

*WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')*

*AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');*

- Another *WHERE* function was used to select the employees that are still currently working at Pewlett Hackard since the records saved display anyone that has ever worked there at any point in time. 

*WHERE de.to_date = ('9999-01-01');*

- A few more columns were added to datasets to show additional qualities of each employee retiring: their job title, the dates they held a specific job title for, their salary, gender, etc. (Found under info_emp.sql). The final table groups the employees by number, full name, title, salary, and from date (ri_by_titles.csv). Additionally a second table was created to present the total count of retiring employees by title name using the *SELECT COUNT* and *GROUP BY* functions (ri_by_titles2.csv). The follwing code was used to get rid of employee duplicate names, those that have stayed with the company long-term and have changed job titles. (Found under Challenge.sql)

-- partition the data to show most recent titles per employee

*SELECT emp_no,first_name, last_name,title,from_date*

*INTO clean_ri_titles*

*FROM (SELECT emp_no,first_name, last_name, title, from_date,*

*ROW_NUMBER () OVER*

*(PARTITION BY (emp_no)*
 
*ORDER BY to_date DESC) rn*
 
*FROM titles_ri*
 
*) tmp WHERE rn = 1*
 
*ORDER BY emp_no;*

- The final table for the first part of the analysis (current_emp_52_55.csv) displays a list of current employees born between 1952 and 1955. 

2. 1,940 retirement-ready employees born in the year 1965 are eligible for the mentorship program. 

- Two *INNER JOINs* using the emp_no key was used to merge information on the employees, titles and dept_emp datasets. The *WHERE* function to pick between birth years and the same layout of the partition code shown above was also used to find this information. 
 
3. Findings and Conclusions

- I recommend the next step in this analysis to be that the most recently hired employees, from the last 2-3 years, be identified and then paired with the retirement-ready employees that are qualified and willing to participate in the mentorship program. 

## Employee Database Mapping 

- This ERD was used to keep track of all the joins needed to create tables

![alt text](https://github.com/elenaguilarv/Pewlett-Hackard-Analysis/blob/master/EmployeeDB.png)
