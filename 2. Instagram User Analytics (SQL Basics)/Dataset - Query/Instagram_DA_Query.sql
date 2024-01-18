-- Main Query for Analytics 
USE ig_clone;

/* A) Marketing Analysis: */

-- 1)Loyal User Reward: Identify the five oldest users on Instagram from the provided database.
SELECT 
    id AS user_id,
    username,
    created_at AS account_creation_date
FROM
    users
ORDER BY created_at ASC
LIMIT 5;

-- 2)Inactive User Engagement:  Identify users who have never posted a single photo on Instagram.
SELECT 
    u.id AS user_id,
    u.username,
    p.id AS photo_id,
    p.image_url AS post_url    
FROM
    users u
        LEFT JOIN
    photos p ON u.id = p.user_id
WHERE
    p.user_id IS NULL;
    
-- 3) Contest Winner Declaration: Determine the winner of the contest and provide their details to theteam.
SELECT 
    u.id AS User_ID,
    u.username AS UserName,
    u.created_at AS user_account_creation_date,
    p.id AS Photo_ID,
    p.image_url AS Photo_URL,
    p.created_dat AS Photo_Post_Date,
    COUNT(*) AS Most_Likes
FROM
    photos p
        INNER JOIN
    likes l ON p.id = l.photo_id
        INNER JOIN
    users u ON p.user_id = u.id
GROUP BY p.id
ORDER BY Most_Likes DESC
LIMIT 1;
    
-- 4)Hashtag Research: Identify and suggest the top five most commonly used hashtags on the platform.
SELECT 
    t.tag_name,
    COUNT(p.tag_id) AS tag_count
FROM
    tags t
JOIN
    photo_tags p ON t.id = p.tag_id
GROUP BY t.tag_name
ORDER BY tag_count DESC
LIMIT 5;

-- 5)Ad Campaign Launch: Determine the day of the week when most users register on Instagram. Provide insights on when to schedule an ad campaign.
SELECT 
    DATE_FORMAT(created_at, '%W') AS Day_Of_Week,
    COUNT(*) AS total_registered
FROM
    users
GROUP BY DAY_OF_week
ORDER BY total_registered DESC
LIMIT 3;

/* B) Investor Metrics: */

-- 1)User Engagement: Calculate the average number of posts per user on Instagram. Also, provide the total number of photos on Instagram divided by the total number of users.

-- 
SELECT 
    (SELECT 
            COUNT(*) AS total_users  -- Total users
        FROM
            users) AS Total_Users,
    (SELECT 
            COUNT(*) AS total_photos  -- Total posts
        FROM
            photos) AS Total_Photos,
    (SELECT 
            COUNT(*)
        FROM
            photos) / (SELECT 
            COUNT(*)
        FROM
            users) AS avg_posts_per_user;


-- 2)Bots & Fake Accounts: Identify users (potential bots) who have liked every single photo on the site, as this is not typically possible for a normal user.

-- Total post/photos on platform
SELECT 
    COUNT(*) AS total_photos	-- total post = 257
FROM
    PHOTOS;
-- Bot/Suspicious activity - liking every single photo
SELECT 
    id AS user_id,username, COUNT(*) AS Number_of_likes
FROM
    users
        INNER JOIN	
    likes ON likes.user_id = users.id
GROUP BY likes.user_id
HAVING Number_of_likes = (SELECT 
        COUNT(*)
    FROM
        photos);
        
