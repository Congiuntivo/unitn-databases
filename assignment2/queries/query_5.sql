WITH
    nomine AS
        (
            SELECT title, year, COUNT(movieawards.title) as nominated FROM movieawards WHERE movieawards.result = 'nominated' GROUP BY title, year
        ),
    vincite AS
        (
            SELECT title, year, COUNT(movieawards.title) as won FROM movieawards WHERE movieawards.result = 'won' GROUP BY title, year
        )
SELECT DISTINCT movies.title, movies.year,
       CASE
        WHEN won IS NOT NULL AND nominated IS NOT NULL THEN ROUND(ROUND(won,2)/(ROUND(won,2)+ROUND(nominated,2)),2)
        WHEN won IS NULL AND nominated IS NULL THEN -1
        WHEN won IS NULL AND nominated IS NOT NULL THEN 0.00
        WHEN won IS NOT NULL AND nominated IS NULL THEN 1.00
        END AS success_rate
FROM movies
    LEFT JOIN nomine ON movies.title = nomine.title AND movies.year = nomine.year
    LEFT JOIN vincite ON movies.title = vincite.title AND movies.year = vincite.year
ORDER BY movies.title, movies.year, success_rate;