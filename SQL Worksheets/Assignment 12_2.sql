
-- EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo)

-- DEPARTMENT (DNo, DName, MgrSSN, MgrStartCHAR)

-- DLOCATION (DNo,DLoc)

-- PROJECT (PNo, PName, PLocation, DNo)

-- WORKS_ON (SSN, PNo, Hours)

-- Create EMPLOY table
CREATE TABLE EMPLOY (
    SSN INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    uperSSN INT,
    DNo INT
);

-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    DNo INT PRIMARY KEY,
    DName VARCHAR(100),
    MgrSSN INT,
    MgrStartDate DATE
);

desc employ;

-- Create DLOCATION table
CREATE TABLE DLOCATION (
    DNo INT,
    DLoc VARCHAR(100),
    PRIMARY KEY (DNo, DLoc),
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

-- Create PROJECT table
CREATE TABLE PROJECT (
    PNo INT PRIMARY KEY,
    PName VARCHAR(100),
    PLocation VARCHAR(100),
    DNo INT,
    FOREIGN KEY (DNo) REFERENCES DEPARTMENT(DNo)
);

-- Create WORKS_ON table
CREATE TABLE WORKS_ON (
    SSN INT,
    PNo INT,
    Hours DECIMAL(4, 2),
    PRIMARY KEY (SSN, PNo),
    FOREIGN KEY (SSN) REFERENCES EMPLOY(SSN),
    FOREIGN KEY (PNo) REFERENCES PROJECT(PNo)
);



-- Insert sample data into DEPARTMENT table
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) VALUES (1, 'Accounts', 12345, '01-01-2022');
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) VALUES (2, 'Engineering', 23456, '01-06-2021');
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) VALUES (3, 'Marketing', 34567, '15-02-2023');
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) VALUES (4, 'Sales', 45678, '10-03-2023');
INSERT INTO DEPARTMENT (DNo, DName, MgrSSN, MgrStartDate) VALUES (5, 'R_and_D', 56789, '11-11-2020');


-- Insert sample data into EMPLOY table
INSERT INTO EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo) VALUES (12345, 'John Scott', '123 Main St', 'M', 700000, NULL, 1);
INSERT INTO EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo) VALUES (23456, 'Alice Brown', '456 Oak St', 'F', 750000, 12345, 2);
INSERT INTO EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo) VALUES (34567, 'Robert Scott', '789 Pine St', 'M', 550000, 12345, 3);
INSERT INTO EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo) VALUES (45678, 'Eve Johnson', '135 Maple St', 'F', 620000, 12345, 4);
INSERT INTO EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo) VALUES (56789, 'Mike Green', '246 Elm St', 'M', 580000, 12345, 5);
INSERT INTO EMPLOY (SSN, Name, Address, Sex, Salary, uperSSN, DNo) VALUES (67890, 'Mary White', '345 Cedar St', 'F', 720000, 12345, 1);

select * from employ;

-- Insert sample data into DLOCATION table
INSERT INTO DLOCATION (DNo, DLoc) VALUES (1, 'Mumbai');
INSERT INTO DLOCATION (DNo, DLoc) VALUES (2, 'Delhi');
INSERT INTO DLOCATION (DNo, DLoc) VALUES (3, 'Bangalore');
INSERT INTO DLOCATION (DNo, DLoc) VALUES (4, 'Chennai');
INSERT INTO DLOCATION (DNo, DLoc) VALUES (5, 'Pune');

-- Insert sample data into PROJECT table
INSERT INTO PROJECT (PNo, PName, PLocation, DNo) VALUES (101, 'IoT', 'Mumbai', 1);
INSERT INTO PROJECT (PNo, PName, PLocation, DNo) VALUES (102, 'AI Development', 'Delhi', 2);
INSERT INTO PROJECT (PNo, PName, PLocation, DNo) VALUES (103, 'Marketing Analysis', 'Bangalore', 3);
INSERT INTO PROJECT (PNo, PName, PLocation, DNo) VALUES (104, 'Sales Expansion', 'Chennai', 4);
INSERT INTO PROJECT (PNo, PName, PLocation, DNo) VALUES (105, 'New Product R_and_D', 'Pune', 5);

-- Insert sample data into WORKS_ON table
INSERT INTO WORKS_ON (SSN, PNo, Hours) VALUES (12345, 101, 10);
INSERT INTO WORKS_ON (SSN, PNo, Hours) VALUES (23456, 102, 15);
INSERT INTO WORKS_ON (SSN, PNo, Hours) VALUES (34567, 103, 12);
INSERT INTO WORKS_ON (SSN, PNo, Hours) VALUES (45678, 104, 20);
INSERT INTO WORKS_ON (SSN, PNo, Hours) VALUES (56789, 105, 25);





--  1. Make a list of all project numbers for projects that involve an employ whose last name is ‘Scott’, either as a worker or as a manager of the department that controls the project.
select w.PNo from WORKS_ON w
join EMPLOY e on e.SSN = w.SSN
where e.NAME like '%Scott'
UNION
select w.PNo from WORKS_ON w
join DEPARTMENT d on w.SSN = d.MGRSSN
join EMPLOY e on e.SSN = d.MGRSSN
where e.NAME like '%Scott';


--  2. Show the resulting salaries if every employ working on the ‘IoT’ project is given a 10 percent raise.
update employ
set salary =salary*1.1
where SSN in (select SSN from WORKS_ON where PNo = (select PNo from project where PName ='IoT'));

select * from employ;


--  3. Find the sum of the salaries of all employs of the ‘Accounts’ department, as well as the maximum salary, the minimum salary, and the average salary in this department
select sum(salary), max(salary), min(salary), avg(salary) from employ
where DNO = (select DNO from DEPARTMENT where dname = 'Accounts');

--  4. Retrieve the name of each employ who works on all the projects controlled by department number 5 .
select e.name from employ e
join WORKS_ON w on e.SSN = w.SSN
join PROJECT p on w.PNo = p.PNo
where p.DNO = 5;

--  5. For each department that has more than one employs, retrieve the department number and the number of its employs who are making more than Rs. 6,00,000.
select DNO, count(SSN) from employ
where SALARY > 600000
group by DNO
having count(SSN) > 1;


commit;

