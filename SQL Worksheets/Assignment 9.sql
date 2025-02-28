CREATE TABLE emp (
personname VARCHAR(50),
street VARCHAR(50),
city VARCHAR(50)
);
CREATE TABLE worksin (
personname VARCHAR(50),
compname VARCHAR(50),
salary INT
);
CREATE TABLE comp (
compname VARCHAR(50),
city VARCHAR(50)
);
CREATE TABLE manages (
personname VARCHAR(50),
managername VARCHAR(50)
);

alter table worksin
rename column companyname to compname;


INSERT INTO emp (personname, street, city) VALUES('Alice', 'Maple St', 'Delhi');
INSERT INTO emp (personname, street, city) VALUES('Bob', 'Oak St', 'Mumbai');
INSERT INTO emp (personname, street, city) VALUES('Charlie', 'Pine St', 'Bangalore');
INSERT INTO emp (personname, street, city) VALUES('Dave', 'Maple St', 'Delhi');
INSERT INTO emp (personname, street, city) VALUES('Eva', 'Birch St', 'Kolkata');




INSERT INTO comp (compname, city) VALUES('Axis Bank', 'Mumbai');
INSERT INTO comp (compname, city) VALUES('Infosys', 'Bangalore');
INSERT INTO comp (compname, city) VALUES('TCS', 'Kolkata');
INSERT INTO comp (compname, city) VALUES('Wipro', 'Hyderabad');
INSERT INTO comp (compname, city) VALUES('Axis Bank', 'Delhi');
INSERT INTO comp (compname, city) VALUES('Infosys', 'Delhi');


INSERT INTO worksin (personname, compname, salary) VALUES('Alice', 'Axis Bank', 32000);
INSERT INTO worksin (personname, compname, salary) VALUES('Bob', 'Axis Bank', 28000);
INSERT INTO worksin (personname, compname, salary) VALUES('Charlie', 'Infosys', 45000);
INSERT INTO worksin (personname, compname, salary) VALUES('Dave', 'Axis Bank', 35000);
INSERT INTO worksin (personname, compname, salary) VALUES('Eva', 'TCS', 38000);



INSERT INTO manages (personname, managername) VALUES('Alice', 'Bob');
INSERT INTO manages (personname, managername) VALUES('Bob', 'Charlie');
INSERT INTO manages (personname, managername) VALUES('Charlie', 'Dave');
INSERT INTO manages (personname, managername) VALUES('Dave', 'Eva');
INSERT INTO manages (personname, managername) VALUES('Eva', 'Alice');
INSERT INTO manages (personname, managername) VALUES('Dave', 'Alice');


select * from comp;
select * from emp;
select * from worksin;
select * from manages;


-- a)  Find the names of all employees who work for Axis Bank.
SELECT personname 
FROM worksin 
WHERE compname = 'Axis Bank';

-- b)  Find the names and cities of residence of all employees who work for Axis Bank.
SELECT emp.personname, emp.city 
FROM emp JOIN worksin ON emp.personname = worksin.personname
WHERE worksin.compname = 'Axis Bank';

-- c)  Find the names, street addresses, and cities of residence of all employees who work for Axis Bank and earn more than Rs.30000 per annum.
SELECT emp.personname, emp.street, emp.city 
FROM emp JOIN worksin ON emp.personname = worksin.personname 
WHERE worksin.compname = 'Axis Bank' AND worksin.salary >30000;

-- d)  Find all employees who live in the same city as the company for which they work is located.
SELECT emp.personname, emp.street, emp.city, comp.compname
FROM emp JOIN worksin ON emp.personname = worksin.personname
JOIN comp ON worksin.compname = comp.compname
WHERE emp.city = comp.city;

-- e)  Find all employees who live in the same city and on the same street as their managers.
SELECT emp.personname, emp.street, emp.city, manages.managername
FROM emp JOIN manages ON emp.personname = manages.personname
JOIN emp man ON manages.managername = man.personname
where emp.CITY = man.CITY and emp.STREET = man.STREET;

-- f)  Find all employees in the database who do not work for Axis Bank.
SELECT personname
FROM worksin
WHERE compname <> 'Axis Bank';

-- g)  Find all employees who earn more than every employee of Axis Bank.
select personname
from WORKSIN
WHERE salary > (SELECT max(salary) FROM worksin WHERE compname = 'Axis Bank');

-- h)  Assume that the companies may be located in several cities. Find all companies located in every city iin which Axis Bank is located.
SELECT compname
FROM comp
WHERE compname <> 'Axis Bank' and city IN (SELECT city FROM comp WHERE compname = 'Axis Bank');

-- i)  Find all employees who earn more than the average salary of all employees of their company.
SELECT w.personname, w.compname, w.salary
FROM worksin w
JOIN (
    SELECT compname, AVG(salary) AS avg_salary
    FROM worksin
    GROUP BY compname
) avg_salaries ON w.compname = avg_salaries.compname
WHERE w.salary >= avg_salaries.avg_salary;

select * from worksin;
select compname, avg(SALARY)
from WORKSIN
GROUP BY compname;

SELECT *
FROM worksin w
JOIN (
    SELECT compname, AVG(salary) AS avg_salary
    FROM worksin
    GROUP BY compname
) avg_salaries ON w.compname = avg_salaries.compname;

-- j)  Find the company that has the most employees.
select compname,count(personname)
from worksin
group by compname
order by count(personname) DESC
fetch first 1 rows only;

-- k)  Find the company that has the smallest payroll.
SELECT compname,sum(SALARY)
FROM worksin
GROUP BY compname
ORDER BY SUM(salary) ASC
fetch first 1 row only;

-- l) Find those companies whose employees earn a higher salary, on average, than the average salary at Axis Bank.
select compname
from WORKSIN
where compname <> 'Axis Bank'
GROUP BY compname
HAVING avg(salary) > (SELECT AVG(salary) FROM worksin WHERE compname ='Axis Bank');


-- m)     Modify the database so that ABC now lives in Kolkata.
UPDATE emp
SET city = 'Kolkata'
WHERE personname = 'ABC';

-- n)  Give all employees of Axis Bank a 10 percent raise.
Update worksin
set salary = salary * 1.1
where COMPNAME = 'Axis Bank';
 

-- o)   Give all managers in the database a 10 percent raise.
update worksin
set salary = salary * 1.1
where personname IN (select managername from manages);
 

-- P) Give all managers in the database a 10 percent raise, unless the salary would be greater than Rs.300000.In such cases, give only a 3 percent raise.
UPDATE worksin
SET salary = salary * 
    CASE 
        WHEN salary * 1.10 <= 300000 THEN 1.10  -- 10% raise if new salary <= 300000
        ELSE 1.03                               -- 3% raise if new salary would exceed 300000
    END
WHERE personname IN (SELECT DISTINCT managername FROM manages);

select * from worksin;


-- q) Delete all tuples in the works relation for employees of Axis Bank.
delete from worksin
where compname = 'Axis Bank';

commit;

-- find the second highest salary of employe
select max(salary) from WORKSIN
where salary < (select max(salary) from WORKSIN where compname = 'Axis Bank')
and compname = 'Axis Bank';
