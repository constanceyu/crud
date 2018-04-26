# Week 4

### Access Structures <!-- .element: class="fragment" -->
### Optimization <!-- .element: class="fragment" -->
### Security <!-- .element: class="fragment" -->

---

# Access Structures

### Indexes <!-- .element: class="fragment" -->
### Views <!-- .element: class="fragment" -->

----

## What is an index?

- Auxiliary access structure for speedy retrieval <!-- .element: class="fragment" -->
- Can be created for any field in a table <!-- .element: class="fragment" -->
    - Some fields are better suited than others <!-- .element: class="fragment" -->
- Usually stored in a separate file from the main data <!-- .element: class="fragment" -->

----

## How does an index work?

- Create a "node" for each value in the column <!-- .element: class="fragment" -->
    - Nodes have pointers to data blocks <!-- .element: class="fragment" -->
- Order the nodes in a list or tree <!-- .element: class="fragment" -->
- Structure enables binary search <!-- .element: class="fragment" -->
    - Recursively cuts the data in half until desired node is found <!-- .element: class="fragment" -->
    - Runs in log(n) time (base 2) <!-- .element: class="fragment" -->
    - Far more efficient than sequential scan <!-- .element: class="fragment" -->
- Imagine searching a phonebook (index) <!-- .element: class="fragment" -->
    - Versus an unordered phonebook (no index) <!-- .element: class="fragment" -->

----

## SQL Indexes

Basic Syntax

```sql
CREATE INDEX index_name
ON table_name (column_name);
```

- Can also specify:
    - Index type (B-tree, hash, etc.)
    - Multiple columns
    - Reordering
    - How to handle NULLs
    - Uniqueness
    - Partial index

----

## Index example

```sql
CREATE TABLE people(
    fname   VARCHAR(64),
    lname   VARCHAR(64),
    dob     DATE);

CREATE INDEX lname_idx ON people(lname);

SELECT * FROM people
WHERE lname="Zampiello";
```

----

## Index caveats

- Indexes speed up SELECT but slow down INSERT and UPDATE <!-- .element: class="fragment" -->
    - New nodes must be wedged in between existing nodes <!-- .element: class="fragment" -->
    - Requires multiple operations <!-- .element: class="fragment" -->
- Thus the DBA must find the right balance for indexing <!-- .element: class="fragment" -->

----

## What is a view?

- A table derived from a query on other tables <!-- .element: class="fragment" -->
    - The result of a query is an ordered list of tuples <!-- .element: class="fragment" -->
    - Also known as a table <!-- .element: class="fragment" -->
    - Sometimes you want to save that result for repeated lookups <!-- .element: class="fragment" -->
- A view can be temporary or "materialized" <!-- .element: class="fragment" -->
    - Materialized view requires "refreshing" <!-- .element: class="fragment" -->
        - Automate w/ triggers or external app <!-- .element: class="fragment" -->

----

## Uses for views
- Temporary views: <!-- .element: class="fragment" -->
    - Avoiding rewriting complex queries <!-- .element: class="fragment" -->
- Materialized views: <!-- .element: class="fragment" -->
    - Easing load on CPU by caching data <!-- .element: class="fragment" -->
- Both: <!-- .element: class="fragment" -->
    - Restricting access to certain fields <!-- .element: class="fragment" -->

----

## PostgreSQL View Syntax

```sql
CREATE MATERIALIZED VIEW [ IF NOT EXISTS ] table_name
    [ (column_name [, ...] ) ]
    [ WITH ( storage_parameter [= value] [, ... ] ) ]
    [ TABLESPACE tablespace_name ]
    AS query
    [ WITH [ NO ] DATA ]
```

Simplified syntax

```sql
CREATE MATERIALIZED VIEW table_name
    AS query
```

Refresh Syntax

```sql
REFRESH MATERIALIZED VIEW [ CONCURRENTLY ] name
    [ WITH [ NO ] DAT
```

----

## View Example

Part 1 - Table creation

```sql
CREATE TABLE author(
    id       INT NOT NULL PRIMARY KEY,
    fname    VARCHAR(64),
    lname    VARCHAR(64),
    dob      DATE);

CREATE TABLE book(
    id       INT NOT NULL PRIMARY KEY,
    title    VARCHAR(128),
    pubyear  DATE);

CREATE TABLE wrote(
    bookid   INT REFERENCES book,
    author   INT REFERENCES author);
```

----

## View Example cont'd

Part 2 - View creation

```sql
CREATE VIEW author_recent_book (name, title, year) AS
    SELECT lname || "," || fname, title, pubyear
    FROM author, book, wrote
    WHERE author.id=wrote.authorid AND wrote.bookid=book.id
    ORDER BY pubyear DESC
    LIMIT 1;
```

---

# Optimization

----

## Performance Improvement Options

- Indexing <!-- .element: class="fragment" -->
    - Enables faster binary search <!-- .element: class="fragment" -->
- Materialized Views <!-- .element: class="fragment" -->
    - Essentially caches results <!-- .element: class="fragment" -->
- Denormalization <!-- .element: class="fragment" -->
    - Purposefully breaking normalization rules <!-- .element: class="fragment" -->
    - Similar pros and cons as materialized views <!-- .element: class="fragment" -->

But when should you use these options? <!-- .element: class="fragment" -->

----

## Analysis for Physical Design

- To choose HOW to optimize, you must first discover WHAT needs to be optimized <!-- .element: class="fragment" -->
- Must know the kinds of queries & transactions that will be run by the various types of users and applications <!-- .element: class="fragment" -->
- This is called the job mix <!-- .element: class="fragment" -->

----

## Query & Transaction Analysis

- What to look for: <!-- .element: class="fragment" -->
    - tables accessed <!-- .element: class="fragment" -->
    - attributes in select conditions or joins <!-- .element: class="fragment" -->
        - index candidate <!-- .element: class="fragment" -->
    - equality, inequality, or range conditions <!-- .element: class="fragment" -->
    - attributes selected <!-- .element: class="fragment" -->
        - possible sorting <!-- .element: class="fragment" -->
    - atributes to be changed <!-- .element: class="fragment" -->
        - avoid indexing! <!-- .element: class="fragment" -->

----

## Other Analysis Considerations

- Frequency of queries & transactions <!-- .element: class="fragment" -->
- Frequency of updates <!-- .element: class="fragment" -->
    - Limit your indexes! <!-- .element: class="fragment" -->
- Time constraints from the application <!-- .element: class="fragment" -->
- Uniqueness of attributes <!-- .element: class="fragment" -->

----

## Denormalization

- Breaking rules to improve performance <!-- .element: class="fragment" -->
- Create tables in lower normal form (e.g. 1NF) <!-- .element: class="fragment" -->
    - e.g. Store attribute(s) from one table in another <!-- .element: class="fragment" -->
- Benefit: avoids time consuming joins <!-- .element: class="fragment" -->
- Cost: introduces redundancy <!-- .element: class="fragment" -->
    - Potential for anomolies <!-- .element: class="fragment" -->
    - Requires more effort to maintain consistency <!-- .element: class="fragment" -->
- Views do not create inconsistency, but do require effort to maintain "freshness" <!-- .element: class="fragment" -->

----

## Query Tuning

- When should you try to tune a query? <!-- .element: class="fragment" -->
    - If it results in many disk accesses (sequential scan) <!-- .element: class="fragment" -->
    - The query plan shows that indexes are not being used <!-- .element: class="fragment" -->
- What's a query plan? <!-- .element: class="fragment" -->
    - The DBMS can show you exactly what it intends to do to resolve your query <!-- .element: class="fragment" -->
    - In SQL, use the EXPLAIN keyword <!-- .element: class="fragment" -->

```sql
EXPLAIN SELECT * from author;
```

---

# Security

----

## Threats

- Loss of availability <!-- .element: class="fragment" -->
- Loss of integrity (inaccurate data) <!-- .element: class="fragment" -->
    - Can lead to misinformed decisions or fraud - Loss of availability <!-- .element: class="fragment" -->
- Loss of confidentiality <!-- .element: class="fragment" -->
    - Can result in violation of legal requirements - Loss of availability <!-- .element: class="fragment" -->

----

## Attacks

- Privilege escalation by unauthorized user <!-- .element: class="fragment" -->
- Privelege abuse by authorized user <!-- .element: class="fragment" -->
- Denial of Service (DOS) <!-- .element: class="fragment" -->
- Weak authentication / Social Engineering <!-- .element: class="fragment" -->
- SQL Injection <!-- .element: class="fragment" -->

----

## SQL Injection

- Attempts to alter the query sent to a database <!-- .element: class="fragment" -->
- Imagine a web form where the user enters data <!-- .element: class="fragment" -->
    - You concatenate user input with a SQL query string <!-- .element: class="fragment" -->
    - But the user maliciously entered a string that looks like SQL <!-- .element: class="fragment" -->

----

## SQL Injection Example

Your code:

```python
sql = "SELECT * FROM tableX WHERE column1="
sql += user_data
db.execute(sql)
```

User's actual input string:

```python
user_data = "'xxx'; DROP tableX;"
```

----

## Preventing SQL Injection

- Input filtering <!-- .element: class="fragment" -->
    - looks for escape characters <!-- .element: class="fragment" -->
- Use parameterized statements <!-- .element: class="fragment" -->
    - Create a statement with parameters <!-- .element: class="fragment" -->
    - Bind input to those parameters <!-- .element: class="fragment" -->
    - Pass statement and parameters to DB <!-- .element: class="fragment" -->

----

## Parameterized Statement Example

```python
fname = input('Enter your first name:')
lname = input('Enter your last name:')
sql = "INSERT INTO user (fname, lname) VALUES (?, ?)"
params = [fname, lname]
db.execute(sql, params)
```

----

## Security Measures

- Access Control <!-- .element: class="fragment" -->
    - Grant & Revoke access to specific data <!-- .element: class="fragment" -->
- Inference Control <!-- .element: class="fragment" -->
    - Used in statistical databases <!-- .element: class="fragment" -->
    - Blocks overly narrow queries <!-- .element: class="fragment" -->
- Flow Control <!-- .element: class="fragment" -->
    - Blocks writing of data at a lower clearance levels <!-- .element: class="fragment" -->
- Encryption <!-- .element: class="fragment" -->
    - Transforms data into unreadable form <!-- .element: class="fragment" -->
    - Protects data if unauthorized access obtained <!-- .element: class="fragment" -->

----

## Access Control

- Authentication <!-- .element: class="fragment" -->
    - Verification of user identity <!-- .element: class="fragment" -->
    - Usually via username & password <!-- .element: class="fragment" -->
    - Two factor authentication (2FA) now common <!-- .element: class="fragment" -->
- Authorization <!-- .element: class="fragment" -->
    - Verification of permission to access data <!-- .element: class="fragment" -->
    - Various methods of implementation <!-- .element: class="fragment" -->
        - DAC, MAC, RBAC <!-- .element: class="fragment" -->

----

## Discretionary Access Control

- Most common method <!-- .element: class="fragment" -->
- Implements priveleges at Account level & Table level <!-- .element: class="fragment" -->
- Can be modeled as an access matrix <!-- .element: class="fragment" -->
    - rows = users <!-- .element: class="fragment" -->
    - columns = objects (tables, rows, columns, views) <!-- .element: class="fragment" -->
    - values = read|write|update <!-- .element: class="fragment" -->

----

## Access Control in SQL

```sql
GRANT SELECT, INSERT ON author, book, wrote TO userX;
```

```sql
REVOKE INSERT ON author, books, wrote FROM userX;
```

----

## Other Methods

- Mandatory Access Control (MAC) <!-- .element: class="fragment" -->
    - Defines security classes (e.g. Top Secret) <!-- .element: class="fragment" -->
    - Each subject and object is classified <!-- .element: class="fragment" -->
    - Users cannot read data above their clearance <!-- .element: class="fragment" -->
    - Users cannot write data below their clearance <!-- .element: class="fragment" -->
    - Difficult to implement & manage <!-- .element: class="fragment" -->
- Role Based Auccess Control (RBAC) <!-- .element: class="fragment" -->
    - Define roles with priveleges <!-- .element: class="fragment" -->
    - Assign users to roles <!-- .element: class="fragment" -->
    - Popular for flexibility and conveience <!-- .element: class="fragment" -->
---

# EOL

