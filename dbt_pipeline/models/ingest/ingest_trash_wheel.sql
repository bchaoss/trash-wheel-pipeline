SELECT
  * EXCLUDE (column12, column13, column14, column15)
  , current_timestamp AS load_time
FROM
  read_csv_auto(
    {{ get_csv_list() }}
    , skip = 1
    , normalize_names = true
    , union_by_name = true
    , filename = true
  )
where Dumpster is not null

