# Week 03 Homework

## Part 1

### Use Docker Compose to run MySQL and Adminer and load data

In this homework you will use Docker again, but in a slightly different way than during the in-class exercise.

1. Open a terminal and change directory to your homework folder.

2. Double check you are in the right folder by entering the `ls` command. You should see three files:

```
docker-compose.yml
populate.sql
wk03hw.sql
```

3. Run the following command to spin up two Docker containers. One is the MySQL image we used in class. The other is adminer, which will give you a very simple graphical user interface to work with.

        docker-compose up

4. You will see it display a lot of start up messages in your terminal. Now
open your web browser and put this in the address bar: [localhost:8080](localhost:8080). You should see the adminer login screen.

5. Enter the following credentials for adminer and click Login.

```
System: MySQL
Server: db
Username: root
Password: crud
Database: (leave empty)
```

6. Click on the "Create database" link. At the next screen enter `goodreads` in the text box, select `utf8_general_ci` for the collation and click Save.

7. In the column on the left, click on the "Import" link. Click the "Choose Files" button, select the `populate.sql` file, and click "Execute". It should say "1,268 queries executed OK" in a green bar.

OK, you have now succesfully loaded the data for this homework assignment.


## Part 2

In this homework assignment you will analyze someone's Goodreads data. If you are unfamilar with Goodreads, it is a website for tracking the books you have read or want to read. You can rate books and even write reviews. See http://goodreads.com

All of the data is in a single table named `books`. You can view the schema by looking in the CREATE TABLE statement in the `populate.sql` file or by clicking on `goodreads` in the breadcrumbs at the top of the web page and then clicking on the `books` table. A third option is to simply paste in this address: 

[http://localhost:8080/?server=db&username=root&db=goodreads&table=books](http://localhost:8080/?server=db&username=root&db=goodreads&table=books)

Your assignment is to write 10 queries as specified below. 

***IMPORTANT*** Write your queries in the `wk03hw.sql` file. You can test them in adminer by clicking on the "SQL command" link in the left column. Copy and paste your queries into the text box and click "Execute".

*FYI:* The SQL functions mentioned in this assignment are hyperlinked to the MySQL documentation.

------

### Query 1
    
Let's try using a string function. Try to find out how many books in this person's data were written by Isaac Asimov. However, some auhtors are listed in the `additional_authors` field. You will need to use the [INSTR()](https://dev.mysql.com/doc/refman/5.7/en/string-functions.html#function_instr) function to see if the string "Isaac Asimov" is in the `additional_authors` field in addition to finding books with `author="Isaac Asimov"`.

*Expected result (I show only the titles here):*

```
title
-------------------------------------
Dangerous Visions
The Currents of Space (Galactic Empire, #2)
The Stars, Like Dust (Galactic Empire, #1)
The Science Fiction Hall of Fame: Volume 1 (Science Fiction Hall of Fame, #1)
The Gods Themselves
Forward the Foundation (Foundation: Prequel #2)
Foundation's Edge (Foundation #4)
Foundation and Earth (Foundation #5)
Second Foundation (Foundation #3)
Foundation and Empire (Foundation #2)
Foundation (Foundation #1)
```

### Query 2

Get the count of all books that have been read. To determine if a book has been read, simply require that `date_read` is not null.

*Expected result:*

```
count(bookid)
-------------
409
```

### Query 3

OK, now lets look at the count of books read by month to see when this reader is most active. You can use the [MONTH()](https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_month) function to convert a date value to a number representing the month.

e.g. passing 2018-04-22 to the function would return 4.

***I'll do this one for you.***

```sql
SELECT month(date_read) AS month, count(title) AS count
FROM books 
WHERE date_read IS NOT NULL
GROUP BY month(date_read);
```

*Expected result:*

```
month   count
-------------
1       138
2       29
3       31
4       13
5       21
6       26
7       20
8       26
9       19
10      18
11      32
12      36
```

### Query 4

It looks as though this reader does a lot of reading in January. Let's look a little closer though. Now get the count of books, grouped by day of the month for all books *read in January*. You can use the [DAY()](https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_day) function here.

*Expected result:*

```
day count
---------
1   115
2   1
3   1
4   2
5   1
6   2
7   2
8   1
9   1
12  1
13  1
14  1
17  1
18  2
19  1
23  2
24  1
26  1
30  1
```

### Query 5

You can see from the result of Query 4 that there are a lot of books read on January 1st. This is likely because the user knew a year, but not the month or day, so the default is January 1st.

So, let's remove those from the results of Query 3. Rewrite Query 3 such that books read on January 1st of any year are not included.

*Hint 1: You may want to use the `NOT` keyword*

*Hint 2: You may also want to combine the `MONTH()` and `DAY()` functions in
a set of parentheses. e.g. NOT (\_\_\_ AND \_\_\_)*

*Expected result:*

```
month   count
-------------
1       23
2       29
3       31
4       13
5       21
6       26
7       20
8       26
9       19
10      18
11      32
12      36
```

This shows a more normal distribution of books read across the months, with a slight rise at the end of the year, likely due to vacation.

### Query 6

Now get `my_rating`, `avg_rating`, and the difference between the two as `diff` for books that actually have a rating (i.e. `my_rating>0`).

By difference, I mean simply subtracting `avg_rating` from `my_rating`.

*Expected result:*

```
my_rating   avg_rating  diff
--------------------------------------------
4           4.21        -0.20999999999999996
5           3.94        1.06
4           4.1         -0.09999999999999964
2           3.12        -1.12
3           3.71        -0.71
4           3.92        0.08000000000000007
4           3.98        0.020000000000000018
3           4.05        -1.0499999999999998
2           3.44        -1.44
3           3.54        -0.54
5           3.81        1.19
4           4.14        -0.13999999999999968
4           4.19        -0.1900000000000004
4           3.83        0.16999999999999993
4           3.86        0.14000000000000012
3           3.27        -0.27
4           4.16        -0.16000000000000014
5           3.94        1.06

...
results truncated
```

### Query 7

OK, now embed Query 6 inside another query that gets the average, the variance, and the standard deviation of `my_rating`, as well as the average, variance, and standard deviation for `avg_rating`, and the `diff` from the original query.

Use the [AVG()](https://dev.mysql.com/doc/refman/5.7/en/group-by-functions.html#function_avg), [VARIANCE()](https://dev.mysql.com/doc/refman/5.7/en/group-by-functions.html#function_variance), and [STD()](https://dev.mysql.com/doc/refman/5.7/en/group-by-functions.html#function_std) functions.

Your query should look like

```sql
SELECT ...
FROM(
    query 5
) AS ratings;
```

MySQL requires that derived tables (which comes from the embedded select
statement) must have an alias, which is why you must put `AS ratings`.

*Expected result:*

```
It is one long row. I am splitting it up here for visibility purposes.

avg(my_rating)      variance(my_rating)     std(my_rating)  
----------------------------------------------------------
3.7939              0.9918824609733705      0.9959329600798291


avg(avg_rating)     variance(avg_rating)    std(avg_rating) 
-----------------------------------------------------------
3.933777777777779   0.07760411223344568     0.278575146474781


avg(diff)
---------
-0.13983838383838376
```

You can see from these results that the user has a slightly lower average rating. What is more interesting is the difference between the variances and standard deviations. The user's variance and standard deviation are nearly an entire point (1 star), whereas the variance and standard deviation for the whole site is very low. This means the user gives a wide range of scores, whereas the average for the site sits at 4 stars for pretty much everything, without much variation. 

*So much for trusting the aggregate ratings of everyone...every book just gets slightly less than four stars!*

### Query 8

OK, now let's play with dates. Let's see how long a period of time passes between the date a user added a book to the list and the date it was actually read.

Get the `date_added`, `date_read`, `diff`, and `title` for books that have
a `date_read` (i.e. `NOT NULL`).

By `diff` I mean the number of days between them. You can use the 
[DATEDIFF()](https://dev.mysql.com/doc/refman/5.7/en/date-and-time-functions.html#function_datediff) function to calculate that for you.

*Expected results:*

```
date_added  date_read   diff    title
------------------------------------------------
2013-12-09  2018-03-16  1558    Leviathan Wakes (The Expanse, #1)
2018-01-14  2018-03-01  46      Gnomon
2018-01-26  2018-01-30  4       The Management Style of the Supreme Beings
2015-05-24  2015-05-24  0       From Dude to Dad: The Diaper Dude Guide to Pregnancy
2016-07-12  2016-07-12  0       The Bunker, Vol. 1 (The Bunker #1-4)
2017-06-28  2017-11-21  146     The Nordic Theory of Everything: In Search of a Better Life
2017-12-29  2017-12-30  1       ODY-C: Cycle One
2017-12-28  2017-12-28  0       The Flintstones, Vol. 1
2017-08-23  2017-08-23  0       Introducing Quantum Theory
2017-09-01  2018-01-04  125     Provenance
2018-01-06  2018-01-07  1       Super Extra Grande
2017-08-18  2017-10-04  47      How Not to Be Wrong: The Power of Mathematical Thinking
2015-08-31  2017-09-28  759     What Is Life? with Mind and Matter and Autobiographical Sketches
2016-10-08  2017-09-08  335     Time Travel: A History
2017-04-08  2017-08-22  136     Life on the Edge: The Coming of Age of Quantum Biology
2016-10-22  2017-08-08  290     Zen and the Art of Motorcycle Maintenance: An Inquiry Into Values
2017-02-18  2017-07-11  143     Welcome to the Universe: An Astrophysical Tour
2017-06-09  2017-06-07  -2      Letter 44, Volume 4: Saviors
2016-11-08  2016-11-22  14      The Sisters Brothers
2017-02-07  2017-02-21  14      The Player of Games (Culture, #2)
2017-05-18  2017-05-26  8       The Secret History of Twin Peaks
2017-03-29  2017-05-18  50      Waking Gods (Themis Files, #2)
2017-06-06  2017-06-07  1       The Moving Target
2017-06-05  2017-06-02  -3      Emotional Intelligence 2.0: With Access Code
...
results truncated
```

### Query 9

Notice, that a few of the results from Query 8 had negative values. That is because the user added the to the system after thay were read. We'd like to get the average length of time it takes for a user to finally read a book that was added to the list, but we don't want those kinds of negative values to throw off the result.

Rewrite Query 8 such that results with a negative `diff` are not included.

*Expected results:*

```
Same as Query 8, but without the rows that had negative diffs
```

### Query 10

Query 9 got us the right set of rows, but now we want the average.

Now embed Query 9 into another query (similar to what you did in Query 7)
and just select the average of `diff`.

Don't forget that you have to give the derived table an alias. Let's call
it `date_diffs`.

*Expected results:*

```
avg(diff)
---------
149.3574
```

It takes this user about six months to read a book that was added to the list. Of course, that's only counting books that were actually read. This does not account for all the books that were added to the "to-read" shelf, but still have not been read. I leave it to you to figure out how many of those are on this user's list.

### Shutting Down

To shut down your Docker containers simply do a CTRL+C in your terminal.
