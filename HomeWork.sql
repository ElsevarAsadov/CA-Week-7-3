CREATE DATABASE TEST;
use TEST;


-- ONE TO ONE
CREATE TABLE users
(
id int PRIMARY KEY IDENTITY,
username varchar(20),
email varchar(20),
)


INSERT INTO users (username, email) VALUES ('somebody1', 'example1@gmail.com');
INSERT INTO users (username, email) VALUES ('somebody2', 'example1@gmail.com');
INSERT INTO users (username, email) VALUES ('somebody3', 'example1@gmail.com');


CREATE TABLE [credentials]
(
user_id int FOREIGN KEY REFERENCES users(id),
password varchar(20),
)

INSERT INTO credentials (user_id, password) VALUES (1, 'password1');
INSERT INTO credentials (user_id, password) VALUES (2, 'password2');
INSERT INTO credentials (user_id, password) VALUES (3, 'password3');


SELECT u.username, c.password
FROM users as u
INNER JOIN credentials as c ON u.id = c.user_id;

-- one many suppose song only has one singer everytime

CREATE TABLE singers
(
id int PRIMARY KEY IDENTITY,
name varchar(20)
)

CREATE TABLE alboms
(
id int PRIMARY KEY IDENTITY,
singer_id int FOREIGN KEY REFERENCES singers(id),
name varchar(20),
)

CREATE TABLE songs
(
id int PRIMARY KEY IDENTITY,
name varchar(20),
album int FOREIGN KEY REFERENCES alboms(id),
)

INSERT INTO singers (name) VALUES ('somebody1'), ('somebody2'), ('somebody3')

INSERT INTO alboms (singer_id, name) VALUES (1, 'albom1'), (2, 'albom2'), (3, 'albom3')



INSERT INTO songs (name,album) 
VALUES 
('song1', 1), ('song2', 1), ('song3', 1),
('song1', 2), ('song2', 2), ('song3', 2),
('song1', 3), ('song2', 3), ('song3', 3)


SELECT si.name AS singer_name, s.name AS song_name, a.name AS album_name
FROM songs AS s
INNER JOIN alboms AS a ON s.album = a.id
INNER JOIN singers AS si ON a.singer_id = si.id
WHERE si.id= 3;


SELECT s.id AS song_id, a.id AS album_id, si.id AS singer_id, s.name AS song_name, a.name AS album_name, si.name AS singer_name
FROM songs AS s
LEFT JOIN alboms AS a ON s.album = a.id
LEFT JOIN singers AS si ON a.singer_id = si.id;

SELECT s.id AS song_id, a.id AS album_id, si.id AS singer_id, s.name AS song_name, a.name AS album_name, si.name AS singer_name
FROM songs AS s
RIGHT JOIN alboms AS a ON s.album = a.id
RIGHT JOIN singers AS si ON a.singer_id = si.id;
