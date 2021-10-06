
  create view "dellstore"."public"."luhn__dbt_tmp" as (
    -- CREATE OR REPLACE FUNCTION luhn_verify(int8) RETURNS boolean AS $$
-- -- Take the sum of the
-- -- doubled digits and the even-numbered undoubled digits, and see if
-- -- the sum is evenly divisible by zero.
-- SELECT
--          -- Doubled digits might in turn be two digits. In that case,
--          -- we must add each digit individually rather than adding the
--          -- doubled digit value to the sum. Ie if the original digit was
--          -- `6' the doubled result was `12' and we must add `1+2' to the
--          -- sum rather than `12'.
--          MOD(SUM(doubled_digit / INT8 '10' + doubled_digit % INT8 '10'), 10) = 0
-- FROM
-- -- Double odd-numbered digits (counting left with
-- -- least significant as zero). If the doubled digits end up
-- -- having values
-- -- > 10 (ie they're two digits), add their digits together.
-- (SELECT
--          -- Extract digit `n' counting left from least significant
--          -- as zero
--          MOD( ( $1::int8 / (10^n)::int8 ), 10::int8)
--          -- Double odd-numbered digits
--          * (MOD(n,2) + 1)
--          AS doubled_digit
--          FROM generate_series(0, floor(log( $1 ))::integer) AS n
-- ) AS doubled_digits;

-- $$ LANGUAGE sql
-- IMMUTABLE
-- STRICT;



SELECT 
SUM(ord.totalamount) as lostamount,
ord.orderdate as date
FROM
(SELECT totalamount, customerid, orderdate FROM "dellstore"."public"."orders" ) ord
JOIN
(SELECT customerid, creditcard FROM "dellstore"."public"."customers" 
)cust
ON ord.customerid = cust.customerid
WHERE luhn_verify(cust.creditcard::int8) = FALSE
GROUP BY date
ORDER BY date
  );
