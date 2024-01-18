-- use trainity database
USE trainity;

-- Create Users Table
CREATE TABLE `users` (
  `user_id` int DEFAULT NULL,
  `created_at` text DEFAULT NULL,
  `company_id` int DEFAULT NULL,
  `language` varchar(15) DEFAULT NULL,
  `activated_at` text DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL
);
SELECT * FROM users;

-- Create events Table
CREATE TABLE `events` (
  `user_id` int DEFAULT NULL,
  `occurred_at` text,
  `event_type` text,
  `event_name` text,
  `location` text,
  `device` text,
  `user_type` int DEFAULT NULL
);
SELECT * FROM events;

-- Create email_events Table
CREATE TABLE `email_events` (
  `user_id` int DEFAULT NULL,
  `occurred_at` text DEFAULT NULL,
  `action` varchar(50) DEFAULT NULL,
  `user_type` int DEFAULT NULL
);
SELECT * FROM email_events;

-- As the dataset is too large we will use the inbuild function called `load data infile`to import the csv data.
-- firstly check the file permission & move the csv to the location given in results and then do changes accordingly.

SHOW VARIABLES LIKE "secure_file_priv";

-- importing the users data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv' 
INTO TABLE users 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from users;

-- importing the events data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv' 
INTO TABLE events 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from events;

-- importing the email_events data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/email_events.csv' 
INTO TABLE email_events 
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

select * from email_events;

-- we need to alter the columns having date as datetime to make the querying more reasonable 
-- if u get safety error run below command once before altering tables
SET SQL_SAFE_UPDATES = 0;

-- alter created at column
alter table users add column temp datetime;
update users set temp = str_to_date(created_at, '%d-%m-%Y %H:%i');
alter table users drop column created_at;
alter table users change column temp created_at datetime;
select * from users;

-- alter activated at column
alter table users add column temp datetime;
update users set temp = str_to_date(activated_at, '%d-%m-%Y %H:%i');
alter table users drop column activated_at;
alter table users change column temp activated_at datetime;
select * from users;

-- alter occured at column from events table
alter table events add column temp datetime;
update events set temp = str_to_date(occurred_at, '%d-%m-%Y %H:%i');
alter table events drop column occurred_at;
alter table events change column temp occurred_at datetime;
select * from events;

-- alter occurred_at column email events table
alter table email_events add column temp datetime;
update email_events set temp = str_to_date(occurred_at, '%d-%m-%Y %H:%i');
alter table email_events drop column occurred_at;
alter table email_events change column temp occurred_at datetime;
select * from email_events;

