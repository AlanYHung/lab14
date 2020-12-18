/* Create a backup database of lab14 called lab14_normal */
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

/* Connect to backup database */
\c lab14_normal;

/* Create a new table named Authors with columns of id and name */ 
CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));

/* Get the unique author values from books table and insert them into the authors table */
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

/* Add a new column named author_id to books table */
ALTER TABLE books ADD COLUMN author_id INT;

/* Pick up the id key from the authors table and put them into the books table under new column author_id */
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

/* Remove the author column from the books table */
ALTER TABLE books DROP COLUMN author;

/* Make author_id in the books table a foreign id key to link it to the authors table */
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);