 SELECT employee_id, hire_date
 FROM "HR".employees;
 
 SELECT current_date 
 
SELECT employee_id, hire_date, 
round((current_date-hire_date)/365) AS age_in_company
 FROM "HR".employees;


SELECT employee_id, hire_date, 
round((current_date-hire_date)/365) AS age_in_company,
EXTRACT ('year' FROM current_date)-EXTRACT ('year' FROM hire_date) AS age_year
 FROM "HR".employees;
  
SELECT current_timestamp;
  
SELECT employee_id, date_trunc('MONTH',hire_date)
 FROM "HR".employees;

SELECT employee_id, 
date_trunc('month', hire_date)::date,
EXTRACT ('month' FROM hire_date),
date_part ('month', hire_date)
FROM "HR".employees;

SELECT employee_id, 
date_trunc('year', hire_date)::date,
EXTRACT ('year' FROM hire_date),
date_part ('year', hire_date)::varchar
FROM "HR".employees;

SELECT age (current_date,hire_date),
date_part ('month', age (current_date,hire_date))+
date_part ('year', age (current_date,hire_date))*12 AS month
FROM "HR".employees;

SELECT age (timestamp '2025-01-16 12:23:33', timestamp '2020-07-12 06:23:33' )

SELECT current_date- INTERVAL '5 months'

SELECT age ('2026-01-01',current_date) -- до нового года))))) 


SELECT  max (salary)
FROM "HR".employees;

WITH max_salary AS (SELECT  max (salary)
FROM "HR".employees)
SELECT employee_id, salary,max 
FROM "HR".employees
CROSS JOIN max_salary;

SELECT employee_id, salary
FROM "HR".employees
CROSS JOIN max_salary;


SELECT department_id,
max (salary) AS max_dep_salary
FROM "HR".employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id;

SELECT * FROM "HR".employees

SELECT employee_id, last_name, hire_date, department_id, salary,
max (salary) OVER () AS  max_salary_in_company,
--max (salary) OVER (PARTITION BY department_id) AS max_salary_by_dep,
round  (avg (salary)  OVER (PARTITION BY department_id))AS avg_salary_by_dep
FROM "HR".employees
ORDER BY department_id,salary DESC;

SELECT employee_id, last_name, hire_date, department_id, salary,
--max (salary) OVER () AS  max_salary_in_company,
max (salary) OVER (PARTITION BY department_id) AS max_salary_by_dep,
first_value(salary) OVER (ORDER BY hire_date DESC )
FROM "HR".employees
ORDER BY hire_date,salary DESC;

SELECT employee_id, hire_date, department_id, salary,
--max (salary) OVER () AS  max_salary_in_company,
--max (salary) OVER (PARTITION BY department_id) AS max_salary_by_dep,
first_value(salary) OVER (ORDER BY hire_date) AS first_salary_emp,
first_value(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS first_salary_dep
FROM "HR".employees
ORDER BY department_id, hire_date;

SELECT employee_id, hire_date, department_id, salary,
--max (salary) OVER () AS  max_salary_in_company,
--max (salary) OVER (PARTITION BY department_id) AS max_salary_by_dep,
--first_value(salary) OVER (ORDER BY hire_date) AS first_salary_emp,
first_value(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS first_salary_dep,
first_value(salary) OVER (PARTITION BY department_id ORDER BY hire_date desc) AS first_salary_dep,
last_value(salary) OVER (PARTITION BY department_id ORDER BY hire_date RANGE BETWEEN UNBOUNDED preceding AND UNBOUNDED following) AS last
FROM "HR".employees
ORDER BY department_id, hire_date ;


SELECT employee_id, hire_date, department_id, salary,
max (salary) OVER () AS  max_salary_in_company,
row_number() OVER (ORDER BY salary desc) AS salary_raw,
rank() OVER (ORDER BY salary desc) AS salary_rank,
dense_rank() OVER (ORDER BY salary desc) AS salary_denserank
FROM "HR".employees
ORDER BY salary_rank;

SELECT employee_id, hire_date, department_id, salary,
LAG (salary,1) OVER (PARTITION BY department_id ORDER BY hire_date) AS prev_selary,
Lead (salary,1) OVER (PARTITION BY department_id ORDER BY hire_date) AS prev_selary
FROM "HR".employees
ORDER BY department_id, hire_date;