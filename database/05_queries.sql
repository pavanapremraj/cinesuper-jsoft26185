 -- SCRIPT 4: VIEW FOR AVERAGE RATINGS

create view movie_ratings
with (security_invoker = on) as
select
  m.id,
  m.title,
  round(avg(r.rating), 1) as avg_rating,
  count(r.id)             as review_count
from movies m
left join reviews r on r.movie_id = m.id
group by m.id, m.title;

grant select on movie_ratings to anon, authenticated;

-- test it
select * from movie_ratings order by avg_rating desc nulls last;-- Part B Queries

-- 1. All reviews with the movie title (JOIN)
SELECT reviews.*, movies.title 
FROM reviews 
JOIN movies ON reviews.movie_id = movies.id;

-- 2. Number of movies per language
SELECT language, COUNT(*) AS total_movies 
FROM movies 
GROUP BY language;

-- 3. The newest movie in the database
SELECT * 
FROM movies 
ORDER BY release_date DESC 
LIMIT 1;

-- 4. Movies whose title starts with M (LIKE)
SELECT * 
FROM movies 
WHERE title LIKE 'M%';

-- 5. Delete one review
DELETE FROM reviews 
WHERE id = 1;