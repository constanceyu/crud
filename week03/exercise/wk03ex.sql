/* Week 3 In-class Exercise */

/* Part 1

Table creation statements from Part 1 included here as reference and in case
you need to start over.

*/

CREATE TABLE account(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL,
    balance DOUBLE(14,2) NOT NULL DEFAULT 0.00
    );

INSERT INTO account(name) VALUES 
    ('Aida Jones'),
    ('Belissa Mayo');

UPDATE account SET balance=100.00 WHERE id=1;

SELECT * FROM account;


/* Part 1d - Make a Transaction

Write a transaction statement that transfers $25 from Aida to Belissa
*/

START TRANSACTION...

/* OK, now check the balances: */

SELECT * FROM account;

/* Expected result:

+----+--------------+---------+
| id | name         | balance |
+----+--------------+---------+
|  1 | Aida Jones   |   75.00 |
|  2 | Belissa Mayo |   25.00 |
+----+--------------+---------+
2 rows in set (0.00 sec)

*/

/* ------ Part 2 ------ */

/* Part 2a - Create the tables

Let's create a new set of tables that have data about objects which are part 
of collections.

- Create a table `collection` that has an `id` primary key and a `name` that is 
required and unique. It should also have a field for `total_value` that is a 
double (14 digits max, 2 decimal places) and has a default value of 0.00.

- create another table `object` that also has an `id`, `name`, and `value`. It
should also have a foreign key that points to a collection.

*/

CREATE TABLE collection(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    total_value DOUBLE(14,2) NOT NULL DEFAULT 0.00
    );

CREATE TABLE object(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64) NOT NULL UNIQUE,
    value DOUBLE(14,2) NOT NULL DEFAULT 0.00,
    collectionid INT REFERENCES collection(id)
    );

/* Part 2b - Insert some data */

INSERT INTO collection (name) 
VALUES ('photographs'),
       ('paintings'),
       ('sculpture');

INSERT INTO object (name, value, collectionid)
VALUES ('Spring', 64000000.00, 2),
       ('Irises', 54000000.00, 2),
       ('some selfie 1', 1.23, 1),
       ('some selfie 2', 2.23, 1),
       ('The Thinker', 16000000.00, 3),
       ('The Thinker (replica)', 199.99, 3);

SELECT * FROM object;

/* Expected result:

+----+-----------------------+-------------+--------------+
| id | name                  | value       | collectionid |
+----+-----------------------+-------------+--------------+
|  1 | Spring                | 64000000.00 |            2 |
|  2 | Irises                | 54000000.00 |            2 |
|  3 | some selfie 1         |        1.23 |            1 |
|  4 | some selfie 2         |        2.23 |            1 |
|  5 | The Thinker           | 16000000.00 |            3 |
|  6 | The Thinker (replica) |      199.99 |            3 |
+----+-----------------------+-------------+--------------+
6 rows in set (0.00 sec)

*/

/* Now update the total_value for each collection */

UPDATE collection a
INNER JOIN (
    SELECT collectionid, sum(value) total_value
    FROM object
    GROUP BY collectionid) b ON a.id=b.collectionid
SET a.total_value=b.total_value;

/* Part 2c - Create some triggers */

/* Now create a trigger that updates a collections `total_value` when a new 
object is created. */

CREATE TRIGGER ttl_val_ins AFTER INSERT ON object
  FOR EACH ROW
      UPDATE collection
      SET total_value = total_value + NEW.value
      WHERE id = NEW.collectionid;

/* Now test it out with an insert */

INSERT INTO object (name, value, collectionid)
VALUES ('Obama selfie 1', 2000.00, 3);

SELECT * FROM collection;

/* Expected results:

+----+-------------+--------------+
| id | name        | total_value  |
+----+-------------+--------------+
|  1 | photographs |         3.46 |
|  2 | paintings   | 118000000.00 |
|  3 | sculpture   |  16002199.99 |
+----+-------------+--------------+
3 rows in set (0.00 sec)

Looks like we inserted the selfie into the wrong collection. We should update it.

But wait, our trigger only works on insert. If we update the object table, the collection values will still be incorrect.

Create a trigger to handle updates to object. */

DELIMITER $$

CREATE TRIGGER ttl_val_upd AFTER UPDATE ON object
  FOR EACH ROW
    BEGIN
      IF OLD.collectionid <> NEW.collectionid THEN
        UPDATE collection
        SET total_value=total_value-OLD.value
        WHERE id=OLD.collectionid;
        UPDATE collection
        SET total_value=total_value+OLD.value
        WHERE id=NEW.collectionid;
      ELSE
        UPDATE collection
        SET total_value=total_value - OLD.value + NEW.value
        WHERE id=NEW.id;
      END IF;
    END$$
DELIMITER ;

/* Now test it out */

UPDATE object SET collectionid=1 WHERE name="Obama selfie 1";

SELECT * FROM collection;

/* Expected results:

+----+-------------+--------------+
| id | name        | total_value  |
+----+-------------+--------------+
|  1 | photographs |      2003.46 |
|  2 | paintings   | 118000000.00 |
|  3 | sculpture   |  16000199.99 |
+----+-------------+--------------+
3 rows in set (0.00 sec)

*/

/* While you're at it, create a trigger to handle deletes from object. */

CREATE TRIGGER ttl_val_del AFTER DELETE ON object
  FOR EACH ROW
    UPDATE collection
    SET total_value=total_value-OLD.value
    WHERE id=OLD.collectionid;

/* Now test it out */

DELETE FROM object WHERE name="Obama selfie 1";

SELECT * FROM collection;

/* Expected results:

+----+-------------+--------------+
| id | name        | total_value  |
+----+-------------+--------------+
|  1 | photographs |         3.46 |
|  2 | paintings   | 118000000.00 |
|  3 | sculpture   |  16000199.99 |
+----+-------------+--------------+
3 rows in set (0.00 sec)

*/

/* ------ Part 3 ------ */

/* Now let's play with some MySQL functions.

