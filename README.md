# CRUD: A Survey of Database Technology

## Syllabus

## Abstract
The relational database has been the dominant tool for data storage over the past thirty years. But with the growth of the web has come new requirements for faster searching and storing of large amounts of data and new tools have risen to meet those demands. This course will review the basics of relational databases as a foundation and as a basis for comparison to other tools. From there, we will look at alternative NoSQL databases (columnar, keystore, document, and graph), as well as search indexes, triplestores, and NewSQL databases. In-depth coverage of any topic should not be expected. The objective of the course is to give students an understanding of the wide variety of database solutions and the tradeoffs of using one over another.

## Prerequisites

### Required
- Prior programming experience. Assignments will involve writing programs in Python to load, extract and make use of data.
- Curiosity and fearlessness about trying new things - we will be using one or more new technologies each week.

### Helpful
- Basic understanding of relational databases and SQL. We will quickly cover these topics in the first weeks, but a familiarity with them before the class starts will be beneficial.

## Instructor
Joshua Gomez, Sr. Software Engineer, Getty Research Institute

joshuagomez@ucla.edu

## Grading
- 9% Quizzes (9 total)
- 90% Assignments (10 total)
- 1% Participation

## Texts
All textbooks listed below are optional, but highly recommended for students who have not taken a prior course in databases or search engines.
- Elmasri & Navathe: *Fundamentals of Database Systems*
	- *Please use the older (and cheaper) 6th edition. The assigned chapters correspond to this edition* ([Amazon](https://www.amazon.com/Fundamentals-Database-Systems-Ramez-Elmasri/dp/0136086209/))
- Manning, Raghavan, & Schütze: *Introduction to Information Retrieval*
	- *Free version available online:* https://nlp.stanford.edu/IR-book/

## Schedule

### Week 1
|  |  |
|--:|--|
|Topics:|Introduction<br/>RDBMS concepts<br/>ER Modeling<br/>Basic SQL<br/>ACID Transactions|
| Tools:|[SQLite](https://sqlite.org/docs.html)  |
|  Readings:|Elmasri: chapters 3-4, 7 (optional: chapters 1-2)  |

### Week 2
|  |  |
|--:|--|
|Topics:|Normalization<br/>Complex SQL<br/>ORMs<br/>Sharding<br/>|
| Tools:|[PostgreSQL](https://www.postgresql.org/docs/10/static/index.html)  |
|  Readings:|Elmasri: chapters 15, 5|

### Week 3
|  |  |
|--:|--|
|Topics:|Intro to Information Retrieval<br/>Tokenization, Normalization, & Stemming|
| Tools:|[ElasticSearch](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)  |
|  Readings:|Manning: chapters 1-3|

### Week 4
|  |  |
|--:|--|
|Topics:|IR Scoring & Evaluation<br/>Faceted Search|
| Tools:|[Solr](https://lucene.apache.org/solr/resources.html)|
|  Readings:|Manning: chapters 6-8|

### Week 5
|  |  |
|--:|--|
|Topics:|Intro to NoSQL Databases<br/>CAP Theorem<br/>Columnar Databases|
| Tools:|[HBase](https://lucene.apache.org/solr/resources.html)<br/>[Cassandra](https://cassandra.apache.org/)|
|  Readings:|[Google’s Bigtable Paper](https://research.google.com/archive/bigtable.html) (Chang et al., 2006)<br/>[Facebook’s Cassandra Paper](https://www.cs.cornell.edu/projects/ladis2009/papers/lakshman-ladis2009.pdf) (Lakshman et al., 2009)|

### Week 6
|  |  |
|--:|--|
|Topics:|Key Stores|
| Tools:|[Riak](http://basho.com/products/#riak)<br/>[Redis](http://redis.io/)|
|  Readings:|[Amazon’s Dynamo Paper](https://www.allthingsdistributed.com/files/amazon-dynamo-sosp2007.pdf) (DiCandia et al., 2007)|

### Week 7
|  |  |
|--:|--|
|Topics:|Document Stores & MapReduce|
| Tools:|[MongoDB](https://www.mongodb.com/)<br/>[CouchDB](https://couchdb.apache.org/)|
|  Readings:|*TBD*|

### Week 8
|  |  |
|--:|--|
|Topics:|Graph Databases|
| Tools:|[Neo4j](https://neo4j.com/)<br/>[ArrangoDB](https://arangodb.com/)|
|  Readings:|*TBD*|

### Week 9
|  |  |
|--:|--|
|Topics:|Linked Data<br/>Triplestores<br/>SPARQL|
| Tools:|[Jena](http://jena.apache.org/)<br/>[ArrangoDB](https://virtuoso.openlinksw.com/)|
|  Readings:|*TBD*|

### Week 10
|  |  |
|--:|--|
|Topics:|NewSQL Databases|
| Tools:|[CockroachDB](https://www.cockroachlabs.com/install-getstarted/)|
|  Readings:|*TBD*|
