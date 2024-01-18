-- B) Case Study 2: Investigating Metric Spike:
-- Select the Proper DB and Table to start working on Query

USE trainity;

-- 1.Weekly User Engagement:  
-- Your Task:  Write an SQL query to calculate the weekly user engagement.
SELECT EXTRACT(week from occurred_at) as Weeks_Number,
COUNT(distinct user_id) as distinct_user_Numbers 
from events
group by Weeks_Number;



-- 2.User Growth Analysis:  
-- Your Task:  Write an SQL query to calculate the user growth for the product.
select week_num, year_num,
sum(active_users) over (order by week_num, year_num 
rows between unbounded preceding and current row) as cumulative_sum
from (
select extract(week from activated_at) as week_num,
extract(year from activated_at) as year_num,
count(distinct user_id) as active_users from users
where state= "active"
group by year_num, week_num
order by year_num, week_num) as alias;


-- 3.Weekly Retention Analysis:  
-- Your Task:  Write an SQL query to calculate the weekly retention of users based on their sign-up cohort..
select 
extract(week from occurred_at) as Weeks, 
count(distinct user_id) as No_of_RetainedUsers from events
where event_type="signup_flow" and event_name="complete_signup" 
group by weeks order by Weeks;

-- 4.Weekly Engagement Per Device:  
-- Your Task:  Write an SQL query to calculate the weekly engagement per device.
select device AS Device,
extract(week from occurred_at) as Weeks, 
count(distinct user_id) as No_Of_Users 
from events
where event_type="engagement"
group by Device, Weeks order by Weeks; 


-- 5.Email Engagement Analysis:  
-- Your Task:  Write an SQL query to calculate the email engagement metrics.
-- To get the actions which are related to the user activities
select count(action) as Action_Counter, action 
from email_events 
group by action;
select 
(sum(case when 
email_category="email_opened" then 1 else 0 end)/sum(case when email_category="email_sent" then 1 else 0 end))*100 as Emails_Opening_Rate,
(sum(case when 
email_category="email_clickthrough" then 1 else 0 end)/sum(case when email_category="email_sent" then 1 else 0 end))*100 as Emails_Clicking_Rate
from (
	select *, 
	case 
		when action in ("sent_weekly_digest", "sent_reengagement_email") then ("email_sent")
		when action in ("email_open") then ("email_opened")
		when action in ("email_clickthrough") then ("email_clickthrough")
	end as email_category
	from email_events) as Engagement;

