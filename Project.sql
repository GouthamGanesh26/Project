CREATE TABLE department (
did varchar(20),
name varchar(20) NOT NULL,
CONSTRAINT PK_DEPT PRIMARY KEY(did));

INSERT INTO department VALUES 
('D1', 'Management'),
('D2', 'IT'),
('D3', 'Sales'),
('D4', 'HR')

CREATE TABLE employee (
eid int,
name varchar(20) UNIQUE,
join_date date NOT NULL,
department char(4)
CHECK (department IN ('D1', 'D2','D3')),
salary int,
manager int,
CONSTRAINT PK_ID PRIMARY KEY(eid),
CONSTRAINT FK_DID FOREIGN KEY(department)
REFERENCES department(did)
);



INSERT INTO employee VALUES
(101, 'David', '2009-07-14', 'D1', 50000, 101),
(102, 'Sam', '2010-06-24', 'D1', 40000, 101),
(103, 'Alicia', '2011-05-11', 'D2', 30000, 102),
(104, 'Alex', '2012-04-15', 'D2', 20000, 102),
(105, 'Robbi', '2013-08-14', 'D2', 20000, 102),
(106, 'Jack', '2014-09-19', 'D3', 8000, 101),
(107, 'Tom', '2015-11-12', 'D3', 5000, 116),
(108, 'Lily', '2016-07-28', 'D3', 1000, 106)

CREATE TABLE project (
person varchar(20),
proj_name varchar(20),
job_description varchar(100)
);

INSERT INTO project VALUES
('David', 'Ecommerce', 'generate and manage sales via online channels'),
('Sam', 'Inventory', 'manage location and pricing of inventory'),
('Alicia', 'Inventory', 'manage products that are in storage or transit'),
('Ryan', 'Ecommerce', 'advertising and marketting efforts of a company'),
('Ellen', 'Inventory', 'manage overall operations and help employees')

CREATE TABLE sale (
category varchar(20),
brand varchar(20),
name varchar(50) NOT NULL,
quantity int CHECK (quantity>=0),
price float NOT NULL,
stock boolean,
CONSTRAINT PK_CITY PRIMARY KEY(name)
);

INSERT INTO sale VALUES
('Phone', 'Apple', 'iPhone 13', 4, 1300.0, 'False'),
('Phone', 'Apple', 'iPhone 12', 6, 1100.0, 'True'),
('Phone', 'Samsung', 'Galaxy Note 20', 5, 1200.0, 'True'),
('Phone', 'Samsung', 'Galaxy S21', 4, 1100.0, 'False'),
('Laptop', 'Apple', 'Macbook Pro 13', 3, 2000.0, 'True'),
('Laptop', 'Apple', 'Macbook Air', 2, 1200.0, 'True'),
('Laptop', 'Dell', 'XPS 13', 1, 2000.0, 'False'),
('Laptop', 'Dell', 'XPS 15', 2, 2300.0, 'True'),
('Tablet', 'Apple', 'iPad 7th gen', 3, 560.0, 'False'),
('Tablet', 'Samsung', 'Galaxy Tab A7', 2, 220.0, 'True')

CREATE TABLE Advance (
bonus int);

INSERT INTO Advance VALUES
(500);

select * from Advance;

select * from employee;

update employee
set manager = 106
where name = 'Tom';

update employee
set department = 'D3', salary = 5000
where name = 'Lily';

create table Backup AS
select * from employee;

create table Replica AS
select * from employee
where 1=2;

delete from Backup
where name = 'Lily';

delete from Backup
where name IN('Alex', 'Robbi');

delete from Backup;
truncate TABLE Backup

drop TABLE Backup

alter TABLE sale
rename TO sales;

select * from sales;

alter TABLE employee
rename column department TO dept;

select * from employee;

alter table employee
alter column dept type varchar(2);

alter table employee
add column GENDER varchar(20);

alter table employee
add constraint GEN
CHECK (GENDER IN('M','F'));

alter table employee
drop constraint GEN;

alter table employee
drop column GENDER;

GRANT select ON Users TO 'TEST';
GRANT INSERT UPDATE ON Users TO 'TEST';
GRANT ALL ON Users TO 'TEST';

REVOKE select ON Users FROM 'TEST';
REVOKE INSERT UPDATE ON Users FROM 'TEST';
REVOKE ALL ON Users FROM 'TEST';

BEGIN;
DELETE FROM employee
where name = 'Lily';
COMMIT;

select * from employee;

ROLLBACK;

SAVEPOINT point;
ROLLBACK point;

select name, salary 
from employee
where salary > 10000
order by name
limit 3;

select * from sales;

select name, brand, price, stock
from sales
where price between 1000 and 1500
and stock in ('1')
order by name desc;

select name, brand, price, stock
from sales
where price between 1000 and 1500
and stock = false
order by name desc;

select name, brand, price, stock
from sales
where price between 1000 and 1500
and stock in ('0')
order by name desc;

select name, dept
from employee
where dept not in ('D2')
and (name like ('j%') or name not like ('%y'));

select *
from employee
where extract (month from join_date) = '04'

select TO_CHAR(CURRENT_DATE, 'Month dd, yyyy')
AS todays_date;

select DISTINCT brand
from sales;

select name, salary,
CASE when salary > 30000 then 'High'
when salary between 10000 and 30000 then 'Mid'
when salary < 10000 then 'Low'
end as Range
from employee
order by 2 desc;

select * from employee;
select * from project;

select name
from employee
where dept = 'D1'
UNION
select person 
from project;

select name
from employee
INTERSECT
select person
from project;

select person
from project
EXCEPT
select name
from employee;

select * from department;

select E.name, D.name as department
from employee E
INNER JOIN
department D
ON E.dept = D.did
where D.name = 'IT';

select * from project;

select E.name, P.proj_name
from project P
left join
employee E
on E.name = P.person;

select E.name, P.proj_name
from project P
right join
employee E
on E.name = P.person;

select E.name, P.proj_name
from project P
full join
employee E
on E.name = P.person;

select E.name, E.salary, A.bonus,
(E.salary + A.bonus) AS Net_Salary
from employee E
CROSS JOIN Advance A;

select * from employee;

select E.name, M.name as manager
from employee as M
join employee as E
on M.eid = E.manager;

select DISTINCT(LOWER(E.name)||'.'||LOWER(SUBSTRING(D.name, 0, 6))||'@tcs.in')
AS Email, E.name AS Emp_name,
D.name AS Department
from employee E
JOIN department D
ON D.did = E.dept;

select * from department;
select * from employee;

select D.name,
MIN(E.salary) AS Min,
MAX(E.salary) AS Max,
ROUND(AVG(E.salary),0) AS Avg,
SUM(E.salary) AS Total
from employee E
JOIN department D ON D.did = E.dept
group by D.name
having count(E.name)<3;

select D.name, count(1) AS emp,
MIN(E.salary) AS Min,
MAX(E.salary) AS Max,
ROUND(AVG(E.salary),0) AS Avg,
SUM(E.salary) AS Total
from employee E
JOIN department D ON D.did = E.dept
group by D.name
having count(1)<3;

select * from employee;
select * from department;
select * from project;

select UNNEST(string_to_array(job_description, ' '))
AS word, count(1) AS counter
from project
group by word
having count(1)>1
order by counter desc;

select name, salary
from employee
where salary >(
select AVG(salary)
from employee);

select * from department
where did not in (
select distinct(dept)
from employee
where dept is not null);

select * from department;

select name, salary, dept
from employee
where (dept, salary) in (
select dept, max(salary)
from employee
group by dept);

select * from employee;

select name, salary, dept
from employee E1
where salary > (
select AVG(salary)
from employee E2
where E2.dept = E1.dept);

select * from sales;

select *
from(
select brand, sum(price) as total_sales
from sales
group by brand) sales
join(
select avg(total_sales) AS SALES
from(
select brand, sum(price) as total_sales
from sales
group by brand) X
) AVG_SALES
on sales.total_sales > AVG_SALES.SALES;

with total_sales AS
(
select brand, sum(price) as total
from sales
group by brand),
avg_sales AS
(
select avg(total) as average
from total_sales)
select brand, total, average
from total_sales, avg_sales
where total_sales.total > avg_sales.average;

select * from employee;

select E.eid, E.name, E.dept,
ROW_NUMBER() OVER() AS ROLL,
ROW_NUMBER() OVER(PARTITION BY dept) AS RP
from employee E;

select * from employee;

select * from
(
select E.eid, E.name, E.dept,
ROW_NUMBER() OVER(PARTITION BY dept) AS RNO
from employee E) X
where X.RNO <2;

select E.eid, E.name, E.dept, E.salary,
RANK() OVER(ORDER BY salary desc) AS RNK,
DENSE_RANK() OVER(ORDER BY salary desc) AS DR
from employee E;

with comp AS(
select E.eid, E.name, E.dept, E.salary,
LAG(salary) OVER(order by eid) AS P_SL,
LEAD(salary) OVER(order by eid) AS N_SL
from employee E)
select *,
CASE WHEN salary > P_SL THEN 'HIGH'
     WHEN salary < P_SL THEN 'LOW'
	 WHEN salary = P_SL THEN 'SAME'
END P_CO,
CASE WHEN salary > N_SL THEN 'HIGH'
     WHEN salary < N_SL THEN 'LOW'
	 WHEN salary = N_SL THEN 'SAME'
END N_CO
from comp;

select * from sales;

select category, name, price,
first_value(name) over(partition by category order by price desc) AS EXPENSE,
last_value(name) over(partition by category order by price desc) AS CHEAP
from sales;

select category, brand, name, price,
first_value(name) over(partition by category)
from sales;

select category, brand, name, price,
first_value(name) over(partition by category
select category, brand, name, price
from(
select *,
last_value(name) over(partition by category order by price desc range between unbounded preceding
and unbounded following) AS cheap
from sales) X
where name = cheap;
					   
select * from sales;
					   
select category, brand, name, price
from(
select *,
nth_value(name,2) over(partition by category order by price desc range between unbounded preceding 
and unbounded following) AS cheap
from sales)X
where name = cheap;

select brand, name, price,
CASE WHEN X.BUCKETS = 1 THEN 'EXPENSIVE'
WHEN X.BUCKETS = 2 THEN 'MIDRANGE'
WHEN X.BUCKETS = 3 THEN 'CHEAP'
END PRICE_RANGE
from(					   
select *,
NTILE(3)
OVER(order by price desc) AS BUCKETS
from sales
where category = 'Phone') X;

select brand, category, name, (cd||'%') AS cd
from(		
select *, ROUND(
CUME_DIST() OVER(ORDER BY price desc)::numeric*100,2) AS cd
from sales) X
where cd <= 30;
					   
select brand, category, name, (cd||'%') AS cd
from(					   
select *, ROUND(
CUME_DIST() OVER(ORDER BY price desc)::numeric*100,2) AS cd
from sales)X
where cd <=30;	
					   
select category, brand, name, Perc
from(					   
select *,
ROUND(PERCENT_RANK() OVER(order by price)::NUMERIC*100,2) AS Perc					   
from sales) X	
where name = 'iPhone 13';				   





