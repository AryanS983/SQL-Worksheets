-- MATCH (match_id, team1, team2, ground, mdate, winner) 
-- PLAYER (p_id, lname, fname, country, yborn, bplace, ftest)

-- BATTING (match_id, p_id, mts, order, out_type, fow, nruns, nballs, fours, sixes) 
-- BOWLING (match_id, p_id, novers, maidens, nruns, nwickets)

CREATE TABLE MATCH (
    match_id Number PRIMARY KEY,
    team1 VARCHAR2(50),
    team2 VARCHAR2(50),
    ground VARCHAR2(50),
    mdate DATE,
    winner VARCHAR2(50)
);

CREATE TABLE PLAYER (
    p_id Number PRIMARY KEY,
    lname VARCHAR2(50),
    fname VARCHAR2(50),
    country VARCHAR2(50),
    yborn Number,
    bplace VARCHAR2(50),
    ftest Number
);

CREATE TABLE BATTING (
    match_id Number REFERENCES MATCH(match_id) on delete cascade,
    p_id Number REFERENCES PLAYER(p_id) on delete cascade,
    mts Number,
    border Number,
    out_type VARCHAR2(50),
    fow Number,
    nruns Number,
    nballs Number,
    fours Number,
    sixes Number
);

CREATE TABLE BOWLING (
    match_id Number REFERENCES MATCH(match_id) on delete cascade,
    p_id Number  REFERENCES PLAYER(p_id) on delete cascade,
    novers Number,
    maidens Number,
    nruns Number,
    nwickets Number
);

drop table BATTING;
drop table BOWLING;
drop table Match;
drop table PLAYER;

select sysdate from dual;

-- Inserting INTO MATCH table
INSERT INTO MATCH VALUES (1, 'India', 'Australia', 'Sydney', '15-01-2023', 'Australia');
INSERT INTO MATCH VALUES (2, 'India', 'Sri Lanka', 'Colombo', '05-02-2023', 'India');
INSERT INTO MATCH VALUES (3, 'India', 'England', 'Sydney', '20-02-2023', 'England');
INSERT INTO MATCH VALUES (4, 'Australia', 'Sri Lanka', 'Melbourne', '10-03-2023', 'Australia');
INSERT INTO MATCH VALUES (5, 'India', 'Australia', 'Sri Lanka', '01-04-2023', 'India');

-- Inserting INTO PLAYER table
INSERT INTO PLAYER VALUES (27001, 'Kohli', 'Virat', 'India', 1988, 'Delhi', 1);
INSERT INTO PLAYER VALUES (27002, 'Smith', 'Steve', 'Australia', 1989, 'Sydney', 1);
INSERT INTO PLAYER VALUES (27003, 'Mendis', 'Kusal', 'Sri Lanka', 1995, 'Colombo', 1);
INSERT INTO PLAYER VALUES (27004, 'Root', 'Joe', 'England', 1991, 'Sheffield', 1);
INSERT INTO PLAYER VALUES (27005, 'Warner', 'David', 'Australia', 1986, 'Sydney', 1);

-- Inserting INTO BATTING table
INSERT INTO BATTING VALUES (1, 27001, 1, 1, 'caught', 50, 100, 120, 10, 2);
INSERT INTO BATTING VALUES (2, 27001, 1, 1, 'not out', 0, 130, 30, 4, 1);
INSERT INTO BATTING VALUES (3, 27001, 1, 1, 'bowled', 20, 10, 10, 1, 0);
INSERT INTO BATTING VALUES (4, 27002, 1, 1, 'not out', 0, 75, 45, 8, 1);
INSERT INTO BATTING VALUES (5, 27003, 1, 1, 'bowled', 10, 15, 25, 2, 0);


-- Inserting INTO BOWLING table
INSERT INTO BOWLING VALUES (1, 27001, 10, 2, 45, 1);
INSERT INTO BOWLING VALUES (2, 27002, 8, 1, 35, 2);
INSERT INTO BOWLING VALUES (3, 27003, 6, 0, 40, 1);
INSERT INTO BOWLING VALUES (4, 27004, 12, 3, 20, 4);
INSERT INTO BOWLING VALUES (5, 27005, 4, 0, 30, 0);

select * from Match;
select * from PLAYER;
select * from BATTING; 
select * from BOWLING;

-- i)  Find match ids of those matches in which player 27001 bats and makes more runs than he made at every match he played at Sydney.
select match_id from BATTING where p_id = 27001 and nruns > 
(select max(b.nruns) from batting b join match m on b.MATCH_ID=m.MATCH_ID
where m.ground='Sydney' and b.p_id=27001);

-- ii)  Find player ids of players who have scored more than 30 in every ODI match that they have batted.
select p_id from BATTING
GROUP by P_ID
HAVING min(nruns) > 30;


-- iii)  Find the ids of players that had a higher average score than the average score for all players when they played in Sri Lanka.
select p_id from BATTING
group by P_ID
having avg(nruns) > 
(select avg(b.nruns) from BATTING b join MATCH m
on b.match_id = m.match_id
where m.ground='Sri Lanka');

commit;
