-- Hotel (Hotel_No, Name, Address)

-- Room (Room_No, Hotel_No, Type, Price)

-- Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) 

-- Guest (Guest_No, Name, Address)

-- Create Hotel table
CREATE TABLE Hotel (
    Hotel_No INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255)
);

-- Create Room table
CREATE TABLE Room (
    Room_No INT,
    Hotel_No INT,
    Type VARCHAR(50),
    Price Number(10, 2),
    PRIMARY KEY (Room_No, Hotel_No),
    FOREIGN KEY (Hotel_No) REFERENCES Hotel(Hotel_No)
);

-- Create Booking table
CREATE TABLE Booking (
    Hotel_No INT,
    Guest_No INT,
    Date_From DATE,
    Date_To DATE,
    Room_No INT,
    PRIMARY KEY (Hotel_No, Guest_No, Date_From),
    FOREIGN KEY (Hotel_No, Room_No) REFERENCES Room(Hotel_No, Room_No),
    FOREIGN KEY (Guest_No) REFERENCES Guest(Guest_No)
);

-- Create Guest table
CREATE TABLE Guest (
    Guest_No INT PRIMARY KEY,
    Name VARCHAR(100),
    Address VARCHAR(255)
);

-- Insert sample data into Hotel table
INSERT INTO Hotel (Hotel_No, Name, Address) VALUES (1, 'Grosvenor Hotel', 'London');
INSERT INTO Hotel (Hotel_No, Name, Address) VALUES (2, 'Regent Hotel', 'Manchester');
INSERT INTO Hotel (Hotel_No, Name, Address) VALUES (3, 'Queen Hotel', 'Birmingham');
INSERT INTO Hotel (Hotel_No, Name, Address) VALUES (4, 'Royal Hotel', 'Edinburgh');
INSERT INTO Hotel (Hotel_No, Name, Address) VALUES (5, 'Grand Hotel', 'London');

-- Insert sample data into Room table
INSERT INTO Room (Room_No, Hotel_No, Type, Price) VALUES (101, 1, 'Single', 50.00);
INSERT INTO Room (Room_No, Hotel_No, Type, Price) VALUES (102, 1, 'Double', 35.00);
INSERT INTO Room (Room_No, Hotel_No, Type, Price) VALUES (103, 1, 'Family', 45.00);
INSERT INTO Room (Room_No, Hotel_No, Type, Price) VALUES (201, 2, 'Double', 30.00);
INSERT INTO Room (Room_No, Hotel_No, Type, Price) VALUES (202, 2, 'Family', 40.00);

-- Insert sample data into Guest table
INSERT INTO Guest (Guest_No, Name, Address) VALUES (1, 'Alice', 'London');
INSERT INTO Guest (Guest_No, Name, Address) VALUES (2, 'Bob', 'Manchester');
INSERT INTO Guest (Guest_No, Name, Address) VALUES (3, 'Charlie', 'London');
INSERT INTO Guest (Guest_No, Name, Address) VALUES (4, 'Diana', 'Birmingham');
INSERT INTO Guest (Guest_No, Name, Address) VALUES (5, 'Eve', 'London');

-- Insert sample data into Booking table
INSERT INTO Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) VALUES (1, 1, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-05', 'YYYY-MM-DD'), 101);
INSERT INTO Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) VALUES (1, 3, TO_DATE('2023-08-10', 'YYYY-MM-DD'), NULL, 102);
INSERT INTO Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) VALUES (2, 2, TO_DATE('2023-08-01', 'YYYY-MM-DD'), TO_DATE('2023-08-03', 'YYYY-MM-DD'), 201);
INSERT INTO Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) VALUES (2, 4, TO_DATE('2023-08-05', 'YYYY-MM-DD'), TO_DATE('2023-08-08', 'YYYY-MM-DD'), 202);
INSERT INTO Booking (Hotel_No, Guest_No, Date_From, Date_To, Room_No) VALUES (1, 5, TO_DATE('2023-08-10', 'YYYY-MM-DD'), TO_DATE('2023-08-12', 'YYYY-MM-DD'), 103);


-- List the names and addresses of all guests in London, alphabetically ordered by name
SELECT Name, Address 
FROM Guest 
WHERE Address = 'London' 
ORDER BY Name ASC;

-- List all double or family rooms with a price below £40.00 per night, in ascending order of price.
select *  from ROOM
where price < 40.00 and (TYPE = 'Double' or type = 'Family')
order by price asc;

-- List the bookings for which no date_to has been specified.
SELECT * FROM Booking WHERE Date_To IS NULL;

-- How many hotels are there?
SELECT COUNT(*) FROM Hotel;

-- What is the average price of a room?
select avg(price) from room;

-- What is the total revenue per night from all double rooms?
select sum(price) from room where type = 'Double';

-- How many different guests have made bookings for August?
select count (Guest_No) from BOOKING
where date_from like '%08___';

-- List the details of all rooms at the Grosvenor Hotel, including the name of the guest staying in the room, if the room is occupied.
select r.Room_No, r.type, r.price, g.Name
from room r join BOOKING b on r.ROOM_NO = b.ROOM_NO
join GUEST g on b.GUEST_NO = g.GUEST_NO
where b.DATE_TO is NULL;

-- What is the total income from bookings for the Grosvenor Hotel today?
SELECT SUM(R.Price) AS Total_Income
FROM Room R
JOIN Booking B ON R.Hotel_No = B.Hotel_No AND R.Room_No = B.Room_No
WHERE R.Hotel_No = (SELECT Hotel_No FROM Hotel WHERE Name = 'Grosvenor Hotel')
  AND CURRENT_DATE BETWEEN B.Date_From AND NVL(B.Date_To, CURRENT_DATE);



-- List the rooms that are currently unoccupied at the Grosvenor Hotel.
 select room_no from BOOKING
 where DATE_TO is not NULL and Date_to < (select sysdate from dual);

 commit;

