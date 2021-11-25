SELECT
  movies.id,
  movies.title,
  movies.released,
  movies.poster,
  AVG(external_ratings.rating)::numeric(10, 2) AS avg_rating
FROM movies
LEFT JOIN external_ratings ON external_ratings.movie_id = movies.id
GROUP BY movies.id
ORDER BY avg_rating DESC
LIMIT 100
