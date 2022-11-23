WITH
    n_oscar AS
        (
            SELECT movieawards.title, movieawards.year, COUNT(*) AS num
            FROM movieawards
            WHERE movieawards.award LIKE 'Oscar%' AND movieawards.result = 'won'
            GROUP BY movieawards.title, movieawards.year
        )
SELECT DISTINCT title, year
FROM n_oscar
WHERE num = (SELECT MAX(num) FROM n_oscar)
ORDER BY title, year;