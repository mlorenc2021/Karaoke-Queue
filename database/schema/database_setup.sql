-- Drop tables if they exist
DROP TABLE IF EXISTS Wrote;
DROP TABLE IF EXISTS Contribution;
DROP TABLE IF EXISTS RegularRequest;
DROP TABLE IF EXISTS PriorityRequest;
DROP TABLE IF EXISTS KaraokeSong;
DROP TABLE IF EXISTS Contributor;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS Song;
DROP TABLE IF EXISTS RegularQueue;
DROP TABLE IF EXISTS PriorityQueue;

-- Create tables
CREATE TABLE PriorityQueue (
    pqid          INT NOT NULL AUTO_INCREMENT,
    amount_paid   REAL NOT NULL,
    time          VARCHAR(25) NOT NULL,
    PRIMARY KEY (pqid)
);

CREATE TABLE RegularQueue (
    rqid          INT NOT NULL AUTO_INCREMENT,
    time          VARCHAR(25) NOT NULL,
    PRIMARY KEY (rqid)
);

CREATE TABLE Song (
    songid        VARCHAR(5) NOT NULL,
    song_title    VARCHAR(50) NOT NULL,
    year          INT NOT NULL,
    PRIMARY KEY (songid)
);

CREATE TABLE Artist (
    artistid      VARCHAR(5) NOT NULL,
    artist_name   VARCHAR(50) NOT NULL,
    PRIMARY KEY (artistid)
);

CREATE TABLE Contributor (
    contributorid     VARCHAR(5) NOT NULL,
    contributor_name  VARCHAR(50) NOT NULL,
    PRIMARY KEY (contributorid)
);

CREATE TABLE KaraokeSong (
    kfid           VARCHAR(5) NOT NULL,
    file_version   VARCHAR(10) NOT NULL,
    songid         VARCHAR(5) NOT NULL,
    PRIMARY KEY (kfid),
    FOREIGN KEY (songid) REFERENCES Song (songid)
);

CREATE TABLE PriorityRequest (
    pqid          INT NOT NULL,
    user_name     VARCHAR(25) NOT NULL,
    kfid          VARCHAR(5) NOT NULL,
    PRIMARY KEY (pqid, kfid),
    FOREIGN KEY (kfid) REFERENCES KaraokeSong (kfid),
    FOREIGN KEY (pqid) REFERENCES PriorityQueue (pqid)
);

CREATE TABLE RegularRequest (
    rqid          INT NOT NULL,
    user_name     VARCHAR(25) NOT NULL,
    kfid          VARCHAR(5) NOT NULL,
    PRIMARY KEY (rqid, kfid),
    FOREIGN KEY (kfid) REFERENCES KaraokeSong (kfid),
    FOREIGN KEY (rqid) REFERENCES RegularQueue (rqid)
);

CREATE TABLE Contribution (
    contributorid     VARCHAR(5) NOT NULL,
    contributor_type  VARCHAR(25) NOT NULL,
    songid            VARCHAR(5) NOT NULL,
    PRIMARY KEY (contributorid, songid),
    FOREIGN KEY (contributorid) REFERENCES Contributor (contributorid),
    FOREIGN KEY (songid) REFERENCES Song (songid)
);

CREATE TABLE Wrote (
    songid            VARCHAR(5) NOT NULL,
    artistid          VARCHAR(5) NOT NULL,
    PRIMARY KEY (songid, artistid),
    FOREIGN KEY (songid) REFERENCES Song (songid),
    FOREIGN KEY (artistid) REFERENCES Artist (artistid)
);


-- Inserting into PriorityQueue table
INSERT INTO PriorityQueue (amount_paid, time) VALUES 
(10.00, '4:45 pm'),
(15.00, '5:00 pm'),
(20.00, '5:15 pm'),
(25.00, '5:30 pm'),
(30.00, '5:45 pm');


-- Inserting into RegularQueue table
INSERT INTO RegularQueue (time) VALUES
('6:00 pm'),
('6:15 pm'),
('6:30 pm'),
('6:45 pm'),
('7:00 pm'),
('7:15 pm'),
('7:30 pm'),
('7:45 pm'),
('8:00 pm'),
('8:15 pm');


-- Inserting into Song table
INSERT INTO Song (songid, song_title, year) VALUES 
('s1', 'Achy Breaky Heart', 1992),
('s2', 'Take Me Home, Country Roads', 1971),
('s3', 'Jolene', 1974),
('s4', 'Ring of Fire', 1963),
('s5', 'Always on My Mind', 1992),
('s6', 'Juicy', 1994),
('s7', 'Fuck Tha Police', 1988),
('s8', 'My Name Is', 1999),
('s9', 'In Da Club', 2003),
('s10', 'Ms. Jackson', 2000),
('s11', 'Happy', 2013),
('s12', 'We Found Love', 2011),
('s13', 'Thriller', 1984),
('s14', 'Despacito', 2017),
('s15', 'Just the Way You Are', 2010),
('s16', 'Fly Me to the Moon', 1963),
('s17', 'Aint That a Kick in the Head?', 1960),
('s18', 'The Candy Man', 1972),
('s19', 'What a Wonderful World', 1967),
('s20', 'My Way', 1969),
('s21', 'Bohemian Rhapsody', 1975),
('s22', 'Wannabe', 1996),
('s23', 'Dont Stop Believin', 1981),
('s24', 'Africa', 1982),
('s25', 'Livin on a Prayer', 1986),
('s26', '(Ive Had) The Time of My Life', 1987),
('s27', 'Under Pressure', 1981),
('s28', 'Dont Go Breaking My Heart ', 1976),
('s29', 'Empire State of Mind', 2009),
('s30', 'Aint No Mountain High Enough', 1967);


-- Inserting into Artist table
INSERT INTO ARtist (artistid, artist_name) VALUES
('a1', 'Billy Ray Cyrus'),
('a2', 'John Denver'),
('a3', 'Dolly Parton'),
('a4', 'Johnny Cash'),
('a5', 'Willie Nelson'),
('a6', 'The Notorious B.I.G'),
('a7', 'N.W.A.'),
('a8', 'Eminem'),
('a9', '50 Cent'),
('a10', 'Outkast'),
('a11', 'Pharrell Williams'),
('a12', 'Rihanna'),
('a13', 'Michael Jackson'),
('a14', 'Luis Fonsi'),
('a15', 'Bruno Mars'),
('a16', 'Frank Sinatra'),
('a17', 'Dean Martin'),
('a18', 'Sammy Davis Jr'),
('a19', 'Louis Armstrong'),
('a20', 'Queen'),
('a21', 'Spice Girls'),
('a22', 'Journey'),
('a23', 'Toto'),
('a24', 'Bon Jovi'),
('a25', 'Bill Medly and Jennifer Warnes'),
('a26', 'Queen and David Bowie'),
('a27', 'Elton John and Kiki Dee'),
('a28', 'Jay-Z and Alicia Keys'),
('a29', 'Marvin Gaye and Tammi Terrell');


-- Inserting into Contributor table
INSERT INTO Contributor (contributorid, contributor_name) VALUES
('c1', 'Don Von Tress'), 
('c2', 'Joe Scaife'), 
('c3', 'Jim Cotton'), 
('c4', 'Bill Danoff'), 
('c5', 'Taffy Nivert'), 
('c6', 'John Denver'), 
('c7', 'Milton Okun'), 
('c8', 'Susan Ruskin'), 
('c9', 'Dolly Parton'), 
('c10', 'Bob Ferguson'), 
('c11', 'June Carter'), 
('c12', 'Merle Kilgore'), 
('c13', 'Don Law'), 
('c14', 'Wayne Carson'), 
('c15', 'Mark James'), 
('c16', 'Johnny Christopher'), 
('c17', 'Felton Jarvis'), 
('c18', 'Christopher Wallace'), 
('c19', 'James Mtume'), 
('c20', 'Poke'), 
('c21', 'Sean "Puffy" Combs'), 
('c22', 'Ice Cube'), 
('c23', 'MC Ren'), 
('c24', 'The D.O.C.'), 
('c25', 'Dr. Dre'), 
('c26', 'DJ Yella'), 
('c27', 'Marshall Mathers'), 
('c28', 'Andre Young'), 
('c29', 'Labi Siffre'), 
('c30', 'Dr. Dre'), 
('c31', 'Curtis Jackson'), 
('c32', 'Andre Young'), 
('c33', 'Mike Elizondo'), 
('c34', 'Dr. Dre'), 
('c35', 'DJ Quik'), 
('c36', 'Mike Elizondo'), 
('c37', 'Andre Benjamin'), 
('c38', 'Antwan Patton'), 
('c39', 'David Sheats'), 
('c40', 'Richard Wagner'), 
('c41', 'Stan Watts'), 
('c42', 'Shuggie Otis'), 
('c43', 'Earthone III'), 
('c44', 'Pharrell Williams'), 
('c45', 'Pharrell Williams'), 
('c46', 'Calvin Harris'), 
('c47', 'Calvin Harris'), 
('c48', 'Rod Temperton'), 
('c49', 'Quincy Jones'), 
('c50', 'Luis Rodriguez'), 
('c51', 'Erika Ender'), 
('c52', 'Ramon Ayala'), 
('c53', 'Mauricio Rengifo'), 
('c54', 'Andres Torres'), 
('c55', 'Bruno Mars'), 
('c56', 'Philip Lawrence'), 
('c57', 'Ari Levine'), 
('c58', 'Khalil Walton'), 
('c59', 'Khari Cain'), 
('c60', 'The Smeezingtons'), 
('c61', 'Needlz'), 
('c62', 'Bart Howard'), 
('c63', 'Lee Gillette'), 
('c64', 'Sammy Cahn'), 
('c65', 'Rod Temperton'), 
('c66', 'Quincy Jones'), 
('c67', 'Bob Thiele'), 
('c68', 'George David Weiss'), 
('c69', 'Bob Thiele'), 
('c70', 'Claude Francois'), 
('c71', 'Jacques Revau'), 
('c72', 'Paul Anka'), 
('c73', 'Sonny Burke'), 
('c74', 'Freddie Mercury'), 
('c75', 'Roy Thomas Baker'), 
('c76', 'Queen'), 
('c77', 'Spice Girls'), 
('c78', 'Matt Rowe'), 
('c79', 'Richard Stannard'), 
('c80', 'Matt Rowe'), 
('c81', 'Richard Stannard'), 
('c82', 'Steve Perry'), 
('c83', 'Jonathan Cain'), 
('c84', 'Neal Schon'), 
('c85', 'Kevin Elson'), 
('c86', 'Mike Clay Stone'), 
('c87', 'David Paich'), 
('c88', 'Jeff Porcaro'), 
('c89', 'Toto'), 
('c90', 'Jon Bon Jovi'), 
('c91', 'Richie Sambora'), 
('c92', 'Desmond Child'), 
('c93', 'Bruce Fairbairn'), 
('c94', 'John DeNicola'), 
('c95', 'Donald Markowitz'), 
('c96', 'Franke Previte'), 
('c97', 'Michael Lloyd'), 
('c98', 'Roger Taylor'), 
('c99', 'Freddie Mercury'), 
('c100', 'David Bowie'), 
('c101', 'John Deacon'), 
('c102', 'Brian May'), 
('c103', 'Queen'), 
('c104', 'David Bowie'), 
('c105', 'Ann Orson'), 
('c106', 'Elton John'), 
('c107', 'Carte Blanche'), 
('c108', 'Bernie Taupin'), 
('c109', 'Gus Dudgeon'), 
('c110', 'Angela Hunte'), 
('c111', 'Alicia Keys'), 
('c112', 'Alexander Shuckburgh'), 
('c113', 'Bert Keyes'), 
('c114', 'Janet Sewell-Ulepic'), 
('c115', 'Shawn Carter'), 
('c116', 'Sylvia Robinson'), 
('c117', 'Al Shux'), 
('c118', 'Nickolas Ashford'), 
('c119', 'Valerie Simpson'), 
('c120', 'Harvey Fuqua'), 
('c121', 'Johnny Bristol');


-- Inserting into Contribution table
INSERT INTO Contribution (contributorid, contributor_type, songid) VALUES
('c1', 'Songwriter', 's1'), 
('c2', 'Producer', 's1'), 
('c3', 'Producer', 's1'), 
('c4', 'Songwriter', 's2'), 
('c5', 'Songwriter', 's2'), 
('c6', 'Songwriter', 's2'), 
('c7', 'Producer', 's2'), 
('c8', 'Producer', 's2'), 
('c9', 'Songwriter', 's3'), 
('c10', 'Producer', 's3'), 
('c11', 'Songwriter', 's4'), 
('c12', 'Songwriter', 's4'), 
('c13', 'Producer', 's4'), 
('c14', 'Songwriter', 's5'), 
('c15', 'Songwriter', 's5'), 
('c16', 'Songwriter', 's5'), 
('c17', 'Producer', 's5'), 
('c18', 'Lyricist', 's6'), 
('c19', 'Lyricist', 's6'), 
('c20', 'Producer', 's6'), 
('c21', 'Producer', 's6'), 
('c22', 'Songwriter', 's7'), 
('c23', 'Songwriter', 's7'), 
('c24', 'Songwriter', 's7'), 
('c25', 'Producer', 's7'), 
('c26', 'Producer', 's7'), 
('c27', 'Songwriter', 's8'), 
('c28', 'Songwriter', 's8'), 
('c29', 'Songwriter', 's8'), 
('c30', 'Producer', 's8'), 
('c31', 'Songwriter', 's9'), 
('c32', 'Songwriter', 's9'), 
('c33', 'Songwriter', 's9'), 
('c34', 'Producer', 's9'), 
('c35', 'Producer', 's9'), 
('c36', 'Producer', 's9'), 
('c37', 'Songwriter', 's10'), 
('c38', 'Songwriter', 's10'), 
('c39', 'Songwriter', 's10'), 
('c40', 'Songwriter', 's10'), 
('c41', 'Songwriter', 's10'), 
('c42', 'Songwriter', 's10'), 
('c43', 'Producer', 's10'), 
('c44', 'Songwriter', 's11'), 
('c45', 'Producer', 's11'), 
('c46', 'Songwriter', 's12'), 
('c47', 'Producer', 's12'), 
('c48', 'Songwriter', 's13'), 
('c49', 'Producer', 's13'), 
('c50', 'Songwriter', 's14'), 
('c51', 'Songwriter', 's14'), 
('c52', 'Songwriter', 's14'), 
('c53', 'Producer', 's14'), 
('c54', 'Producer', 's15'), 
('c55', 'Songwriter', 's15'), 
('c56', 'Songwriter', 's15'), 
('c57', 'Songwriter', 's15'), 
('c58', 'Songwriter', 's15'), 
('c59', 'Songwriter', 's15'), 
('c60', 'Producer', 's15'), 
('c61', 'Producer', 's15'), 
('c62', 'Songwriter', 's16'), 
('c63', 'Producer', 's17'), 
('c64', 'Lyricist', 's17'), 
('c65', 'Songwriter', 's18'), 
('c66', 'Producer', 's18'), 
('c67', 'Songwriter', 's19'), 
('c68', 'Songwriter', 's19'), 
('c69', 'Producer', 's19'), 
('c70', 'Songwriter', 's20'), 
('c71', 'Songwriter', 's20'), 
('c72', 'Songwriter', 's20'), 
('c73', 'Producer', 's20'), 
('c74', 'Songwriter', 's21'), 
('c75', 'Producer', 's21'), 
('c76', 'Producer', 's21'), 
('c77', 'Songwriter', 's22'), 
('c78', 'Songwriter', 's22'), 
('c79', 'Songwriter', 's22'), 
('c80', 'Producer', 's22'), 
('c81', 'Producer', 's22'), 
('c82', 'Songwriter', 's23'), 
('c83', 'Songwriter', 's23'), 
('c84', 'Songwriter', 's23'), 
('c85', 'Producer', 's23'), 
('c86', 'Producer', 's23'), 
('c87', 'Songwriter', 's24'), 
('c88', 'Songwriter', 's24'), 
('c89', 'Producer', 's24'), 
('c90', 'Songwriter', 's25'), 
('c91', 'Songwriter', 's25'), 
('c92', 'Songwriter', 's25'), 
('c93', 'Producer', 's25'), 
('c94', 'Songwriter', 's26'), 
('c95', 'Songwriter', 's26'), 
('c96', 'Songwriter', 's26'), 
('c97', 'Producer', 's26'), 
('c98', 'Songwriter', 's27'), 
('c99', 'Songwriter', 's27'), 
('c100', 'Songwriter', 's27'), 
('c101', 'Songwriter', 's27'), 
('c102', 'Songwriter', 's27'), 
('c103', 'Producer', 's27'), 
('c104', 'Producer', 's27'), 
('c105', 'Songwriter', 's28'), 
('c106', 'Songwriter', 's28'), 
('c107', 'Songwriter', 's28'), 
('c108', 'Songwriter', 's28'), 
('c109', 'Producer', 's28'), 
('c110', 'Songwriter', 's29'), 
('c111', 'Songwriter', 's29'), 
('c112', 'Songwriter', 's29'), 
('c113', 'Songwriter', 's29'), 
('c114', 'Songwriter', 's29'), 
('c115', 'Songwriter', 's29'), 
('c116', 'Songwriter', 's29'), 
('c117', 'Producer', 's29'), 
('c118', 'Songwriter', 's30'), 
('c119', 'Songwriter', 's30'), 
('c120', 'Producer', 's30'), 
('c121', 'Producer', 's30');


-- Inserting into KaraokeSong table
INSERT INTO KaraokeSong(kfid, file_version, songid) VALUES
('k1', 'solo', 's1'),
('k2', 'solo', 's2'),
('k3', 'solo', 's3'),
('k4', 'solo', 's4'),
('k5', 'solo', 's5'),
('k6', 'solo', 's6'),
('k7', 'solo', 's7'),
('k8', 'solo', 's8'),
('k9', 'solo', 's9'),
('k10', 'solo', 's10'),
('k11', 'solo', 's11'),
('k12', 'solo', 's12'),
('k13', 'solo', 's13'),
('k14', 'solo', 's14'),
('k15', 'solo', 's15'),
('k16', 'solo', 's16'),
('k17', 'solo', 's17'),
('k18', 'solo', 's18'),
('k19', 'solo', 's19'),
('k20', 'solo', 's20'),
('k21', 'solo', 's21'),
('k22', 'solo', 's22'),
('k23', 'solo', 's23'),
('k24', 'solo', 's24'),
('k25', 'solo', 's25'),
('k26', 'duet', 's26'),
('k27', 'duet', 's27'),
('k28', 'duet', 's28'),
('k29', 'duet', 's29'),
('k30', 'duet', 's30');


-- Inserting into Wrote table
insert into Wrote(songid, artistid) values
('s1', 'a1'),
('s2', 'a2'),
('s3', 'a3'),
('s4', 'a4'),
('s5', 'a5'),
('s6', 'a6'),
('s7', 'a7'),
('s8', 'a8'),
('s9', 'a9'),
('s10', 'a10'),
('s11', 'a11'),
('s12', 'a12'),
('s13', 'a13'),
('s14', 'a14'),
('s15', 'a15'),
('s16', 'a16'),
('s17', 'a17'),
('s18', 'a18'),
('s19', 'a19'),
('s20', 'a16'),
('s21', 'a20'),
('s22', 'a21'),
('s23', 'a22'),
('s24', 'a23'),
('s25', 'a24'),
('s26', 'a25'),
('s27', 'a26'),
('s28', 'a27'),
('s29', 'a28'),
('s30', 'a29');


-- Inserting into PriorityRequest table
INSERT INTO PriorityRequest(pqid, user_name, kfid) VALUES
(1, 'John Doe', 'k1'),
(2, 'Jane Doe', 'k2'),
(3, 'John Smith', 'k3'),
(4, 'Jane Smith', 'k4'),
(5, 'John Johnson', 'k5');


-- Inserting into RegularRequest table
INSERT INTO RegularRequest(rqid, user_name, kfid) VALUES
(1, 'John Doe', 'k6'),
(2, 'Jane Doe', 'k7'),
(3, 'John Smith', 'k8'),
(4, 'Jane Smith', 'k9'),
(5, 'John Johnson', 'k10');
