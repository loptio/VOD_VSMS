實現了規定的查詢
```sql Find the titles of movies stared by “Benedict Cumberbatch” and released between 2005 and 2015.
SELECT m.title 
FROM movies m 
JOIN act_in ai ON m.movie_id = ai.movie_id 
WHERE ai.actor_name = 'Benedict Cumberbatch' 
AND YEAR(m.release_date) BETWEEN 2005 AND 2015 
ORDER BY m.release_date DESC;
```
```sql Find the favorite actress (es) of the member named “John Smith.” (whose movies are downloaded the most)
SELECT 
    ai.actor_name, 
    COUNT(d.download_id) as download_count 
FROM members m 
JOIN download d ON m.member_id = d.member_id 
JOIN act_in ai ON d.movie_id = ai.movie_id 
JOIN actors a ON ai.actor_name = a.actor_name AND ai.birth_date = a.birth_date 
WHERE m.name = 'John Smith' AND a.gender = 'Female' 
GROUP BY ai.actor_name 
ORDER BY download_count DESC 
LIMIT 1;
```
```sql View 10 most frequently downloaded titles for the last year.
SELECT m.title,count(d.download_id) as download_count 
FROM movies m 
JOIN download d ON m.movie_id = d.movie_id 
WHERE YEAR(d.download_timestamp) = 2023 
GROUP BY m.movie_id 
ORDER BY download_count DESC 
LIMIT 10;
```
```sql Find the month in which the sales of horror movies gross the most.
WITH monthly_sales AS ( 
    SELECT 
        YEAR(p.purchase_date) AS year, 
        MONTH(p.purchase_date) AS month, 
        SUM(p.amount) AS total_sales 
    FROM movies m 
    JOIN purchase p ON m.movie_id = p.movie_id 
    LEFT JOIN has_genre h ON m.movie_id = h.movie_id 
    WHERE h.genre_name = 'Horror' 
    GROUP BY year, month 
), 
ranked_sales AS ( 
    SELECT 
        year, 
        month, 
        total_sales, 
        RANK() OVER (PARTITION BY year ORDER BY total_sales DESC) as sales_rank 
    FROM monthly_sales 
) 
SELECT 
    year, 
    month, 
    total_sales 
FROM ranked_sales 
WHERE sales_rank = 1 
ORDER BY total_sales DESC;
```
```sql View10 best customers (in terms of money paid to the company)
SELECT 
    m.name, 
    SUM(p.amount) as total_spent, 
    COUNT(p.purchase_id) as purchase_count 
FROM members m 
JOIN purchase p ON m.member_id = p.member_id 
GROUP BY m.member_id, m.name 
ORDER BY total_spent DESC 
LIMIT 10;
```