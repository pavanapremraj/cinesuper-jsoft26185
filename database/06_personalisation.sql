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
select * from movie_ratings order by avg_rating desc nulls last;-- 12.1: 5 പുതിയ സിനിമകൾ ചേർക്കുന്നു (Horror/Romance ഉൾപ്പെടെ)
INSERT INTO genres (name) VALUES ('Horror'), ('Romance') ON CONFLICT DO NOTHING;

INSERT INTO movies (title, release_year, language, duration_min, description, poster_url, genre_id)
VALUES 
('Kantara', 2022, 'Kannada', 148, 'A fiery young man clashes with an upright forest officer.', 'https://via.placeholder.com/300x450', 3),
('Premalu', 2024, 'Malayalam', 156, 'A romantic comedy centered around Sachin and Reenu.', 'https://via.placeholder.com/300x450', 5),
('Bramayugam', 2024, 'Malayalam', 139, 'A sacred singer escapes slavery and lands in a mysterious mansion.', 'https://via.placeholder.com/300x450', 4),
('Tumbbad', 2018, 'Hindi', 104, 'A mythological horror about a family who builds a shrine for Hastar.', 'https://via.placeholder.com/300x450', 4),
('Hridayam', 2022, 'Malayalam', 172, 'The emotional journey of Arun Neelakandan through college and life.', 'https://via.placeholder.com/300x450', 5);

-- 12.2: പുതിയ കോളം (director) ചേർക്കുന്നു
ALTER TABLE movies ADD COLUMN director TEXT;

UPDATE movies SET director = 'Jeethu Joseph' WHERE title = 'Drishyam';
UPDATE movies SET director = 'Christopher Nolan' WHERE title IN ('Inception', 'Interstellar', 'Oppenheimer');
UPDATE movies SET director = 'Chidambaram' WHERE title = 'Manjummel Boys';