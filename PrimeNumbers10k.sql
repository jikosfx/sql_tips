WITH n as (
SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) n
		FROM (SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)) ones, 
				(SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)) tens,
				(SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)) hund,
				(SELECT n FROM (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) v(n)) thous)

SELECT R.[Integer] AS PrimeNumber
FROM (
    SELECT T1.n AS [Integer],
           T2.n AS Divider,
           T1.n % T2.n AS Remainder
    FROM n AS T1
         INNER JOIN n AS T2 ON T1.n >= T2.n) R
GROUP BY R.[Integer]
HAVING COUNT(CASE WHEN R.Remainder = 0 THEN 1 END) <= 2
