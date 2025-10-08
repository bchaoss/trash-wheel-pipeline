{% set cols_to_sum = [
    'weight',
    'volume',
    'plastic_bottles',
    'polystyrene',
    'cigarette_butts',
    'glass_bottles',
    'plastic_bags',
    'wrappers',
    'sports_balls',
    'homes_powered'
] %}


select 
  b.trash_wheel_name as wheel_name
  , a.*
from (
  select
    wheel_id
    , year
    , month
    , case when month in (12, 1, 2) then 'Winter'
           when month in (3, 4, 5) then 'Spring'
           when month in (6, 7, 8) then 'Summer'
           when month in (9, 10, 11) then 'Fall'
      end as season
    , count(dumpster_id) as num_dumpster
    
    {% for col in cols_to_sum %}
    , sum({{ col }}) as {{ col }}
    {% endfor %}
    
  from {{ ref('fact_trash_collection') }}
  group by 1, 2, 3, 4
) a
left join {{ ref('dim_trash_wheel') }} b 
  on a.wheel_id = b.wheel_id
