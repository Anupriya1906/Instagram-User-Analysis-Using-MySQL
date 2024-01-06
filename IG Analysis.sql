USE ig_clone;

-- 1.Find the 5 oldest users of the Instagram from the database provided
SELECT * FROM users;

SELECT username,created_at
FROM users
ORDER BY created_at
LIMIT 5;

-- 2.Find the users who have never posted a single photo on instagram
SELECT * FROM users;
SELECT * FROM photos;

SELECT u.id, u.username
FROM users u
LEFT JOIN photos p
ON u.id = p.user_id
WHERE p.image_url IS NULL;

-- 3.Identify the winner of the contest and provide their details to the team 
SELECT * FROM users;
SELECT * FROM photos;
SELECT * FROM likes;

SELECT u.id,u.username,l.photo_id,p.image_url,COUNT(l.user_id) AS cnt_likes
FROM users u
INNER JOIN photos p
ON u.id = p.user_id
INNER JOIN likes l
ON p.id = l.photo_id
GROUP BY u.id,u.username,l.photo_id,p.image_url
ORDER BY cnt_likes DESC
LIMIT 1;

-- 4.Identify and suggest the top 5 most commonly used hashtags on the platform

SELECT t.tag_name,COUNT(p.tag_id) AS cnt_tags
FROM tags t
INNER JOIN photo_tags p
ON t.id = p.tag_id
GROUP BY t.tag_name 
ORDER BY cnt_tags DESC
LIMIT 5;

-- 5.What day of the week do most users register on? Provide insights on when to schedule an AD Campaign
SELECT * FROM users;

SELECT DATE_FORMAT(created_at,'%W') AS Day_name, COUNT(username) AS cnt_users
FROM users
GROUP BY Day_name
ORDER BY cnt_users DESC;

-- 6.Provide how many times does average user posts on Instagram. Also , provide the total number of photos on Instagram /  total no. of users.
SELECT * FROM users,photos;

WITH cte AS(
SELECT u.id AS userid,COUNT(p.id) AS photoid 
FROM users u
LEFT JOIN photos p
ON u.id = p.user_id
GROUP BY userid)
SELECT SUM(photoid) AS Total_Photos, COUNT(userid) AS Total_Users, ROUND(SUM(photoid)/COUNT(userid),2) AS Photos_per_User
FROM cte;

-- 7.Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
SELECT * FROM users,likes;

WITH cte AS(
SELECT u.username,COUNT(l.photo_id) AS cnt_likes
FROM users u 
JOIN likes l 
ON u.id = l.user_id
GROUP BY 1)
SELECT username,cnt_likes 
FROM cte 
WHERE cnt_likes = (SELECT COUNT(*) FROM photos);















