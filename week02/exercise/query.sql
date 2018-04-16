/* Exercise 1 - Task 3
   Query the DB */

/* Query 1: 
   Get the title and year for films made before 1970 */

SELECT title, year
FROM film
WHERE year<1970;

/* Query 2
   Get the title, year, and boxOffice
   for all films, sorted by boxOffice, descending */

SELECT title, year, boxOffice
FROM film
ORDER BY boxOffice DESC;


/* Query 3
   Get the title of all movies starring Sterling Hayden */

SELECT title
FROM film, actor, starring
WHERE film.id=starring.filmid
AND actor.id=starring.actorid
AND actor.name="Sterling Hayden";


/* Query 4
   Get the title and rating of all movies
   with a rating greater than 8.0, in ascending order */

SELECT title, rating
FROM film
WHERE rating>=8.0
ORDER BY rating ASC;

/* Query 5
   Get the title, year, and imdb_votes of the ten films 
   with the largest imdb_vote, sorted by imdb_votes descending */

SELECT title, year, IMDBvotes
FROM film
ORDER BY IMDBvotes DESC
LIMIT 10;


/* Query 6
   Get the title of every film that has the *word* "A" in it 
   (not the letter, but the word) */
SELECT title
FROM film
WHERE title LIKE 'A %' 
OR title LIKE ' A %';


/* Query 7a
   Get the total number of roles stored in the starring table */

SELECT count(*) FROM starring;

/* Query 7b
   Now get the number of unique actors recorded in the starring table */

SELECT count(DISTINCT actorid) FROM starring;

/* Query 8
   8. Get the minimum, maximum, average and sum total 
   of the boxoffice numbers for all films */

SELECT min(boxOffice), max(boxOffice), avg(boxOffice), total(boxOffice)
FROM film;


/* Query 9
   - 9a. Add new table and insert some data
        - Create a new table `director` with an `id` primary key and a `name`. 
        - Insert "Stanley Kubrick" and "Terry Gilliam" to the new table
        - Change the film table to have a foreign key `directorid`.
        - Insert entries for "Brazil (1985)" "Fisher King (1991)" and "12 Monkeys (1995)""
          linked to Gilliam (ignore other attributes)
        - *I did all of this for you* */

CREATE TABLE director(
    id      INTEGER     PRIMARY KEY AUTOINCREMENT,
    name    VARCHAR(64) UNIQUE NOT NULL
);

INSERT INTO director VALUES
    (1, "Stanley Kubrick"),
    (2, "Terry Gilliam");

ALTER TABLE film
ADD COLUMN directorid INTEGER REFERENCES director;

INSERT INTO film (title, year, directorid) 
VALUES ("Brazil", 1985, 2),
       ("Fisher King", 1991, 2),
       ("12 Monkeys", 1995, 2);

/*  - 9b. Use a natural join to get titles and director names. 
        - Since you haven't added foreign keys to Kubrick yet, this should only return 
          results for Gilliam */

SELECT title, name
FROM film, director
WHERE film.directorid=director.id;


/*  - 9c. Now do a left outer join on film and director. */

SELECT title, name
FROM film
LEFT OUTER JOIN director ON director.id=film.directorid;

/* Query 10

    - 10a. Insert directorid foregin keys for all of Kubrick's films */

UPDATE film
SET directorid=1
WHERE directorid IS NULL;

/*  - 10b. Get the list of genres of Kubrick's movies and the number of 
    films in that genre in descending order */

-- count(*) counts NULL
-- count(attributeName) does not count NULL
SELECT genre, count(*)
FROM film, director
-- WHERE directorid=1
WHERE film.directorid=director.id
AND director.name="Stanley Kubrick"
GROUP BY genre
ORDER BY count(*) DESC;

/*  - 10c. Perform the same query but get just the genres in which he 
    made only one film */

SELECT genre, count(*)
FROM film, director
WHERE film.directorid=director.id
AND director.name="Stanley Kubrick"
GROUP BY genre
HAVING count(*)=1;


