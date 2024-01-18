-- Selecting a database to work on > USE <dbName>
USE trainity;

-- Case Study -1 : Job Data Analysis
/* Column Details for Table - job_data
job_id: Unique identifier of jobs
actor_id: Unique identifier of actor
event: The type of event (decision/skip/transfer)
language: The Language of the content
time_spent: Time spent to review the job in seconds
org: The Organization of the actor
ds: The date in the format yyyy/mm/dd(stored as text)
*/

CREATE TABLE job_data
(
    ds DATE,
    job_id INT NOT NULL,
    actor_id INT NOT NULL,
    event VARCHAR(10) NOT NULL,
    language VARCHAR(10) NOT NULL,
    time_spent INT NOT NULL,
    org VARCHAR(2)
);

SELECT *
FROM job_data;

-- Data insertion from CSV
INSERT INTO job_data (ds, job_id, actor_id, event, language, time_spent, org)
VALUES ('2020-11-30', 21, 1001, 'skip', 'English', 15, 'A'),
    ('2020-11-30', 22, 1006, 'transfer', 'Arabic', 25, 'B'),
    ('2020-11-29', 23, 1003, 'decision', 'Persian', 20, 'C'),
    ('2020-11-28', 23, 1005,'transfer', 'Persian', 22, 'D'),
    ('2020-11-28', 25, 1002, 'decision', 'Hindi', 11, 'B'),
    ('2020-11-27', 11, 1007, 'decision', 'French', 104, 'D'),
    ('2020-11-26', 23, 1004, 'skip', 'Persian', 56, 'A'),
    ('2020-11-25', 20, 1003, 'transfer', 'Italian', 45, 'C');


