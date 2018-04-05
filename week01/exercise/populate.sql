/* Exercise 1 - Task 2
   Populate the DB */


INSERT INTO film 
VALUES (1, "Fear and Desire",1953,72,33,0,"Drama","Drama | War",5.6,2.079);

INSERT INTO actor
VALUES (1, "Frank Silvera"),
       (2, "Kenneth Harp"),
       (3, "Paul Mazursky"),
       (4, "Stephen Coit");

INSERT INTO starring
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4);


INSERT INTO film 
VALUES (2, "Killer's Kiss",1955,67,40,0,"Drama","Crime | Drama | Film-Noir",6.7,10.638);

INSERT INTO actor
VALUES (5, "Jamie Smith"),
       (6, "Irene Kane"),
       (7, "Jerry Jarret"),
       (8, "Mike Dana");

INSERT INTO starring
VALUES (2, 1), /* Frank Silvera! */
       (2, 5),
       (2, 6),
       (2, 7),
       (2, 8);

/* You do the rest... */