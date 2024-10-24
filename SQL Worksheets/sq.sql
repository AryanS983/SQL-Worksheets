Create table CLIENT_MASTER(
    Client_No Varchar2(6) Check(Client_No  like 'C%') primary key,
    Name Varchar2(20) NOT NULL,
    City varchar2(15),pincode Number(8),
    State Varchar2(15),BalDue Number (10,2)
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


create Table SALES_ORDER_DETAILS ( 
    Order_No Varchar2 (6) references SALES_ORDER(Order_No) on delete cascade, 
    Product_No varchar2(6) references PRODUCT_MASTER(Product_No), 
    Qty_disp Number(8), 
    Product_rate Number(10,2)
);

Insert into CLIENT_MASTER values('C101', 'Aman', 'Kolkata', 700011, 'West bengal', 4000.20);
Insert into CLIENT_MASTER values('C102', 'Raman', 'Kolkata', 700087, 'West bengal', 6400.20);
Insert into CLIENT_MASTER values('C103', 'Ankita', 'Asansol', 700110, 'West bengal', 6400.20);
Insert into CLIENT_MASTER values('C104', 'Arya', 'Howrah', 700103, 'West bengal', 70000.20);
Insert into CLIENT_MASTER values('C105', 'Aryan', 'Kolkata', 700015, 'West bengal', 5000000.20);


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


Insert into CLIENT_MASTER values('C109', 'Avinash', 'Mumbai', 100015, 'Maharashtra', 50000.20);

Insert into CLIENT_MASTER values('C110', 'Ravi', 'Mumbai', 101015, 'Maharashtra', 50000.20);

Insert into SALESMAN_MASTER values('S107','Ravi','Kolkata', 700002, 'West bengal',3000);
Insert into SALESMAN_MASTER values('S121','Raj','Kolkata', 700011, 'West bengal',3500);

Insert into PRODUCT_MASTER values('P111', 'Trousers', 50 , 1500, 1000);

select Name from CLIENT_MASTER;
SELECT name from client_master where city = 'Mumbai';
select salesman_name from salesman_master where sal_amt=3000;
Select * from product_master order by cost_ desc;
select distinct description from product master;
Select sal_amt from salesman_master;
Update product_master set Cost_price=950.00 where description='Trousers';
Update salesman_master set city='Pune' where salesman_no='S101';
update client_master set city='Banglore', state='Karnataka' where client_no='C101';
Alter table CLIENT_MASTER add Telephone Number(10);
Alter table product_master modify (sell_price number(10,2)); 

Alter table Product_master drop column Cost_Price;

delete from salesman_master where sal_amt=3500;
Delete from product_master where qty_no_hand=100;
alter table Salesman_master rename to Sman_Mast;
Drop Table Client_Master;


delete from sales_order_details where product_no='P106';



