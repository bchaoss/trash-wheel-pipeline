SELECT
  wheel_id
  , wheel_name
  , full_name
FROM
  {{ ref('config_trash_wheel') }}
