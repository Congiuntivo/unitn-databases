WITH
    anni_80 AS
        (
            SELECT DISTINCT *
            FROM movieawards
            WHERE movieawards.year >= 1980 AND movieawards.year < 1990
        ),
    vinti_80 AS
        (
            SELECT COUNT(*)
            FROM anni_80
            WHERE anni_80.award LIKE 'Oscar%' AND anni_80.result = 'won'
        )
SELECT DISTINCT
    CASE
        WHEN COUNT(*) = 0 THEN -1
        ELSE ROUND(ROUND((SELECT * FROM vinti_80),2)/COUNT(*),2)
    END AS feature
FROM anni_80
ORDER BY feature;