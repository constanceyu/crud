/* Exercise 1 - Task 3
   Query the DB */

/* Query 1: 
   Get the title and year for films made before 1970 */

SELECT title, year
FROM film
WHERE year<1970;

/* Query 2
   Get the title, year, and boxoffice
   for all films, sorted by boxoffice, descending */



/* Query 3
   Get the title of all movies starring Sterling Hayden */



/* Query 4
   Get the title and rating of all movies
   with a rating greater than or equal to 8.0, in ascending order */



/* Query 5
   Get the title, year, and imdb_votes of the ten films 
   with the largest imdb_vote, sorted by imdb_votes descending */



/* Query 6
   Get the title of every film that has the *word* "A" in it 
   (not the letter, but the word) */



/* Query 7a
   Get the total number of roles stored in the starring table */



/* Query 7b
   Now get the number of unique actors recorded in the starring table */



/* Query 8
   8. Get the minimum, maximum, average and sum total 
   of the boxoffice numbers for all films */



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


/*  - 9c. Now do a left outer join on film and director. */



/* Query 10

    - 10a. Insert directorid foregin keys for all of Kubrick's films */



/*  - 10b. Get the list of genres of Kubrick's movies and the number of 
    films in that genre in descending order */



/*  - 10c. Perform the same query but get just the genres in which he 
    made only one film */


