-- Case Study -1 : Job Data Analysis
-- Select the Proper DB and Table to start working on Query

USE trainity;
SELECT *
FROM job_data;

-- A) Jobs Reviewed Over Time:
-- Your Task: Write an SQL query to calculate the number of jobs reviewed per hour for each day in November 2020.
SELECT ds AS DATE,
count(job_id) AS JobId_Reviewed_Per_Day,
sum(time_spent)/3600 AS hours_spent_on_review,
ROUND(count(job_id)/(sum(time_spent)/3600)) AS jobs_reviewed_per_hour
FROM job_data  
WHERE ds >='2020-11-01'  AND ds <='2020-11-30'  
GROUP BY ds;

-- B) Throughput Analysis:
-- Your Task: Write an SQL query to calculate the 7-day rolling average of throughput.
SELECT event AS Events,
ROUND((COUNT(event)/SUM(time_spent)),3) AS Weekly_Throughput 
FROM job_data 
GROUP BY event;

#Daily Metric Throughput(Daywise & event grouping)
select event,ds as date, round((count(event)/sum(time_spent)),3) as daily_metric 
from job_data group by event,date;

-- C) Language Share Analysis:
select language, round(((count(language) /8)*100),2) as share_of_lang 
from job_data group by language;
SELECT language AS Language,
COUNT(*) AS Job_count,
ROUND(100.0 * COUNT(*)/ SUM(COUNT(*)) OVER(),2) AS Language_Percentage 
FROM job_data
GROUP BY language 
ORDER BY Language_Percentage DESC;

-- D) Duplicate Rows Detection: (we can replace the column name to find respective duplicates)
SELECT job_id,COUNT(*) as jobId_duplicates
FROM job_data
group by job_id
having COUNT(*) >1;

SELECT job_id, actor_id, event, language, time_spent, org, ds, 
COUNT(*) AS count 
FROM job_data 
GROUP BY job_id, actor_id, event, language, time_spent, org, ds 
HAVING COUNT(*) > 1 
ORDER BY count DESC;