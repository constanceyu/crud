# Week 05 Homework

In this homework you will work with a real data set. The data comes from the [Cooper-Hewitt, Smithsonian Design Museum](https://www.cooperhewitt.org/). I have done the laborious part of getting the data into shape for ingest into the database. The instructions in Part 1 should result in a working set of tables. In Part 2 you will write some queries to learn about the museum's collection.

Before working on the queries in Part 2 you should look at the `schema.sql` file to get an understanding of the tables and attributes that you will be working with. Real data can be difficult sometimes. You may notice that I used the `TEXT` data type fairly often. This is because the data has many fields that are often empty but have one or two extremely long strings. Also, many of the foreign keys are incorrect, thus I had to omit the `REFERENCES` keyword for some of them.


## Part 1 - Set up

1. Download the `wk05hw.zip` file from CCLE and unzip it.

2. Open a terminal and navigate to the new directory.

        cd /path/to/wk05hw

3. Spin up the Docker containers

        docker-compose up -d

    - If you have trouble, you may need to:
        - Ensure that Docker is running
        - Shut down other containers with 

                docker stop $(docker ps -aq)
            
            - You can also remove the old containers with 

                    docker rm $(docker ps -aq)

4. Open up adminer in your browser [http://localhost:8080](http://localhost:8080)

5. Log in to adminer

    - System is `PostgreSQL`
    - Server is `db`
    - Username is `postgres`
    - Password is `crud`

6. Click on "Create a database". Enter "cooper" and click "save".

7. Click to "SQL Command". Copy and paste all the commands from the `schema.sql` file, and click "Execute". *It may take a few minutes to populate all the tables.*

You should now have the database loaded and ready to query!

## Part 2 - Queries

### Query 1

Let's start with the `objects_participants` table. Get the `role_name` and count of people in that role, with the biggest groups first.

Expected Result:

| role_name   | count |
|--|--|
| Donor   | 126974 |
| Designer    | 28066 |
| Cataloguer  | 19328 |
| Vendor  | 14099 |
| Manufacturer    | 12422 |
| Bequestor   | 9369 |
| Artist  | 8875 |
| Office of   | 3946 |
| Maker   | 3567 |
| Fund    | 3049 |
| Publisher   | 2673 |
| Architect   | 2262 |
| Client  | 2159 |
| Producer    | 1970 |
| Engraver    | 1727 |
| For | 1256 |
| Lender  | 1161 |
| Draftsman   | 1153 |
|... | ... |

Notice in the results that there are roles such as "Donor" and "Cataloguer" who are not artists. Let's find a way to limit it to just artists.

### Query 2

Perform the same query as Query 1, but limit it roles with a type of "production".

Expected Result:

| role_name   | count |
|---|---|
| Designer    | 28066 |
| Manufacturer    | 12422 |
| Artist  | 8875 |
| Office of   | 3946 |
| Maker   | 3567 |
| Publisher   | 2673 |
| Architect   | 2262 |
| Client  | 2159 |
| Producer    | 1970 |
| Engraver    | 1727 |
| For | 1256 |
| Draftsman   | 1153 |
| Creator | 821 |
| Company | 702 |
| Weaver  | 663 |
| Distributor | 608 |
| Collaborator    | 585 |
| Firm    | 526 |
| After   | 509 |
| Printer | 493 |
| Design Director | 490 |
| Embroiderer | 463 |
| Attributed to   | 358 |
| Author  | 270 |
| Design Team member  | 235 |
| ... | ... |


### Query 3

OK, now lets's look at the groups of donors. Perform the same query as Query 2, but limit it to roles with a typr of "donor".

Expected Result:

| role_name   | count |
|---|---|
| Donor   | 126974 |
| Cataloguer  | 19328 |
| Vendor  | 14099 |
| Bequestor   | 9369 |
| Fund    | 3049 |
| Lender  | 1161 |
| Agent   | 619 |
| Funder  | 384 |
| Transferor  | 339 |
| Source  | 186 |
| Executor    | 139 |
| Auctioneer  | 21 |
| Firm    | 5 |
| Recipient   | 5 |
| Buyer   | 3 |
| Borrower    | 2 |
| Transferee  | 1 |
| Exchangee   | 1 |

### Query 4

OK, now let's look at the kinds of stuff in the collection, using the `objects` and the `period` tables. Get the period name and count of objects from that period, with the biggest groups first.

Expected Result:

| name    | count |
|---|---|
| Rococo  | 1183 |
| Hudson River School | 1088 |
| Neoclassical    | 927 |
| American Modern | 537 |
| early Modern    | 329 |
| Art Deco    | 300 |
| Baroque | 167 |
| postwar | 159 |
| Civil War   | 119 |
| Northern Renaissance    | 101 |
| Modern  | 93 |
| Victorian   | 52 |
| Psychedelic | 42 |
| post-Civil War  | 42 |
| World War II    | 40 |
| Late Renaissance    | 39 |
| Postmodern  | 38 |
| Northern Baroque    | 29 |
| Jugendstil/Art Deco | 29 |
| Regency | 28 |
| American Arts and Crafts    | 24 |
| Renaissance | 24 |
| Art Nouveau | 18 |
| Contemporary    | 17 |
| Neapolitan  | 16 |
| ... | ... |

### Query 5

You most likely used a natural join on the last query. Try again using a `LEFT OUTER JOIN` from period to object so that you can also see all the periods that have no items associated with them.

Expected Result:

| name    | count |
| --- | --- |
| Rococo  | 1183 |
| Hudson River School | 1088 |
| Neoclassical    | 927 |
| American Modern | 537 |
| early Modern    | 329 |
| Art Deco    | 300 |
| Baroque | 167 |
| postwar | 159 |
| Civil War   | 119 |
| Northern Renaissance    | 101 |
| ... | ... |
| Late Nineteenth-Early Twentieth Century | 0 |
| Late Ninteenth Century  | 0 |
| Civl War    | 0 |
| Post World War II   | 0 |
| Second half 17th century    | 0 |
| Second half 18th century    | 0 |
| Early Twenty First Century  | 0 |
| mid-19th C  | 0 |
| Early 20th century  | 0 |
| Mid-Eighteenth Century  | 0 |

### Query 6

I don't know much about art, so the name of the period doesn't always help me understand the approximate time of the items in the collection. Let's use the `decade` attribute of the objects to determine the approximate time of the periods.

Perform the same query as Query 5, but also get the average of the decade of the objects per period. To make them easier to read, you can "cast" the average to an integer instead of decimal, like so: `CAST( AVG(object.decade) AS INT )`. The average only works on values that have numbers. As you can see in the results, some of the periods have no objects with any decade information, and thus the average is NULL.

Expected Result:

| name    | count   | avg |
| --- | --- | --- |
| Rococo  | 1183    | NULL |
| Hudson River School | 1088    | 1960 |
| Neoclassical    | 927 | 1910 |
| American Modern | 537 | 1929 |
| early Modern    | 329 | 1925 |
| Art Deco    | 300 | 1923 |
| Baroque | 167 | NULL |
| postwar | 159 | 1951 |
| Civil War   | 119 | NULL |
| Northern Renaissance    | 101 | NULL |
| Modern  | 93  | 1919 |
| Victorian   | 52  | NULL |
| Psychedelic | 42  | 1962 |
| post-Civil War  | 42  | NULL |
| World War II    | 40  | 1933 |
| Late Renaissance    | 39  | NULL |
| Postmodern  | 38  | 1985 |
| Jugendstil/Art Deco | 29  | 1900 |
| Northern Baroque    | 29  | NULL |
| Regency | 28  | NULL |
| ... | ... | ... |

### Query 7

A lot of the results in Query 6 had NULL for the average decade. Let's get rid of those. 

Perform the same query as Query 6, but limit it to those rows that don't have a NULL for the average decade. *Hint: use the `HAVING` clause*.

Expected Result:

| name    | count   | avg |
| --- | --- | --- |
| Classical Revival   | 4   | 1900 |
| Beaux-Arts  | 1   | 1900 |
| Jugendstil/Art Deco | 29  | 1900 |
| Gilded Age  | 1   | 1900 |
| historicism | 6   | 1900 |
| Jugendstil  | 2   | 1905 |
| Neoclassical    | 927 | 1910 |
| Aesthetic Movement  | 6   | 1910 |
| Art Nouveau | 18  | 1918 |
| Modern  | 93  | 1919 |
| American Arts and Crafts    | 24  | 1920 |
| Art Deco    | 300 | 1923 |
| early Modern    | 329 | 1925 |
| American Modern | 537 | 1929 |
| Spanish Civil War   | 1   | 1930 |
| Streamlined Moderne | 4   | 1930 |
| American Mirror | 1   | 1930 |
| AmericanModern  | 1   | 1930 |
| World War II    | 40  | 1933 |
| American  Modern    | 1   | 1940 |
| Mid-Century Modernist   | 4   | 1950 |
| postwar | 159 | 1951 |
| Post-World War II   | 9   | 1951 |
| Hudson River School | 1088    | 1960 |
| Psychedelic | 42  | 1962 |
| Pop | 6   | 1962 |
| New Wave    | 4   | 1963 |
| Late Modern | 9   | 1981 |
| Postmodern  | 38  | 1985 |
| LateTwentieth Century   | 1   | 1990 |
| Modernist   | 2   | 1990 |
| Contemporary    | 17  | 2000 |

### Query 8

Let's see if we can detect a gender bias in the collection. The `people` table does not have an attribute for gender, and names are a bad way to guess. Instead, let's look at pronouns in the `biography` table.

#### Query 8a
Get the count of people that have "her" or "she" in the text of the biography.

#### Query 8b
Get the count of people that have "his" or "he" in the text of the biography.

For both of these you should use a regular expression. There is a shortcut syntax which we did not cover in class, so I will do one of them for you:
 `WHERE biography ~* '\s?her\s?'`

The expression above is true if the `biography` field has the letters "her" anywhere in it, preceded and followed by zero or one characters that are not letters or numbers (i.e. it's OK for whitespace and punctuation, but we don't want other letters around "her" or else it will match on words like "there", and so on).

Expected Results:

Query 8a: Count is 874

Query 8b: Count is 1252

The collection does appear to have a greater representation of males.

### Query 9

Let's look at the types of objects. Get the type name and count of objects of that type with the biggest groups first.

*Hint: This is almost identical to Query 5, but you are using the `type` table instead of the `period` table.*

Expected Result:

| name    | count |
| --- | --- |
| Drawing | 51472 |
| Print   | 42761 |
| textile | 6401 |
| Bound print | 4819 |
| Matchsafe   | 4273 |
| Sidewall    | 4148 |
| Fragment    | 3816 |
| poster  | 3353 |
| Sample  | 3078 |
| button  | 3043 |
| photograph  | 2248 |
| Album   | 1905 |
| Playing card    | 1762 |
| Ephemera    | 1710 |
| Wall facing | 1680 |
| Card    | 1674 |
| Border  | 1660 |
| Album page  | 1077 |
| Sampler | 917 |
| Sketchbook folio    | 897 |
| ... | ... |

### Query 10

Let's narrow our focus to Drawings. Perform the same query and limit it to objects with a type of "Drawing", then group it by decade and put the results in chronological order. *Hint: you will need to put two attributes in the `GROUP BY` clause.*

Expected Result:

| name    | decade  | count |
| --- | --- | --- |
| Drawing | 1900    | 556 |
| Drawing | 1910    | 527 |
| Drawing | 1920    | 1020 |
| Drawing | 1930    | 1513 |
| Drawing | 1940    | 496 |
| Drawing | 1950    | 610 |
| Drawing | 1960    | 292 |
| Drawing | 1970    | 187 |
| Drawing | 1980    | 201 |
| Drawing | 1990    | 169 |
| Drawing | 2000    | 24 |
| Drawing | 2010    | 22 |
| Drawing | NULL    | 45855 |

### Query 11

OK. This is the last one. I'd like to do what we just did for "Drawing", but for the top 20 types. You are going to use a Common Table Expression.

Essentially what your are going to do is `WITH type_counts AS (your Query 9) Query 10`. But you are going to alter Query 9 to `LIMIT` to just the top 20, and you are going to alter the `WHERE` clause of Query 10 such that `type.name` is `IN` a selection of `name` from the results of your temporary table `type_counts`.

Expected Result:

| name    | decade  | count |
| --- | --- | --- |
| Album   | 1900    | 3 |
| Album   | 1920    | 1 |
| Album   | 1970    | 1 |
| Album   | 1980    | 3 |
| Album   | NULL    | 1897 |
| Album page  | 1900    | 122 |
| Album page  | 1920    | 1 |
| Album page  | NULL    | 954 |
| Border  | 1900    | 32 |
| Border  | 1910    | 5 |
| Border  | 1920    | 73 |
| Border  | 1930    | 4 |
| Border  | 1940    | 13 |
| Border  | 1950    | 114 |
| Border  | 1960    | 12 |
| Border  | 1980    | 3 |
| Border  | 1990    | 14 |
| Border  | 2000    | 2 |
| Border  | NULL    | 1388 |
| Bound print | 1940    | 1 |
| Bound print | NULL    | 4818 |
| button  | 1900    | 6 |
| button  | 1910    | 1 |
| button  | 1920    | 14 |
| button  | 1930    | 4 |
| button  | 1940    | 67 |
| button  | 1980    | 2 |
| button  | 1990    | 22 |
| button  | NULL    | 2927 |
| Card    | 1920    | 1 |
| Card    | 1930    | 2 |
| Card    | 1950    | 1 |
| Card    | 1960    | 1 |
| Card    | 1980    | 13 |
| Card    | 1990    | 8 |
| Card    | NULL    | 1648 |
| Drawing | 1900    | 556 |
| Drawing | 1910    | 527 |
| Drawing | 1920    | 1020 |
| Drawing | 1930    | 1513 |
| Drawing | 1940    | 496 |
| Drawing | 1950    | 610 |
| Drawing | 1960    | 292 |
| Drawing | 1970    | 187 |
| Drawing | 1980    | 201 |
| Drawing | 1990    | 169 |
| Drawing | 2000    | 24 |
| Drawing | 2010    | 22 |
| Drawing | NULL    | 45855 |
| Ephemera    | 1920    | 1 |
| Ephemera    | 1930    | 4 |
| Ephemera    | 1940    | 1 |
| Ephemera    | 1950    | 1 |
| Ephemera    | 1960    | 1 |
| Ephemera    | NULL    | 1702 |
| Fragment    | 1900    | 28 |
| Fragment    | 1910    | 3 |
| Fragment    | 1920    | 13 |
| Fragment    | 1930    | 7 |
| Fragment    | 1940    | 18 |
| Fragment    | 1950    | 15 |
| Fragment    | 1960    | 3 |
| Fragment    | 1970    | 1 |
| Fragment    | 1980    | 6 |
| Fragment    | 1990    | 3 |
| Fragment    | NULL    | 3719 |
| Matchsafe   | 1900    | 36 |
| Matchsafe   | 1910    | 4 |
| Matchsafe   | 1920    | 3 |
| Matchsafe   | NULL    | 4230 |
| photograph  | 1900    | 69 |
| photograph  | 1910    | 27 |
| photograph  | 1920    | 61 |
| photograph  | 1930    | 4 |
| photograph  | 1940    | 15 |
| photograph  | 1950    | 10 |
| photograph  | 1960    | 3 |
| photograph  | 1970    | 1 |
| photograph  | 2000    | 2 |
| photograph  | NULL    | 2056 |
| Playing card    | 1930    | 2 |
| Playing card    | NULL    | 1760 |
| poster  | 1900    | 4 |
| poster  | 1910    | 25 |
| poster  | 1920    | 42 |
| poster  | 1930    | 112 |
| poster  | 1940    | 67 |
| poster  | 1950    | 54 |
| poster  | 1960    | 209 |
| poster  | 1970    | 724 |
| poster  | 1980    | 430 |
| poster  | 1990    | 408 |
| poster  | 2000    | 112 |
| poster  | 2010    | 34 |
| poster  | NULL    | 1132 |
| Print   | 1900    | 118 |
| Print   | 1910    | 63 |
| Print   | 1920    | 58 |
| Print   | 1930    | 77 |
| Print   | 1940    | 81 |
| Print   | 1950    | 33 |
| Print   | 1960    | 54 |
| Print   | 1970    | 69 |
| Print   | 1980    | 40 |
| Print   | 1990    | 18 |
| Print   | 2000    | 18 |
| Print   | NULL    | 42132 |
| Sample  | 1900    | 45 |
| Sample  | 1910    | 55 |
| Sample  | 1920    | 282 |
| Sample  | 1930    | 474 |
| Sample  | 1940    | 192 |
| Sample  | 1950    | 469 |
| Sample  | 1960    | 559 |
| Sample  | 1970    | 31 |
| Sample  | 1980    | 34 |
| Sample  | 1990    | 14 |
| Sample  | 2000    | 1 |
| Sample  | NULL    | 922 |
| Sampler | 1900    | 26 |
| Sampler | 1910    | 4 |
| Sampler | 1920    | 3 |
| Sampler | 1930    | 3 |
| Sampler | 1940    | 2 |
| Sampler | 1950    | 2 |
| Sampler | 2010    | 1 |
| Sampler | NULL    | 876 |
| Sidewall    | 1900    | 168 |
| Sidewall    | 1910    | 87 |
| Sidewall    | 1920    | 484 |
| Sidewall    | 1930    | 372 |
| Sidewall    | 1940    | 304 |
| Sidewall    | 1950    | 506 |
| Sidewall    | 1960    | 205 |
| Sidewall    | 1970    | 77 |
| Sidewall    | 1980    | 46 |
| Sidewall    | 1990    | 247 |
| Sidewall    | 2000    | 40 |
| Sidewall    | 2010    | 31 |
| Sidewall    | NULL    | 1581 |
| Sketchbook folio    | 1900    | 11 |
| Sketchbook folio    | NULL    | 886 |
| textile | 1900    | 145 |
| textile | 1910    | 178 |
| textile | 1920    | 263 |
| textile | 1930    | 214 |
| textile | 1940    | 186 |
| textile | 1950    | 289 |
| textile | 1960    | 218 |
| textile | 1970    | 137 |
| textile | 1980    | 287 |
| textile | 1990    | 78 |
| textile | 2000    | 60 |
| textile | 2010    | 27 |
| textile | NULL    | 4319 |
| Wall facing | NULL    | 1680 |

## Part 3 - Submission

Submit your `wk05hw.sql` file vie CCLE.