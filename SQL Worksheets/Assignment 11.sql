-- Song (song_id, title, composition_date)

-- Composer (composer_id, full_name)

-- Composed_By (song_id, composer_id)

-- Recording_Artist (artist_id, name)

-- CD (catalog_number, title, producer_name, artist_id)

-- Track (catalog_number, track_number, song_id, recording_date)

-- Release (catalog_number, release_date, number_of_sales)

CREATE TABLE Song (
    song_id INT PRIMARY KEY,
    title VARCHAR2(255),
    composition_date DATE
);

CREATE TABLE Composer (
    composer_id INT PRIMARY KEY,
    full_name VARCHAR2(255)
);

CREATE TABLE Composed_By (
    song_id INT,
    composer_id INT,
    PRIMARY KEY (song_id, composer_id),
    FOREIGN KEY (song_id) REFERENCES Song(song_id),
    FOREIGN KEY (composer_id) REFERENCES Composer(composer_id)
);

CREATE TABLE Recording_Artist (
    artist_id INT PRIMARY KEY,
    name VARCHAR2(255),
    no_of_Albums INT
);


CREATE TABLE CD (
    catalog_number INT PRIMARY KEY,
    title VARCHAR2(255),
    producer_name VARCHAR2(255),
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES Recording_Artist(artist_id)
);

CREATE TABLE Track (
    catalog_number INT,
    track_number INT,
    song_id INT,
    recording_date DATE,
    PRIMARY KEY (catalog_number, track_number),
    FOREIGN KEY (catalog_number) REFERENCES CD(catalog_number),
    FOREIGN KEY (song_id) REFERENCES Song(song_id)
);

CREATE TABLE Release (
    catalog_number INT,
    release_date DATE,
    number_of_sales INT,
    FOREIGN KEY (catalog_number) REFERENCES CD(catalog_number)
);

-- Insert data into Song table
INSERT INTO Song (song_id, title, composition_date) VALUES (1, 'Song A', TO_DATE('2020-01-01', 'YYYY-MM-DD'));
INSERT INTO Song (song_id, title, composition_date) VALUES (2, 'Song B', TO_DATE('2021-01-01', 'YYYY-MM-DD'));
INSERT INTO Song (song_id, title, composition_date) VALUES (3, 'Song C', TO_DATE('2019-01-01', 'YYYY-MM-DD'));
INSERT INTO Song (song_id, title, composition_date) VALUES (4, 'Song D', TO_DATE('2018-01-01', 'YYYY-MM-DD'));
INSERT INTO Song (song_id, title, composition_date) VALUES (5, 'Song E', TO_DATE('2017-01-01', 'YYYY-MM-DD'));

-- Insert data into Composer table
INSERT INTO Composer (composer_id, full_name) VALUES (1, 'John Doe');
INSERT INTO Composer (composer_id, full_name) VALUES (2, 'Jane Smith');
INSERT INTO Composer (composer_id, full_name) VALUES (3, 'Alex Brown');
INSERT INTO Composer (composer_id, full_name) VALUES (4, 'Chris Green');
INSERT INTO Composer (composer_id, full_name) VALUES (5, 'Morgan White');

-- Insert data into Composed_By table
INSERT INTO Composed_By (song_id, composer_id) VALUES (1, 1);
INSERT INTO Composed_By (song_id, composer_id) VALUES (2, 1);
INSERT INTO Composed_By (song_id, composer_id) VALUES (3, 2);
INSERT INTO Composed_By (song_id, composer_id) VALUES (4, 3);
INSERT INTO Composed_By (song_id, composer_id) VALUES (5, 3);
INSERT INTO Composed_By (song_id, composer_id) VALUES (1, 4);
INSERT INTO Composed_By (song_id, composer_id) VALUES (2, 5);

-- Insert data into Recording_Artist table
INSERT INTO Recording_Artist (artist_id, name,no_of_Albums) VALUES (1, 'The Rockers',3);
INSERT INTO Recording_Artist (artist_id, name,no_of_Albums) VALUES (2, 'Solo Star',1);
INSERT INTO Recording_Artist (artist_id, name,no_of_Albums) VALUES (3, 'Jazz Fusion',2);
INSERT INTO Recording_Artist (artist_id, name,no_of_Albums) VALUES (4, 'Folk Friends',1);
INSERT INTO Recording_Artist (artist_id, name,no_of_Albums) VALUES (5, 'Pop Beats',4);

-- Insert data into CD table (assigning artist_id such that some artists have recorded multiple CDs)
INSERT INTO CD (catalog_number, title, producer_name, artist_id) VALUES (101, 'Hits of The Rockers', 'Producer A', 1);
INSERT INTO CD (catalog_number, title, producer_name, artist_id) VALUES (102, 'Solo Star Debut', 'Producer B', 2);
INSERT INTO CD (catalog_number, title, producer_name, artist_id) VALUES (103, 'Jazz Collection', 'Producer C', 3);
INSERT INTO CD (catalog_number, title, producer_name, artist_id) VALUES (104, 'The Rockers Reloaded', 'Producer A', 1);
INSERT INTO CD (catalog_number, title, producer_name, artist_id) VALUES (105, 'Pop Beats Greatest', 'Producer D', 5);
INSERT INTO CD (catalog_number, title, producer_name, artist_id) VALUES (106, 'More Hits of The Rockers', 'Producer A', 1);

-- Insert data into Track table
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (101, 1, 1, TO_DATE('2021-01-10', 'YYYY-MM-DD'));
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (101, 2, 2, TO_DATE('2021-01-10', 'YYYY-MM-DD'));
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (102, 1, 3, TO_DATE('2022-02-15', 'YYYY-MM-DD'));
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (103, 1, 4, TO_DATE('2022-05-20', 'YYYY-MM-DD'));
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (104, 1, 1, TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (105, 1, 5, TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO Track (catalog_number, track_number, song_id, recording_date) VALUES (106, 1, 2, TO_DATE('2023-08-01', 'YYYY-MM-DD'));

-- Insert data into Release table
INSERT INTO Release (catalog_number, release_date, number_of_sales) VALUES (101, TO_DATE('2021-01-15', 'YYYY-MM-DD'), 5000);
INSERT INTO Release (catalog_number, release_date, number_of_sales) VALUES (102, TO_DATE('2022-02-20', 'YYYY-MM-DD'), 3000);
INSERT INTO Release (catalog_number, release_date, number_of_sales) VALUES (103, TO_DATE('2022-05-25', 'YYYY-MM-DD'), 4000);
INSERT INTO Release (catalog_number, release_date, number_of_sales) VALUES (104, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 4500);
INSERT INTO Release (catalog_number, release_date, number_of_sales) VALUES (105, TO_DATE('2023-06-10', 'YYYY-MM-DD'), 3500);
INSERT INTO Release (catalog_number, release_date, number_of_sales) VALUES (106, TO_DATE('2023-08-15', 'YYYY-MM-DD'), 6000);

select *  from song;
select * from composer;
select * from COMPOSED_BY;
SELECT * from RECORDING_ARTIST;
select * from TRACK;
Select * from CD;
Select * from RELEASE;



-- i>Update number of recorded album to 4 for those artist who has recorded only 3.
update RECORDING_ARTIST
set no_of_Albums = 4
where no_of_Albums = 3;

-- ii>Find all artists who have recorded at least two albums.
SELECT * FROM RECORDING_ARTIST 
WHERE no_of_Albums >= 2;

-- iii>Find all writers who have only written one song.
select full_name from COMPOSER
where composer_ID in 
(select composer_id
from Composed_By
group by composer_id
having count(SONG_ID) = 1);

commit;