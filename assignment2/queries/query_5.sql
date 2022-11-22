WITH
    nomine AS
        (
            SELECT title, year, COUNT(movieawards.title) as nominated FROM movieawards WHERE movieawards.result = 'nominated' GROUP BY title, year
        ),
    vincite AS
        (
            SELECT title, year, COUNT(movieawards.title) as won FROM movieawards WHERE movieawards.result = 'won' GROUP BY title, year
        )
SELECT movies.title, movies.year, COALESCE(ROUND(ROUND(COALESCE(won, 0),2)/nominated,2), -1) AS succes_rate
FROM movies
    LEFT JOIN nomine ON movies.title = nomine.title AND movies.year = nomine.year
    LEFT JOIN vincite ON movies.title = vincite.title AND movies.year = vincite.year
ORDER BY movies.title, movies.year, succes_rate;