WITH
    awards_anni_80 AS
        (
            SELECT DISTINCT *
            FROM movieawards
            WHERE movieawards.year >= 1980 AND movieawards.year < 1990
        ),
    vinti_80 AS
        (
            SELECT DISTINCT title, year
            FROM awards_anni_80
            WHERE awards_anni_80.award LIKE 'Oscar%'
            AND awards_anni_80.result = 'won'
        ),
    num_80 AS
        (
            SELECT COUNT(*)
            FROM movies
            WHERE year >= 1980 AND year < 1990
        )
SELECT DISTINCT
    CASE
        WHEN COUNT(*) = 0 THEN -1
        ELSE ROUND(ROUND((SELECT COUNT(*) FROM vinti_80),2)/(SELECT * FROM num_80),2)
    END AS feature
FROM awards_anni_80
ORDER BY feature;