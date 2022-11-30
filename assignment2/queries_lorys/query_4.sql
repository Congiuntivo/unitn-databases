WITH directors_movies AS
         (SELECT d1.director
          from directorawards as d1
                   JOIN movies as d2 ON d1.director = d2.director
          WHERE gross > 1000000
            AND extract('year' FROM current_date) - d2.year <= 5
            AND result = 'won'),
     movies_awards AS
         (SELECT title, m1.director
          from movies as m1
                   JOIN directors_movies as m2 ON m1.director = m2.director)

SELECT DISTINCT award, year, d1.director
FROM directors_movies as d1
         JOIN directorawards as d2
              ON d1.director = d2.director
              WHERE result = 'won'
UNION
SELECT DISTINCT award, year, director
FROM movies_awards as m1
         JOIN movieawards as m2
              ON m1.title = m2.title
WHERE award LIKE '%best director' AND result = 'won';