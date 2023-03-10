-- Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources--
create database employee;
Use employee;
show tables;
select * from emp_record_table;

alter table emp_record_table
rename column ï»¿EMP_ID to Emp_id;

-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department--
select EMP_ID, first_name,last_name,Gender,Dept from emp_record_table;

-- Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: less than two, greater than four, between two and four--
select EMP_ID, first_name,last_name,Gender,Dept, emp_rating from emp_record_table
where emp_rating < 2;

select EMP_ID, first_name,last_name,Gender,Dept, emp_rating from emp_record_table
where emp_rating >4;

select EMP_ID, first_name,last_name,Gender,Dept, emp_rating from emp_record_table
where emp_rating between 2 and 4;

-- Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department from the employee table and then give the resultant column alias as NAME--
select concat(first_name, " " , last_name) as Name, dept from emp_record_table
where dept = "Finance";

-- Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table--
select EMP_ID, first_name,last_name, Dept from emp_record_table
where dept = "healthcare"
union
select EMP_ID, first_name,last_name, Dept from emp_record_table
where dept = "finance"
order by dept, EMP_ID;

-- Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table--
select role, max(salary) as max_salary, min(salary) as min_salary from emp_record_table
group by role
order by role;

-- Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept--
-- Also include the respective employee rating along with the max emp rating for the department --
select emp_id, first_name,Last_name,role,dept, emp_rating,
max(emp_rating) over(partition by dept) as max_emp_rating
from emp_record_table;

-- Write a query to assign ranks to each employee based on their experience. Take data from the employee record table--
select emp_id, first_name,last_name, DEPT, exp, 
RANK() Over(order by exp) as emp_rank,
Dense_rank() over(order by exp) as dense_emp_rank
from emp_record_table;

-- Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table--
drop view emp_record_view;
create view emp_record_view as
select emp_id, first_name, last_name, country, salary
from emp_record_table
where salary > 6000;
select * from emp_record_view;

-- Write a nested query to find employees with experience of more than ten years. Take data from the employee record table--
select emp_id, first_name, last_name, exp
from emp_record_table
where emp_id in (select emp_id from emp_record_table where exp >10);

-- Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table--
delimiter //
Create procedure experienced_emp()
Begin
select * from emp_record_table 
where exp > 3;
End //
Delimiter ;
Call experienced_emp;

-- Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard--
delimiter &&
create function job_profile(Exp int)
returns varchar(150)
deterministic
begin
declare job_profile varchar(100);
if exp<=2 then 
set job_profile = "Junior data scientist";
elseif exp between 2 and 5 then
set job_profile ="Associate data scientist";
elseif exp between 5 and 10 then
set job_profile = "Senior data scientist";
elseif exp between 10 and 12 then
set job_profile = "Lead data scientist";
elseif exp between 12 and 16 then
set job_profile = "Manager";
End if;
return (job_profile);
End &&


select emp_id, first_name, last_name, role, dept, exp, job_profile(exp) as job_profile
from emp_record_table
order by exp;

-- Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating)--
select emp_id, first_name,last_name, role, dept, salary, emp_rating, ((5/100*salary)* emp_rating) as bonus
from emp_record_table
order by bonus desc; 

-- Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table--
select continent, country, avg(salary) as avg_salary
from emp_record_table
group by continent, country with rollup;








 



