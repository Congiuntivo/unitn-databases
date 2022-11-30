WITH won_awards AS
         (SELECT m.title, m.year, count(award) as c1
          FROM movies m
                   LEFT JOIN movieawards m1 on m.title = m1.title AND m.year = m1.year
          WHERE result = 'won'
            AND award NOTNULL
          GROUP BY m.title, m.year),
     all_awards AS
         (SELECT m.title, m.year, count(award) as c2
          FROM movies m
                   LEFT JOIN movieawards m1 on m.title = m1.title AND m.year = m1.year
          WHERE award NOTNULL
          GROUP BY m.title, m.year),
     null_awards AS
         (SELECT m.title, m.year, -1 as c3
          FROM movies m
                   LEFT JOIN movieawards m1 on m.title = m1.title AND m.year = m1.year
          WHERE award ISNULL
          GROUP BY m.title, m.year)

SELECT w2.title, w2.year, COALESCE(round((c1 / c2::numeric), 2),-1) as success_rate
FROM won_awards w1
         RIGHT JOIN all_awards w2 ON w2.title = w1.title AND w2.year = w1.year
UNION ALL
SELECT TITLE, YEAR, c3
FROM null_awards;