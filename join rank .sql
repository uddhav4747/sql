---- self join 
-- find the employees and manager name 
--select * from employees e1 left  join employees e2  on e1.manager_id=e2.employee_id

select e1.first_name,e2.first_name from  employees e1 left  join employees e2  on e1.manager_id=e2.employee_id
select * from employees 

-- find the employees salary gretar than manager salary
select e1.first_name,e2.first_name ,e1.salary ,e2.salary from  employees e1 left  join employees e2  on e1.manager_id=e2.employee_id
where e1.salary<e2.salary

---find the mobile number of employee if employees mobile numbwe is null display manager mobile number 
select e1.first_name,e2.first_name ,  COALESCE(e1.phone_number, e2.phone_number) AS MobileNumber 
from  employees e1 left  join employees e2  on e1.manager_id=e2.employee_id
--COALESCE
--This function returns the employee's mobile number if it is not NULL; otherwise, it returns the manager's mobile number.



create table a (column1 int)
create table b (column1 int)
insert into b values (1),(1),(1),(1)

select * from a join b on a.column1=b.column1
select * from a left join b on a.column1=b.column1
select * from a right join b on a.column1=b.column1
select * from a full join b on a.column1=b.column1

--- in this table 1 1 record is compair with all records of table 2  and return matching output 
--table 1 1 is match with all records of table 2 and return it 4 times 


SELECT * from table1
SELECT * from table2

select * from table1 join table2 on table1.column1=table2.column1

select * from table1 right join table2 on table1.column1=table2.column1
select * from table1 left join table2 on table1.column1=table2.column1
select * from table1 full outer join table2 on table1.column1=table2.column1


SELECT * from table1
union
SELECT * from table2

SELECT * from table1
union all
SELECT * from table2


SELECT * from table1
intersect
SELECT * from table2

SELECT * from table1
except
SELECT * from table2

SELECT * from table2
except
SELECT * from table1

select *from table3
select *from table4

select *from table5

select * from table3  join table4 on table3.column1=table4.column1

select * from table3 left join table4 on table3.column1=table4.column1

select * from table3 right join table4 on table3.column1=table4.column1

select * from table3 full outer join table4 on table3.column1=table4.column1

select *from table3
union
select *from table4



select *from table3
union all
select *from table4

select *from table3
intersect
select *from table4

select *from table3
except
select *from table4

--- display the records in table1 but not in table 2 
select * from table2 left join table1 on table2.column1=table1.column1  where table1.column1 is null  -- is null is use not =null work  

-- from below table show only positive records negative records and zeros in differents columns 

select * from table5

select (case when column1>=1 then column1 else null end )as positive,
(case when column1=0 then column1 else null end)as zero ,
(case when column1<=-1 then column1 else null end) as negative from table5


-- sum of all positive numbers negative numbers and zeros 
select sum(case when column1>=1 then column1 else null end )as positive,
sum(case when column1=0 then column1 else null end)as zero ,
sum(case when column1<=-1 then column1 else null end) as negative from table5

---copy of table structure 
select * from INFORMATION_SCHEMA.TABLES
select * from gender
select * into gender1 from gender where 1=2
drop table gender1

--copy table structure along with data
select * into gender1 from gender 
select * from gender1

----------------------------------------------------------------------------------------------------------------
--windows function
-- find the 2nd max salalary from employees 
select * from employees where salary in  (select max (salary)from employees where  salary<
(select max (salary)from employees))

-- using dense rank
select * from (select *, DENSE_RANK()over(order by salary desc) as denc_sal  from employees )temp where denc_sal =2

----using CTE 
with cte as
(select *,DENSE_RANK()over(order by salary desc) as denc_sal from employees)
select * from cte where denc_sal=2
----------------------------------------------------------------------------------
--- find 3 5  and 7 max salary 

select first_name,salary from employees where salary in  (select max(salary) from employees where salary< (select max(salary) from employees 
where salary<(select max(salary) from employees)))

select * from(select first_name,salary , DENSE_RANK() over (order by salary desc) as max_sal from employees)temp
where max_sal in (3,5,7)

--using cte 
with cte as 
(select first_name,salary , DENSE_RANK() over (order by salary desc) as max_sal from employees)
select * from cte where max_sal in (3,5,7)


-----------------------------------------------------------------------------------------------------------------------
--depaerment wise min max salary
select department_name,max(salary) as max_sal from employees e join departments d on e.department_id =d.department_id 
 group by department_name

 select department_name,min(salary) as max_sal from employees e join departments d on e.department_id =d.department_id 
 group by department_name


create table gen (name varchar(20),salary int,gender varchar(10))
insert into gen values('yash',16000,'male'),('pratik',27000,'male'),('uddhav',18000,'male'),
('aditi',15000,'female'),('sadu',20000,'female')


select * from gen
----genderwise avg() salary
select gender,avg(salary) from gen group by gender

select gender,avg(salary) over  (partition by gender order by gender ) as_avg_sal from gen

-- partition by is not groping the outpout in single line  parition by show all rows in result 

--select max sal by gender 
select gender,max(salary) as max_sal from gen group by gender

select * from gen where salary in (select max(salary) as max_sal from gen group by gender)


--- display info of all employess with department wise max sal 
select * from employees where salary in (select max(salary) as max_sal from employees e join departments d on e.department_id =d.department_id 
 group by department_name)

---department wise product wise------------ wise is group by used 
select * from INFORMATION_SCHEMA.TABLES


--------------------------------------------------------------------------------------
--case used in mssql  and decode used in oracal 
--convert  the gender male like m and femail f from gen table 



SELECT 
    gender,
    CASE 
        WHEN gender = 'male' THEN 'M'
        WHEN gender = 'female' THEN 'F'
        ELSE 'Unknown' -- Optional: handle unexpected values
    END AS short_name
FROM gen;

--in oracal used decode 
/*SELECT 
    gender,
    DECODE(gender, 
           'male', 'M', 
           'female', 'F', 
           'Unknown') AS short_name
FROM 
    gen;*/

	-- nvl is oracal concept is equal to null in mssql
-- select is null (manager_id,100) from emplyees ------------------- mssql
---select manage_id,nvl(manager_id,100)from employees-------------oracal


--oracal---dual--it phase one row one column dummy table used to hold data
--select uddhav  from dual


-------------------------------------------------------------------------------------------------------------------
-- how to find the most recent records from the table 

/*SELECT *
FROM your_table
ORDER BY timestamp_column DESC
FETCH FIRST 1 ROWS ONLY;

SELECT TOP N *
FROM your_table
ORDER BY timestamp_column DESC;

Query optimization technique 
1 loogical query optimization 
2. cost base physical  query optimization 

1 use indexing 
2 used parallel exection on backend   select /*+parallel(4)*/*from employee ---oracal query
3 used inner join and subquery
4 analyse which join or function taking time and used another way

*/
-- display all info of employees with max salary department wise 
with cte as 
(select max(salary) as max_sal ,department_name from employees e join departments d on e.department_id=d.department_id group by 
department_name)
select * from cte where max(salary(select max(max_sal) from cte)