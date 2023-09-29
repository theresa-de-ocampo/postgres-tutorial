@set payments_parquet = 'C:\Users\Theresa\Documents\Wakuli\Sprints\2023\18\5 - First Product Inflow\Payments Orders Ingestion\Inputs\my-data.parquet'

SELECT
  *
FROM
  read_parquet(${payments_parquet});