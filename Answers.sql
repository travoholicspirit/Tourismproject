/* top 10 district with highest visitors*/

SELECT District, sum(Visitors) as Totalvisitors
FROM domestic_visitors
group by District
ORDER BY Totalvisitors DESC
LIMIT 10;

/* top 3 district which has compound annual growth rate */

WITH a AS (
    SELECT district, 
        SUM(IF(year = 2016, visitors, 0)) AS 'Y2016',
        SUM(IF(year = 2017, visitors, 0)) AS 'Y2017',
        SUM(IF(year = 2018, visitors, 0)) AS 'Y2018',
        SUM(IF(year = 2019, visitors, 0)) AS 'Y2019'
    FROM domestic_visitors
    GROUP BY district
)
SELECT 
    a.District,
    a.Y2016,
    a.Y2017,
    a.Y2018,
    a.Y2019,
    round((POWER(a.Y2019/a.Y2016, 1/4)-1)*100,2) AS CAGR
FROM a
order by CAGR desc
limit 3;

/* Bottom 3 districts based on CAGR percentage*/

WITH a AS (
    SELECT district, 
        SUM(IF(year = 2016, visitors, 0)) AS 'Y2016',
        SUM(IF(year = 2017, visitors, 0)) AS 'Y2017',
        SUM(IF(year = 2018, visitors, 0)) AS 'Y2018',
        SUM(IF(year = 2019, visitors, 0)) AS 'Y2019'
    FROM domestic_visitors
    GROUP BY district
)
SELECT 
    a.District,
    a.Y2016,
    a.Y2017,
    a.Y2018,
    a.Y2019,
    round((POWER(a.Y2019/a.Y2016, 1/4)-1)*100,2) AS CAGR
FROM a
where a.y2019 and a.y2016 and a.y2017 and a.y2018 is not null
order by CAGR 
limit 3;

/* Peak season months for Hyderabad from 2016 to 2019 */

 with tt as (
 SELECT Month, 
        SUM(IF(year = 2016, visitors, 0)) AS 'Y2016',
        SUM(IF(year = 2017, visitors, 0)) AS 'Y2017',
        SUM(IF(year = 2018, visitors, 0)) AS 'Y2018',
        SUM(IF(year = 2019, visitors, 0)) AS 'Y2019'
    FROM domestic_visitors
    where district = "hyderabad"
    GROUP BY month )
    select *, tt.y2016+tt.y2017+tt.y2018+tt.y2019 as TotalVisitors
    from tt
    order by totalvisitors desc
    limit 4;
    
/* Low season months for Hyderabad from 2016 to 2019 */

with tt as (
 SELECT month, 
        SUM(IF(year = 2016, visitors, 0)) AS 'Y2016',
        SUM(IF(year = 2017, visitors, 0)) AS 'Y2017',
        SUM(IF(year = 2018, visitors, 0)) AS 'Y2018',
        SUM(IF(year = 2019, visitors, 0)) AS 'Y2019'
    FROM domestic_visitors
    where district = "hyderabad"
    GROUP BY month )
    select *, tt.y2016+tt.y2017+tt.y2018+tt.y2019 as totalvisitors
    from tt
    order by totalvisitors 
    limit 3;
   




