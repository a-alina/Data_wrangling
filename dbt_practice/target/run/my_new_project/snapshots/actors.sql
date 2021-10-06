
      update "dellstore"."public"."actors_snapshot"
    set dbt_valid_to = DBT_INTERNAL_SOURCE.dbt_valid_to
    from "actors_snapshot__dbt_tmp160336427247" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_scd_id::text = "dellstore"."public"."actors_snapshot".dbt_scd_id::text
      and DBT_INTERNAL_SOURCE.dbt_change_type::text in ('update'::text, 'delete'::text)
      and "dellstore"."public"."actors_snapshot".dbt_valid_to is null;

    insert into "dellstore"."public"."actors_snapshot" ("first_name", "movie_number", "movie_prices", "dbt_updated_at", "dbt_valid_from", "dbt_valid_to", "dbt_scd_id")
    select DBT_INTERNAL_SOURCE."first_name",DBT_INTERNAL_SOURCE."movie_number",DBT_INTERNAL_SOURCE."movie_prices",DBT_INTERNAL_SOURCE."dbt_updated_at",DBT_INTERNAL_SOURCE."dbt_valid_from",DBT_INTERNAL_SOURCE."dbt_valid_to",DBT_INTERNAL_SOURCE."dbt_scd_id"
    from "actors_snapshot__dbt_tmp160336427247" as DBT_INTERNAL_SOURCE
    where DBT_INTERNAL_SOURCE.dbt_change_type::text = 'insert'::text;

  