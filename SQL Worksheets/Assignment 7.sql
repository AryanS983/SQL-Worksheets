CREATE table Customer(
    CID VARCHAR2(5) PRimary key,
    Cname VARCHAR2(10),
    Caddress VARCHAR2(20),
    DOB DATE                                                   
);

Select sysdate from dual;

-- Car (License#, YOP, model, Mfr, CID(foreign key)) Involved(Liscense#(foreign key),Report#(foreign key)) Accident(Report#, Damage_Amt,Acc_Date)

Create table Car(
    Liscense# VARCHAR2(10) PRIMARY key,
    YOP Number(4),
    Model VARCHAR2(10),
    Mfr VARCHAR2(10),
    CID VARCHAR2(5) references Customer(CID) on DELETE CASCADE
);

CREATE table Accident(
    Report# VARCHAR2(10) PRIMARY key,
    Damage_Amt Number(10,2),
    Acc_Date DATE
);

create TABLE involved(
    Liscense# VARCHAR2(10) references Car(Liscense#) on DELETE CASCADE,
    Report# VARCHAR2(10) references Accident(Report#) on DELETE CASCADE
);

-- Inserting dummy data into the Customer table
INSERT INTO Customer (CID, Cname, Caddress, DOB) VALUES ('C001', 'ABC', '123 Elm St', TO_DATE('1990-01-15', 'DD/MM/YY'));
INSERT INTO Customer (CID, Cname, Caddress, DOB) VALUES ('C002', 'Boob', '456 Oak St', TO_DATE('1985-05-20', 'DD/MM/YY'));
INSERT INTO Customer (CID, Cname, Caddress, DOB) VALUES ('C003', 'XYZ', '789 Pine St', TO_DATE('1992-08-30', 'DD/MM/YY'));

-- Inserting dummy data into the Car table
INSERT INTO Car (Liscense#, YOP, Model, Mfr, CID) VALUES ('AIBPC2005', 2020, 'Scorpio', 'Mahindra', 'C001');
INSERT INTO Car (Liscense#, YOP, Model, Mfr, CID) VALUES ('AIBPC2000', 2018, 'Civic', 'Honda', 'C002');
INSERT INTO Car (Liscense#, YOP, Model, Mfr, CID) VALUES ('AIBPC2010', 2021, 'Mustang', 'Ford', 'C003');

-- Inserting dummy data into the Accident table
INSERT INTO Accident (Report#, Damage_Amt, Acc_Date) VALUES ('FIR101', 1500.00, TO_DATE('2023-01-10', 'DD/MM/YY'));
INSERT INTO Accident (Report#, Damage_Amt, Acc_Date) VALUES ('FIR420', 2000.50, TO_DATE('2010-02-15', 'DD/MM/YY'));
INSERT INTO Accident (Report#, Damage_Amt, Acc_Date) VALUES ('FIR271', 500.75, TO_DATE('2023-03-20', 'DD/MM/YY'));

-- Inserting dummy data into the Involved table
INSERT INTO Involved (Liscense#, Report#) VALUES ('AIBPC2005', 'FIR101');
INSERT INTO Involved (Liscense#, Report#) VALUES ('AIBPC2000', 'FIR420');
INSERT INTO Involved (Liscense#, Report#) VALUES ('AIBPC2010', 'FIR271');
INSERT INTO Involved (Liscense#, Report#) VALUES ('AIBPC2005', 'FIR271');

Select count (customer.CID)
from CUSTOMER
join Car on CUSTOMER.CID = Car.CID
join INVOLVED on INVOLVED.LISCENSE# = Car.LISCENSE#
join ACCIDENT on ACCIDENT.REPORT# = INVOLVED.REPORT#
Where ACCIDENT.ACC_DATE like '%10';

select * from customer;

SELECT count (accident.REPORT#)
from car 
join involved on car.LISCENSE# = involved.LISCENSE#
join accident on involved.REPORT# = accident.REPORT#
where car.MFR like 'Honda';


Select count (ACCIDENT.REPORT#)
from CUSTOMER
join Car on CUSTOMER.CID = Car.CID
join INVOLVED on INVOLVED.LISCENSE# = Car.LISCENSE#
join ACCIDENT on ACCIDENT.REPORT# = INVOLVED.REPORT#
where CUSTOMER.CNAME = 'XYZ';

INSERT INTO Accident (Report#, Damage_Amt, Acc_Date) VALUES ('FIR111', 7500.00, '18/07/2024');
select * from Accident;
INSERT INTO Involved (Liscense#, Report#) VALUES ('AIBPC2010', 'FIR111');


--delete from CAR
-- where MODEL = 'Scorpio'
-- and CID = (select CID from CUSTOMER WHERE cname = 'ABC');

update ACCIDENT
SET DAMAGE_AMT = 5000
where 
REPORT# = (SELECT REPORT# from INVOLVED where liscense# = 'AIBPC2010' and REPORT# = 'FIR271' );

COMMIT;