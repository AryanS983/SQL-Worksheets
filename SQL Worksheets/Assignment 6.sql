Create table CLIENT_MASTER(
    Client_No Varchar2(6) Check(Client_No  like 'C%') primary key,
    Name Varchar2(20) NOT NULL,
    City varchar2(15),
    pincode Number(8),
    State Varchar2(15),
    BalDue Number (10,2)
);

Create table PRODUCT_MASTER(
    Product_No Varchar2(6) Check(Product_no Like 'P%') Primary Key,
    Description Varchar2(15) Not Null, 
    Qty_NO_Hand Number(8) Not NUll, 
    Sell_Price Number(8,2) Check (Sell_Price <> 0),
    Cost_Price Number(8,2) Check (Cost_Price <> 0)
);

Create table SALESMAN_MASTER(
    Salesman_No Varchar2(6) Primary Key Check(Salesman_No like 'S%'), 
    Salesman_Name Varchar2(20) NOT NULL,  
    City Varchar2(20) NOT NULL,
    pincode Number(8) Not Null,
    State Varchar2(20) Not Null,
    Sal_Amt Number(8,2) Check(Sal_Amt <> 0) Not Null
);  

Drop table SALESMAN_MASTER;

Create Table SALES_ORDER(
    Order_No Varchar2(6) Primary Key Check(Order_No like 'O%'), 
    Client_No Varchar2(6) references CLIENT_MASTER(Client_No) on delete Cascade, 
    Order_Date Date , 
    Salesman_No varchar2(6) references SALESMAN_MASTER(Salesman_No) on delete cascade, 
    Dely_type Char(1) default 'F' Check(Dely_type = 'F' OR Dely_type = 'P'),
    Dely_date Date
);

SELECT TO_CHAR(sysdate,'DY,DD-Month-YYYY') from dual;
select to_char(sysdate,'day') from dual;



create Table SALES_ORDER_DETAILS (
    Order_No Varchar2 (6) references SALES_ORDER(Order_No) on delete cascade, 
    Product_No varchar2(6) references PRODUCT_MASTER(Product_No) on delete cascade,
    Qty_disp Number(8),
    Product_rate Number(10,2)
);

Insert into CLIENT_MASTER values('C101', 'Aman', 'Kolkata', 700011, 'West bengal', 4000.20);
Insert into CLIENT_MASTER values('C102', 'Raman', 'Kolkata', 700087, 'West bengal', 6400.20);
Insert into CLIENT_MASTER values('C103', 'Ankita', 'Asansol', 700110, 'West bengal', 6400.20);
Insert into CLIENT_MASTER values('C104', 'Arya', 'Howrah', 700103, 'West bengal', 70000.20);
Insert into CLIENT_MASTER values('C105', 'Aryan', 'Kolkata', 700015, 'West bengal', 5000000.20);
Insert into CLIENT_MASTER values('C109', 'Avinash', 'Mumbai', 100015, 'Maharashtra', 50000.20);
Insert into CLIENT_MASTER values('C110', 'Ravi', 'Mumbai', 101015, 'Maharashtra', 50000.20);


Insert into PRODUCT_MASTER values('P105', 'Moistureizer', 10 , 170, 70);
Insert into PRODUCT_MASTER values('P106', 'Soap', 100 , 170, 70);
Insert into PRODUCT_MASTER values('P109', 'perfume', 30 , 770, 170);
Insert into PRODUCT_MASTER values('P120', 'Biscuits', 1000 , 30, 10);
Insert into PRODUCT_MASTER values('P185', 'Sugar', 50 , 70, 30);


Insert into SALESMAN_MASTER values('S101','Rohit','Kolkata', 700011, 'West bengal',30000);
Insert into SALESMAN_MASTER values('S102','Esha','Pune', 120011, 'Maharashtra',40000);
Insert into SALESMAN_MASTER values('S103','Ayush','Kolkata', 700015, 'West bengal',70000);
Insert into SALESMAN_MASTER values('S104','Sameer','Indore', 452013, 'Madhya Pradesh',20000);
Insert into SALESMAN_MASTER values('S105','Shivam','Kolkata', 700002, 'West bengal',25000);
Insert into SALESMAN_MASTER values('S107','Ravi','Kolkata', 700002, 'West bengal',3000);
Insert into SALESMAN_MASTER values('S121','Raj','Kolkata', 700011, 'West bengal',3500);

Insert into SALES_ORDER values('O101','C101','15-02-23', 'S101','F' , '17-02-23');
Insert into SALES_ORDER values('O102','C102','14-03-22', 'S102','F' , '17-03-22');
Insert into SALES_ORDER values('O103','C103','15-08-23', 'S104','F' , '03-09-24');
Insert into SALES_ORDER values('O104','C104','01-02-23', 'S103','P' , '17-02-24');
Insert into SALES_ORDER values('O105','C105','17-02-23', 'S105','F' , '19-02-23');


Alter table SALES_ORDER_DETAILS rename column Oty_disp to Qty_disp;


Insert into SALES_ORDER_DETAILS values('O101', 'P105', 20, 7.7 );
Insert into SALES_ORDER_DETAILS values('O102', 'P106', 120, 2.7 );
Insert into SALES_ORDER_DETAILS values('O103', 'P109', 20, 5.6 );
Insert into SALES_ORDER_DETAILS values('O104', 'P120', 20, 8.9 );
Insert into SALES_ORDER_DETAILS values('O105', 'P185', 20, 10.0 );



-- List the names of all clients having ‘a’ as the third letter in their names.
select Name from CLIENT_MASTER
where Name like '__a%';

-- List the clients who stay in a city whose first letter is ‘K’.
SELECT Name from CLIENT_MASTER
where CITY like 'K%';

-- List all the clients who stay in ‘Mumbai’ or ‘Kolkata’.
SELECT Name from CLIENT_MASTER
where CITY='Kolkata' or CITY='Mumbai';

-- List all the clients whose BalDue is greater than value 1000.
SELECT Name from CLIENT_MASTER
where BALDUE > 1000;

-- List all information from the Sales_Order table for orders placed in the month of February.
Select * from Sales_Order
where Order_Date like '___02%';

-- List the order information for Client_no ‘C101’ and ‘C103’.
SELECT * from SALES_ORDER
WHERE CLIENT_NO = 'C101' or CLIENT_NO='C103';

-- List products whose selling price is greater than 500 and less than or equal to 750
SELECT * from PRODUCT_MASTER
where SELL_PRICE>500 and SELL_PRICE<=750;

-- Count the total number of order.
SELECT COUNT(*) from SALES_ORDER;

--Determine the maximum and minimum product prices. Rename the output as max_price and min_price respectively.
SELECT MAX(SELL_PRICE) as max_price, MIN(SELL_PRICE) as min_price from PRODUCT_MASTER;

--List the order number and day on which clients placed their order.
SELECT Order_No, to_char(Dely_date,'DY') as Dely_day from SALES_ORDER;

-- List the Order_Date in the format ‘DD-Month-YY’.
select TO_Char(Order_Date ,'DD-Month-YY') from SALES_ORDER;

--List the date, 20 days after today’s date.
SELECT SYSDATE + 20 FROM DUAL;

--List name of the client who has maximum BalDue.
SELECT Name from CLIENT_MASTER
WHERE BALDUE = (select MAX(BalDue) from Client_Master);

Commit;

--Find the difference between maximum BalDue and minimum BalDue.
SELECT MAX(BalDue) - MIN(BalDue) from CLIENT_MASTER;

--Add Rs.1000/- with the salary amount of every salesmen.
update SALESMAN_MASTER
SET SAL_AMT = SAL_AMT+1000
where Salesman_Name='Esha';

select * from SALESMAN_MASTER;
commit;

-- SELECT
-- update
-- Insert
-- delete

-- Create
-- Alter
-- Drop


-- Assignmnet 6.2

-- employee: emp_no, name, dob, sex, address, salary 
-- company: comp_no, name, address

-- works: emp_no, comp_no

CREATE table employee(
    emp_no NUMBER(5) PRIMARY KEY,
    name VARCHAR2(20),
    dob DATE,
    sex VARCHAR2(10),
    address VARCHAR2(50),
    salary NUMBER(10,2)
);

Create table company(
    comp_no NUMBER(5) PRIMARY KEY,
    name VARCHAR2(20),
    address VARCHAR2(50)
);

create table works(
    emp_no NUMBER(5) references employee(emp_no) on delete CASCADE,
    comp_no NUMBER(5) references company(comp_no) on delete cascade
);

INSERT INTO employee (emp_no, name, dob, sex, address, salary)
VALUES (10001, 'John Doe', TO_DATE('1985-05-12', 'YYYY-MM-DD'), 'Male', '123 Elm St, NY', 55000.00);

INSERT INTO employee (emp_no, name, dob, sex, address, salary)
VALUES (10002, 'Jane Smith', TO_DATE('1990-11-23', 'YYYY-MM-DD'), 'Female', '456 Oak St, CA', 60000.00);

INSERT INTO employee (emp_no, name, dob, sex, address, salary)
VALUES (10003, 'Emily Davis', TO_DATE('1988-02-18', 'YYYY-MM-DD'), 'Female', '789 Pine St, TX', 58000.00);

INSERT INTO employee (emp_no, name, dob, sex, address, salary)
VALUES (10004, 'Michael Johnson', TO_DATE('1979-08-29', 'YYYY-MM-DD'), 'Male', '101 Maple St, FL', 65000.00);

INSERT INTO employee (emp_no, name, dob, sex, address, salary)
VALUES (10005, 'David Wilson', TO_DATE('1983-12-09', 'YYYY-MM-DD'), 'Male', '202 Birch St, IL', 62000.00);


INSERT INTO company (comp_no, name, address)
VALUES (2001, 'Tech Solutions', '123 Tech Ave, NY');

INSERT INTO company (comp_no, name, address)
VALUES (2002, 'Innovative Designs', '456 Design Blvd, CA');

INSERT INTO company (comp_no, name, address)
VALUES (2003, 'HealthCorp', '789 Health St, TX');

INSERT INTO company (comp_no, name, address)
VALUES (2004, 'Finance Pro', '101 Finance Rd, FL');

INSERT INTO company (comp_no, name, address)
VALUES (2005, 'Green Energy', '202 Greenway, IL');

INSERT INTO works (emp_no, comp_no)
VALUES (10001, 2001);

INSERT INTO works (emp_no, comp_no)
VALUES (10002, 2002);

INSERT INTO works (emp_no, comp_no)
VALUES (10003, 2003);

INSERT INTO works (emp_no, comp_no)
VALUES (10004, 2004);

INSERT INTO works (emp_no, comp_no)
VALUES (10005, 2005);

select * from  COMPANY;

--List the employees who work for company ‘2002’
SELECT employee.name
from EMPLOYEE
join WORKS on EMPLOYEE.EMP_NO = WORKS.EMP_NO
where WORKS.COMP_NO = 2002;

-- List the employees who work for Finance Pro
SELECT employee.name
from EMPLOYEE
join WORKS on EMPLOYEE.EMP_NO = WORKS.EMP_NO
join COMPANY on WORKS.COMP_NO  = COMPANY.COMP_NO
where COMPANY.NAME = 'Finance Pro';

-- List the employees born between 1985 and 2001
SELECT name from EMPLOYEE
where to_char(DOB,'YYYY') BETWEEN 1985 and 2001;

COMMIT;