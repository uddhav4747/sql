select * from sys.databases
use hr

select * from INFORMATION_SCHEMA.TABLES

create table country( id int,country varchar(20))
insert into country  values (1,'india') 
insert into country  values (2,'us') 
insert into country  values (4,'chaina') 

--ddl -create truncate,drop ,alter,rename
--dml-select insert ,delete,insert,update
--dcl--grant revoke
--tcl--commoit ,rollback

-----------------------------------------------------
sp_help country  --structure of table 
select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME='country'

---------------------------------------------------------------------------
--count column name 
select count(*)as count from employees

select * from employees 
--find null value of specific column 
select count(*)- count(phone_number) as phone_count from employees

--count funcion does not count null values 
--null value validation of both column 
select count(*)- count(phone_number) as null_phone_count ,
count(*)- count(manager_id) as null_manager
from employees

--null value validation done on where not null constarin define 

--find the records where phone number is null
select * from employees where phone_number is null

-- find the first name and department name 
select first_name,department_name from employees e join departments d on e.department_id =d.department_id

---- find the first name and department name  and city 
select first_name,department_name,city from employees e join departments d on e.department_id =d.department_id join locations
l on d.location_id=l.location_id

--split based on charactor 
select email, substring(email,1,6) from employees 
-- it will find the specific pattern in columns data it taking 3 arguments column name start positioin end position

select email, CHARINDEX('@',email,1) from employees   
-- it gives the specific position of given arguments 
--it taking 3 arguments specific pattern which position required  column name and steps 


--- from email column differnt the employees name and its origanization email id in two diffent column 
select email,
SUBSTRING(email,1,charindex('@',email,1)-1) as emp_name ,
SUBSTRING(email,charindex('@',email,1)+1,len(email)) as domain_name
from employees 


--- find the experience of employees 
select * from employees
select DATEDIFF(yyyy,hire_date,getdate()) from employees 

select DATEDIFF(MM,hire_date,getdate()) from employees 

-- employees name with joining year
select first_name ,YEAR(hire_date)as join_year from employees

--employees who join in 1991
select first_name ,YEAR(hire_date)as join_year from employees where year(hire_date)=1991

--employees who join in may

select first_name ,month(hire_date)as join_month from employees where month(hire_date)=5

-- count of employees in yearwise and month wise 
--yearwise 
select count(*), YEAR(hire_date) as year_wise_count from employees group by year(hire_date)

--monthwise 
select count(*), month(hire_date) as month_wise_count from employees group by month(hire_date)

--find month wise count of hire employees in 1997
select count(*), month (hire_date) from employees where year(hire_date)=1997 group by month (hire_date)


-- employees joinon date before / date after / and date between 
--before 
select * from employees where hire_date<='1991/05/21'

--after 
select * from employees where hire_date>='1991/05/21'

--between
select count(*) as hire_between from employees where hire_date between '1991/05/21' and '1995/05/21'



