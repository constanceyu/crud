# Week 04 Exercise

In this exercise you will create views, indexes, and a new user, and you will grant a limited set of privileges to the new users.

## Part 1 - Set Up

1. Open your terminal and change to the directory that has the exercise files. You should see the following files:

    ```
    docker-compose.yml
    names.sql
    wk04ex.sql
    ```

2. Make sure that Docker is running on your machine.

3. Spin up the Docker containers

    ```
    docker-compose up
    ```

4. Go to [localhost:8080](localhost:8080) in your browser

5. Log in to Adminer 
    - System is `PostgreSQL`
    - Server is `db`
    - Username is `postgres`
    - Password is `crud`

## Part 2 - Using Views to Limit Visibility

1. Create a table named `person`. It should have 3 attributes:
    - An `id` primary key (in PostgreSQL, you should use the `SERIAL` data type)
    - A required `name` of max length 32 characters
    - An optional `dob` field of type `DATE`
2. Create a table named `secret`. It should have 4 attributes:
    - An `id` primary key
    - A required string `secret` of max length 256
    - A required `level` small integer
        - This will signify how sensitive the secret is. A zero means, it's not really a secret. A 1 means it should not be mentioned. Anything higher means it is top secret!
    - A required `personid` foreign key
3. Populate the tables with the following INSERT statements

    ```sql
    INSERT INTO person VALUES
        (1, 'Tony Stark', '1970-05-29'),
        (2, 'Steve Rogers', '1918-07-04'),
        (3, 'Bruce Banner', '1969-12-18'),
        (4, 'Thor Odinson', NULL);

    INSERT INTO secret VALUES
        (DEFAULT, 'I pee in my armor', 0, 1),
        (DEFAULT, 'I hate apple pie', 1, 2),
        (DEFAULT, 'My hideout is in Brazil', 2, 3),
        (DEFAULT, 'I miss my hammer', 1, 4);
    ```

4. Test the tables and data by entering a query for the `name`, `dob`, `secret`, and `level` for all secrets.
    - Expected Results:
        
    | name         |  dob       | secret                  | level |
    | ------------ | ---------- | ----------------------- | ----- |
    | Tony Stark   | 1970-05-29 | I peed in my armor      | 0     |
    | Steve Rogers | 1918-07-04 | I hate apple pie        | 1     |
    | Bruce Banner | 1969-12-18 | My hideout is in Brazil | 2     |
    | Thor Odinson | NULL       | I miss my hammer        | 1     |


5. Now create a view named `safe_secrets` that uses gets just the `name` and `secret` for all secrets that have a level of 0.

6. Create a user named `thanos`. Give him the password `ilovedeath`

7. Give thanos permission to read from the `safe_secrets` view.

8. Now log out of Adminer and log back in as thanos.

9. Rerun your query from step 4. Do you get any results?

10. Query everything from the `safe_secrets` view.
    - Expected results:
    | name         | secret              |
    | ------------ | ------------------- |
    | Tony Stark   | I peed in my armor  |


## Part 3 - Using Indexes to Speed up Queries

1. Log out and log back in as `postgres` again.

2. Create a new table named `person2` with 3 attributes
    - A required `id` field of type `INT`
        - Do NOT give it a PRIMARY KEY or UNIQUE constraint
    - A required `name` field of max length 32
    - A required `dob` field of type `DATE`

3. Use the "Import" link to execute the INSERT statements in the `names.sql` file.

4. Use the `EXPLAIN` keyword for all of the following queries. Enter them all in the same execution text box.

    1. Select everything from `person2` but limit to just 100

    2. Same as above, but sort by `name`

    3. Same as above, but limit by date of birth after `1900-01-01`

    4. Select everything from `person2` for the person whose name is `Zclvbwicgeevwpiyodbaamu`

5. Look at the results. Pay attention to the 1st row of each qyery plan. The second number (after the ...) is the total expected cost.

6. Create an index named `name_idx` for the `name` attribute of `person2`.

7. Rerun your four queries. Analyze the differences in total expected costs.

## Part 4 - Submission

1. Submit your `wk04ex.sql` file via CCLE









