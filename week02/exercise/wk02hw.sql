/* CRUD
   Week 2 - Homework 

   This assignment continues with the database you created during the in-class
   exercise, including all the changes, inserts, and updates, we made to it.

   Open up the database kubrick.db and copy and paste the commands from this 
   assignment into the sqlite3 shell as you complete them.

   To avoid redoing all the work if you mess up, you should probably copy your
   existing kubrick.db file to a backup, like so (in your terminal, not in 
   sqlite):

   cp kubrick.db kubrick_backup.db

   Then if you ever make a mess, you can just destroy your current database
   and start fresh from the backup like so:

   rm kubrick.db
   cp kubrcik_backup.db kubrick.db
*/

/* Part 1: Explore the genres */

/* 1a: Get the genres

    Use the group_concat(X) function to get a list of all the genres currently
    used in the film.genre field. */

SELECT group_concat(genre) FROM film;

/* Expected result:

Drama,Drama,Thriller,Drama,Adventure,Romance,Comedy,Adventure,Drama,Adventure,Horror,Drama,Drama

*/

/* 1b: Get genres without repeats

    Perform the same operation, but use the DISTINCT keyword *inside*
    the function to remove the repeated genres. */

SELECT group_concat(DISTINCT genre) FROM film;

/* Expected result:

Drama,Thriller,Adventure,Romance,Comedy,Horror

*/

/* 1c. Now get the distinct values for the genre_complex field */

SELECT group_concat(DISTINCT genre_complex) FROM film;

/* Expected result:

Drama,War,Crime,Drama,Film-Noir,Crime,Film-Noir,Thriller,Adventure,Biography,Drama,Drama,Romance,Comedy,War,Adventure,Mystery,Sci-Fi,Crime,Drama,Sci-Fi,Adventure,Drama,Romance,Horror,Mystery,Drama,Mystery,Thriller

*/

/* It's a mess, even when we use distinct! That's because it has multiple
   values stuffed into each row. Let's fix that in part 2 */

/* ------------------------------------------------------------------------- */


/* Part 2: Normalize complex genre

    Our film table is currently not in 1NF because the field "genre_complex"
    has multiple values stuffed in each row. Let's get our database to 1NF. */


/* 2a: Genre table

    Create a table named genre that has an "id" primary key and another field
    named "label" of max length 32. The "label" must exist and be unique. 

    Don't foregt to autoincrement the id */

CREATE TABLE genre(
    id          INTEGER         PRIMARY KEY AUTOINCREMENT,
    label       VARCHAR(32)     NOT NULL UNIQUE
);

/* 2b: Populate the genres

    Populate the genres table with all the genres currently used in the 
    film.genre_complex field. */

INSERT INTO genre (label)
VALUES ("Crime"),
       ("Horror"),
       ("Biography"),
       ("Adventure"),
       ("Mystery"),
       ("War"),
       ("Thriller"),
       ("Film-Noir"),
       ("Sci-Fi"),
       ("Drama"),
       ("Romance"),
       ("Comedy");

/* 2c: Create the has_genre table

    Create a new table "has_genre" that has two attributes. A foreign key
    for filmid and a foreign key for genreid. Set a table level constraint
    for a primary key that is made of both filmid and genreid. 

    Be sure that both foreign keys always have a value and that they are 
    deleted if the primary keys they refer to are deleted */

CREATE TABLE has_genre(
    filmid      INTEGER     NOT NULL REFERENCES film(id) ON DELETE CASCADE,
    genreid     INTEGER     NOT NULL REFERENCES genre(id) ON DELETE CASCADE,
    PRIMARY KEY (filmid, genreid)
);

/* 2d: Populate the has_genre table *

    Use the INSERT INTO SELECT statement along with the substring comparison
    function INSTR(string, substring) to populate the has_genre table.

    This is not something covered in class, so I did it for you. 
    But please look at it and see if you can understand how it works. */

INSERT INTO has_genre (filmid, genreid)
SELECT film.id, genre.id
FROM film, genre
WHERE INSTR(film.genre_complex, genre.label);

/* 2e. Check your (our) work

    Now perform a query to get the labels for each genre linked to a movie
    using the group_concat function. Also get the title and genre_complex 
    from film so you can see if things match up.

    This is complex, so I did it for you, again. Please examine the
    command and learn from it. */

SELECT title, genre_complex, group_concat(label)
FROM film, genre, has_genre
WHERE film.id=has_genre.filmid
AND has_genre.genreid=genre.id
GROUP BY title;

/* Expected Result:

2001: A Space Odyssey|Adventure,Mystery,Sci-Fi|Adventure,Mystery,Sci-Fi
A Clockwork Orange|Crime,Drama,Sci-Fi|Crime,Sci-Fi,Drama
Barry Lyndon  |Adventure,Drama,Romance|Adventure,Drama,Romance
Dr. Strangelove|Comedy,War|War,Comedy
Eyes Wide Shut |Drama,Mystery,Thriller|Mystery,Thriller,Drama
Fear and Desire|Drama,War|War,Drama
Full Metal Jacket|Drama,War|War,Drama
Killer's Kiss|Crime,Drama,Film-Noir|Crime,Film-Noir,Drama
Lolita |Drama,Romance|Drama,Romance
Paths of Glory|Drama,War|War,Drama
Shining |Horror,Mystery|Horror,Mystery
Spartacus|Adventure,Biography,Drama|Biography,Adventure,Drama
The Killing|Crime,Film-Noir,Thriller|Crime,Thriller,Film-Noir

*/

/* 2f. Clean up the film table

    Now that we have moved everything from the genre_complex field to
    the new has_genre table, we can drop that field from the film table.

    But recall that SQLite3 does not support ALTER TABLE DROP COLUMN.
    So we will have to do this in multiple steps:
        1. Rename film to old_film
        2. Create a new film table
        3. Copy everything from old_film to film
        3. Drop old_film

    Step 1: Rename film to old_film */

ALTER TABLE film RENAME TO old_film;

/*  Step 2: Create a new film table
    It should have the same schema as the original table, but without
    the genre_complex attribute. 

    HINT: You can enter ".schema old_film" in sqlite to get the create table
    statement for the original table and then just copy, paste, & edit */

CREATE TABLE film(
    id              INTEGER             PRIMARY KEY AUTOINCREMENT,
    title           VARCHAR(128)        NOT NULL,
    year            INTEGER             NOT NULL,
    duration        INTEGER,
    budge           INTEGER,
    boxoffice       INTEGER,
    genre           VARCHAR(32),
    rating          REAL,
    imdb_votes      REAL
);

/* Step 3: Copy the data over

    Use the INSERT INTO SELECT like we did in Part 2d. But this time you will
    need to simply specify all the attributes. */

-- 2d:
-- INSERT INTO has_genre (filmid, genreid)
-- SELECT film.id, genre.id
-- FROM film, genre
-- WHERE INSTR(film.genre_complex, genre.label);

INSERT INTO film
SELECT id, title, year, duration, budge, boxoffice, genre, rating, imdb_votes
FROM old_film;

/* Step 4: Now drop the old_film table. */

DROP TABLE old_film;

/* 2f: Tag Gilliam's movies

OK, as a final step of Part 2, let's add some genres to Terry Gilliam's movies. */

INSERT INTO has_genre (filmid, genreid)
VALUES (14, 4),
       (14, 9),
       (14, 12),
       (15, 10),
       (15, 11),
       (16, 4),
       (16, 9);

/* ------------------------------------------------------------------------- */

/* Part 3: Make some queries! */

/* 3a: For each genre, get the label and a list of all the movie titles 
   related to those genres.

   This will involve using the group_concat() function,
   and hence the GROUP BY clause. */

SELECT genre.label, group_concat(title)
FROM genre, film, has_genre
WHERE film.id=has_genre.filmid
AND has_genre.genreid=genre.id
GROUP BY genre.label;

/* Expected result

Adventure|Spartacus,2001: A Space Odyssey,Barry Lyndon  ,Brazil,12 Monkeys
Biography|Spartacus
Comedy|Dr. Strangelove,Brazil
Crime|Killer's Kiss,The Killing,A Clockwork Orange
Drama|Fear and Desire,Killer's Kiss,Paths of Glory,Spartacus,Lolita ,A Clockwork Orange,Barry Lyndon  ,Full Metal Jacket,Eyes Wide Shut ,Fisher King
Film-Noir|Killer's Kiss,The Killing
Horror|Shining 
Mystery|2001: A Space Odyssey,Shining ,Eyes Wide Shut 
Romance|Lolita ,Barry Lyndon  ,Fisher King
Sci-Fi|2001: A Space Odyssey,A Clockwork Orange,Brazil,12 Monkeys
Thriller|The Killing,Eyes Wide Shut 
War|Fear and Desire,Paths of Glory,Dr. Strangelove,Full Metal Jacket

*/


/* 3b: Get the director name and count of genres the director has worked in.

    This is complex. You will need to do a join along 4 tables!
    You will need to use the GROUP BY clause.
    Be sure to use DISTINCT inside the count() function. */

SELECT director.name, count(DISTINCT genre.label)
FROM director, genre, film, has_genre
WHERE film.id=has_genre.filmid
AND director.id=film.directorid
AND genre.id=has_genre.genreid
GROUP BY director.name;


/* Expected Result:

Stanley Kubrick|12
Terry Gilliam|5

*/




