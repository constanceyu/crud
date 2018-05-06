DROP TABLE IF EXISTS objects_participants;
DROP TABLE IF EXISTS objects_exhibitions;
DROP TABLE IF EXISTS exhibitions;
DROP TABLE IF EXISTS people;
DROP TABLE IF EXISTS objects;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS periods;

CREATE TABLE periods (
    count_objects INT,
    id INT PRIMARY KEY,
    name VARCHAR(128),
    url VARCHAR(256)
);

CREATE TABLE roles(
    count_objects INT,
    count_people INT,
    display_name VARCHAR(128),
    id INT PRIMARY KEY,
    name VARCHAR(256),
    type VARCHAR(64),
    url VARCHAR(256)
);

CREATE TABLE types(
    count_objects INT,
    id INT PRIMARY KEY,
    name VARCHAR(128),
    url VARCHAR(256)
);

CREATE TABLE objects (
    accession_number VARCHAR(128),
    creditline TEXT,
    date VARCHAR(64),
    decade INT,
    department_id INT,
    description TEXT,
    dimensions TEXT,
    dimensions_raw TEXT,
    gallery_text TEXT,
    id INT PRIMARY KEY,
    inscribed TEXT,
    is_loan_object BOOLEAN,
    justification TEXT,
    label_text TEXT,
    markings TEXT,
    medium VARCHAR(256),
    on_display BOOLEAN,
    period_id INT,
    primary_image VARCHAR(256),
    provenance TEXT,
    signed TEXT,
    title VARCHAR(1024),
    type VARCHAR(256),
    type_id INT,
    url VARCHAR(256),
    country_name VARCHAR(64),
    year_acquired INT
);

CREATE TABLE people (
    biography TEXT,
    count_objects INT,
    date VARCHAR(256),
    id INT PRIMARY KEY,
    name VARCHAR(256),
    url VARCHAR(256),
    woe_country_id INT
);

CREATE TABLE exhibitions (
    count_objects INT,
    count_objects_public INT,
    date_end DATE,
    date_start DATE,
    department_id INT,
    id INT PRIMARY KEY,
    title VARCHAR(256),
    url VARCHAR(256)
);

CREATE TABLE objects_exhibitions (
    object_id INT REFERENCES objects,
    id INT,
    title VARCHAR(128),
    date_start DATE,
    date_end DATE
);

CREATE TABLE objects_participants (
    object_id INT REFERENCES objects,
    person_id INT REFERENCES people,
    person_name VARCHAR(256),
    person_url VARCHAR(256),
    role_id INT REFERENCES roles,
    role_name VARCHAR(64),
    role_url VARCHAR(256),
    person_date VARCHAR(256),
    role_display_name VARCHAR(64)
);


COPY periods FROM '/cooperdata/periods.csv' DELIMITER ',' CSV HEADER;
COPY roles FROM '/cooperdata/roles.csv' DELIMITER ',' CSV HEADER;
COPY types FROM '/cooperdata/types.csv' DELIMITER ',' CSV HEADER;
COPY objects FROM '/cooperdata/objects.csv' DELIMITER ',' CSV HEADER;
COPY people FROM '/cooperdata/people.csv' DELIMITER ',' CSV HEADER;
COPY exhibitions FROM '/cooperdata/exhibitions.csv' DELIMITER ',' CSV HEADER;
COPY objects_exhibitions FROM '/cooperdata/objects_exhibitions.csv' DELIMITER ',' CSV HEADER;
COPY objects_participants FROM '/cooperdata/objects_participants.csv' DELIMITER ',' CSV HEADER;
