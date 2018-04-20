# Week 3

### Transactions <!-- .element: class="fragment" -->
### Triggers <!-- .element: class="fragment" -->
### More SQL <!-- .element: class="fragment" -->

---

# Transactions

- A logical unit of database processing <!-- .element: class="fragment" -->
- Made up of one or more operations (CRUD) <!-- .element: class="fragment" -->
- Example: <!-- .element: class="fragment" -->
    - read data <!-- .element: class="fragment" -->
    - perform calculation <!-- .element: class="fragment" -->
    - update data <!-- .element: class="fragment" -->
- Must complete all operations or be undone <!-- .element: class="fragment"  -->

---

## Concurrent Processes

- Large systems (e.g. banks and airlines) have to handle many transactions simultaneously <!-- .element: class="fragment" -->
- So how does a computer handle multiple processes? <!-- .element: class="fragment" -->
    - A single CPU machine must use multiprogramming to interleave the processes <!-- .element: class="fragment" -->
    - A multiprocessor machine can execute processes in parallel <!-- .element: class="fragment" -->

----

## Multiprogramming

- CPU is idle when a process reads from disk <!-- .element: class="fragment" -->
- Meanwhile, other processes are waiting to run <!-- .element: class="fragment" -->
- Time slicing: switch between processes <!-- .element: class="fragment" -->
    - Run process until I/O call or the timer ends <!-- .element: class="fragment" -->
    - Stop process, save state, put back in queue <!-- .element: class="fragment" -->
    - Load next process in queue, and repeat <!-- .element: class="fragment" -->
- Gives the illusion of simultaneity <!-- .element: class="fragment" -->

----

## Database I/O

- Two basic operations: read and write <!-- .element: class="fragment" -->
- read_item(X) <!-- .element: class="fragment" -->
    - Find the address of disk block containing X <!-- .element: class="fragment" -->
    - Copy block to main memory buffer <!-- .element: class="fragment" -->
    - Copy item X from buffer to variable X <!-- .element: class="fragment" -->
- write_item(X) <!-- .element: class="fragment" -->
    - Find the address of disk block containing X <!-- .element: class="fragment" -->
    - Copy block to main memory buffer <!-- .element: class="fragment" -->
    - Copy variable X to X location in buffer <!-- .element: class="fragment" -->
    - Store buffer data back to disk block  <!-- .element: class="fragment" -->

----

## Concurrency Control
- Errors arise when the read and write ops from multiple processes are interleaved <!-- .element: class="fragment" -->
    - Lost Update <!-- .element: class="fragment" -->
    - Dirty Read <!-- .element: class="fragment" -->
    - Incorrect Summary <!-- .element: class="fragment" -->
    - Unrepeatable Read <!-- .element: class="fragment" -->
- Concurrency control attempts to mitigate or eliminate these problems <!-- .element: class="fragment" -->

----

## Lost Update

Occurs when two transactions access the same data are interleaved, resulting in incorrect values <!-- .element: class="fragment" -->

Example: X = 100, Y = 100 <!-- .element: class="fragment" -->

![lost update diagaram](images/lost_update.svg) <!-- .element: class="fragment" -->

X should be 120, instead it is 130! <!-- .element: class="fragment" -->

----

## Dirty Read

Occurs when one transaction updates a value, but then fails and another transaction reads it before rollback <!-- .element: class="fragment" -->

Example: X = 100, Y = 100 <!-- .element: class="fragment" -->

![dirty read diagaram](images/dirty_read.svg) <!-- .element: class="fragment" -->

X should be 130, instead it is 120! <!-- .element: class="fragment" -->

----

## Incorrect Summary

- T2 reads many values to get an aggregate value <!-- .element: class="fragment" -->
- At same time T1 changes a couple values <!-- .element: class="fragment" -->

![incorrect summary diagaram](images/incorrect_summary.svg) <!-- .element: class="fragment" -->

Count will be off by 10 <!-- .element: class="fragment" -->

----

## Unrepeatable Read

- Occurs when a transaction read same item twice, and gets different values, due to another process <!-- .element: class="fragment"  -->
- Example: <!-- .element: class="fragment"  -->
    - Ticket system said a pair of seats were available <!-- .element: class="fragment"  -->
    - But when you finally clicked "buy" they were gone <!-- .element: class="fragment"  -->

----

## Recovery

- A transaction must: <!-- .element: class="fragment"  -->
    - Complete ALL its operations <!-- .element: class="fragment"  -->
    - Be saved to disk (committed) <!-- .element: class="fragment"  -->
- If it fails (aborted): <!-- .element: class="fragment"  -->
    - DB must undo the operations <!-- .element: class="fragment"  -->
- Recovery is the set of methods to undo failures <!-- .element: class="fragment"  -->

----

## Types of Failures
1. System crash (memory or network error) <!-- .element: class="fragment"  -->
2. Transaction or system error (divide by zero) <!-- .element: class="fragment"  -->
3. Local errors (data not found, insufficient) <!-- .element: class="fragment"  -->
4. Concurrency control (avoid deadlock) <!-- .element: class="fragment"  -->
5. Disk failure <!-- .element: class="fragment"  -->
6. Catastrophe (fire, earthquake, etc.) <!-- .element: class="fragment"  -->

---

## Transaction States

- Recovery manager must keep track of transaction state <!-- .element: class="fragment"  -->

![transaction states diagram](images/transaction_states.svg) <!-- .element: class="fragment"  -->

- Failed or aborted transaction can be restarted <!-- .element: class="fragment"  -->
    - automatically or manually <!-- .element: class="fragment"  -->

----
## System Log

- Records all transaction ops sequentially <!-- .element: class="fragment"  -->
    - start_transaction, T <!-- .element: class="fragment"  -->
    - write_item, T, X, old_value, new_value <!-- .element: class="fragment"  -->
    - read_item, T, X <!-- .element: class="fragment"  -->
    - commit, T <!-- .element: class="fragment"  -->
    - abort, T <!-- .element: class="fragment"  -->
- Enables recovery by going backward through the log <!-- .element: class="fragment"  -->
- Can be buffered <!-- .element: class="fragment"  -->
    - Must write to disk at commit point <!-- .element: class="fragment"  -->

----

## ACID Properties

Transactions should be: <!-- .element: class="fragment"  -->
- Atomic: all operations are performed or none are <!-- .element: class="fragment"  -->
    - roll back ops on abort <!-- .element: class="fragment"  -->
- Consitent: if completed, state of DB should be valid <!-- .element: class="fragment"  -->
    - i.e. all constraints met <!-- .element: class="fragment"  -->
- Isolated: should operate without interference <!-- .element: class="fragment"  -->
    - lock data items <!-- .element: class="fragment"  -->
- Durable: when committed, changes must persist <!-- .element: class="fragment"  -->
    - including recovery from failures <!-- .element: class="fragment"  -->

----

## Schedules

- A schedule is an ordering of ops of multiple transactions <!-- .element: class="fragment"  -->
- Operations are in conflict when <!-- .element: class="fragment"  -->
    - Belong to different transaction <!-- .element: class="fragment"  -->
    - Access the same item <!-- .element: class="fragment"  -->
    - At least one is a write operation <!-- .element: class="fragment"  -->

----

## Recoverability

- A schedule is "recoverable" if... <!-- .element: class="fragment"  -->
- no transaction T commits until... <!-- .element: class="fragment"  -->
- all transactions T' that wrote an item read by T <!-- .element: class="fragment"  -->
- have also committed<!-- .element: class="fragment"  -->

Guarantees no rollback for committed transactions <!-- .element: class="fragment"  -->

But can lead to costly cascading rollbacks for uncommitted transactions <!-- .element: class="fragment"  -->

----

## Recoverability

- A schedule is cascadeless if every transaction... <!-- .element: class="fragment"  -->
    - reads only from items written by committed transactions <!-- .element: class="fragment"  -->
    - This causes delays <!-- .element: class="fragment"  -->
- A schedule is strict if every transaction... <!-- .element: class="fragment"  -->
    - neither reads or writes until last transaction to write is committed <!-- .element: class="fragment"  -->
    - Enables easy recovery, but also delays <!-- .element: class="fragment"  -->

----

## Serializability

- A serial schedule runs all ops of one transaction before another <!-- .element: class="fragment"  -->
    - Guarantees correctness <!-- .element: class="fragment"  -->
    - But is unacceptably inefficient<!-- .element: class="fragment"  -->
- A serializable schedule is an interleaved one that is equivalent to a serial one <!-- .element: class="fragment"  -->
    - Offers benefit of concurrency while guaranteeing correctness <!-- .element: class="fragment"  -->

----

## Basic Transaction Syntax

```sql
START TRANSACTION;
/* do something */
COMMIT;
```

Or...

```sql
START TRANSACTION;
/* do something */
ROLLBACK;
```

---

# Triggers

A method for declaring active rules <!-- .element: class="fragment"  -->

----

## Active Database Model

- ECA: Event-Condition-Action <!-- .element: class="fragment"  -->
- Event triggers the rule <!-- .element: class="fragment"  -->
    - Usually from an update operation <!-- .element: class="fragment"  -->
    - But possibly by time or external event <!-- .element: class="fragment"  -->
- Condition determines if action will be taken <!-- .element: class="fragment"  -->
    - This is optional <!-- .element: class="fragment"  -->
- The action is usually anothr sequence of SQL statement <!-- .element: class="fragment"  -->
    - Could also trigger external process  <!-- .element: class="fragment"  -->
----

## Trigger Uses

- Notifications <!-- .element: class="fragment"  -->
- Enforcing Constraints <!-- .element: class="fragment"  -->
    - Business rules <!-- .element: class="fragment"  -->
- Maintaining Derived Data <!-- .element: class="fragment"  -->

----

## Basic Trigger Syntax

```sql
CREATE TRIGGER trigger_name
    trigger_time trigger_event
    ON table_name FOR EACH ROW
    [trigger_order]
    trigger_body

trigger_time: { BEFORE | AFTER }

trigger_event: { INSERT | UPDATE | DELETE }

trigger_order: { FOLLOWS | PRECEDES } other_trigger_name
```

---

# More SQL Functions

----

## Core Functions

- Last week we looked at aggregate functions <!-- .element: class="fragment"  -->
    - These oprate in conjunction with the GROUP BY syntax <!-- .element: class="fragment"  -->
- There are many more core functions that operate on individual pieces of data <!-- .element: class="fragment"  -->
- Each database has its own set of core functions <!-- .element: class="fragment"  -->
    - [SQLite3](https://www.sqlite.org/lang_corefunc.html) <!-- .element: class="fragment"  -->
    - [MySQL](https://dev.mysql.com/doc/refman/5.7/en/func-op-summary-ref.html) <!-- .element: class="fragment"  -->
    - [PostgreSQL](https://www.postgresql.org/docs/10/static/functions.html) <!-- .element: class="fragment"  -->

---

# EOL