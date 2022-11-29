WITH max_oscar AS
         (SELECT count(award) as c
          from movieawards
          WHERE award LIKE 'Oscar%'
            AND result = 'won'
          GROUP BY title, year
          ORDER BY 1 DESC
          LIMIT 1)

SELECT title, year
from movieawards
WHERE award LIKE 'Oscar%'
  AND result = 'won'
GROUP BY title, year
HAVING count(award) = (SELECT c from max_oscar);