/* Exercise 1 - Task 1
   Define the database schemas */

-- primary key is unique and not null by default
CREATE TABLE film(
    id              INTEGER             PRIMARY KEY AUTOINCREMENT,
    title           VARCHAR(128)        NOT NULL,
    year            INTEGER             NOT NULL,
    duration        INTEGER,
    budge           INTEGER,
    boxOffice       INTEGER,
    genre           VARCHAR(32),
    complexGenre    VARCHAR(64),
    rating          REAL,
    IMDBvotes       REAL
);


CREATE TABLE actor(
    id              INTEGER             PRIMARY KEY AUTOINCREMENT,
    name            VARCHAR(64)         NOT NULL UNIQUE
);


CREATE TABLE starring(
    filmid          INTEGER             REFERENCES film ON DELETE CASCADE,
    actorid         INTEGER             REFERENCES actor ON DELETE CASCADE,
    PRIMARY KEY (filmid, actorid)
);