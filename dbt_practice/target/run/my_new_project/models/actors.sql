
  create view "dellstore"."public"."actors__dbt_tmp" as (
    -- dbt 
SELECT nested.first_name, nested.movie_number, nested.movie_prices FROM (
SELECT actor, SUBSTRING(actor, 1, POSITION(' ' in actor)) as first_name, 
actor, COUNT(*) as movie_number,
actor, SUM(price) as movie_prices
FROM "dellstore"."public"."products" 
GROUP BY actor
) nested

ORDER BY movie_prices DESC
  );
