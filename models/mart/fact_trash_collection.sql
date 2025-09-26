SELECT
  dumpster_id
  , wheel_id
  , date
  , year(date) AS month
  , month(date) AS month
  , weight
  , volume
  , plastic_bottles
  , polystyrene
  , cigarette_butts
  , glass_bottles
  , plastic_bags
  , wrappers
  , sports_balls
  , homes_powered
FROM 
  {{ ref('stg_trash_clean') }}
