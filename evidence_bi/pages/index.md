---
title: Dashboard - Trash Wheels' Collection
---

```sql latest_month
select 
  max(date) as month
  , max(load_time) as load_time
from trash_collection_monthly
```

## How Many Trash Collected by the Trash Wheels ?

(Latest active month of trash wheel is <Value
    data={latest_month}
    value="month"
/>; Data last updated on <Value
    data={latest_month}
    value="load_time"
/>)

```sql latest_month_sum
select 
  sum(weight) as weight
  , sum(volume) as volume
from trash_collection_monthly
where date >= (select month from ${latest_month} )
```

```sql total_sum
select 
  sum(weight) as weight
  , sum(volume) as volume
from trash_collection_monthly
```


<BigValue
    title="Latest month weight"
    data={latest_month_sum}
    value="weight"
/>

<BigValue
    title="Latest month volume"
    data={latest_month_sum}
    value="volume"
/>

<BigValue
    title="Total weight"
    data={total_sum}
    value="weight"
/>

<BigValue
    title="Total volume"
    data={total_sum}
    value="volume"
/>


## Trash Collection Over Months
<Grid cols=2>
<LineChart
	data={monthly_data}
	x="Month"
	y="weight"
  y2="volume" 
/>

<DataTable 
	data={latest_6month_data}
  limit=6
/>
</Grid>

```sql monthly_data
select date as Month,
  sum(weight) as weight,
  sum(volume) as volume
from trash_collection_monthly
group by 1
order by 1 desc
```

```sql latest_6month_data
select date as Month,
  sum(weight) as weight,
  sum(volume) as volume
from trash_collection_monthly
group by 1
order by 1 desc
limit 6
```

## Trash Collection by Wheels in Latest Month

<Grid cols=2>
<BarChart
  data={by_wheel_this_month}
	x="wheel_name"
	y="weight"
  order="weight desc"
/>

<BarChart
	data={by_wheel_this_month}
	x="wheel_name"
	y="volume"
  order="volume desc"
/>
</Grid>

```sql by_wheel_this_month
select wheel_name,
  sum(weight) as weight,
  sum(volume) as volume
from trash_collection_monthly
where date >= (select month from ${latest_month} )
group by 1
order by 1 desc
```

## Is there any seasonal pattern of Trash Collection ?..

```sql sesonal_by_year
select 
  year
  , season
  , sum(weight) as weight
  -- , sum(volume) as volume
from trash_collection_monthly
group by 1, 2
order by 1, 2
```

<LineChart
	data={sesonal_by_year}
	x="season"
	y="weight"
  series="year"
  order="year"
/>

## Know the Trach Wheel Family

> "Baltimore's [Mr. Trash Wheel Family](https://www.mrtrashwheel.com/trash-wheel-family) is made up of four devices: Mr. Trash Wheel (2014), Professor Trash Wheel (2016), Captain Trash Wheel (2018), and Gwynnda the Good Wheel of the West (2021)."

<Grid cols=2>
<AreaChart 
	data={monthly_by_wheel}
	x="Month"
	y="weight"
  series=trash_wheel
/>

<!-- <DataTable 
	data={latest_6month_data}
  limit=6
/> -->
</Grid>

```sql monthly_by_wheel
select date as Month
  , wheel_name as trash_wheel
  , sum(weight) as sum_weight
  , sum(volume) as sum_volume
from trash_collection_monthly
group by all
order by 1 desc
```

## What kind of Trash Is Collected ?
```sql num_by_category
select date as Month,
  wheel_name,
  sum(plastic_bottles) as plastic_bottles,
  sum(polystyrene) as polystyrene,
  sum(cigarette_butts) as cigarette_butts,
  sum(glass_bottles) as glass_bottles,
  sum(plastic_bags) as plastic_bags,
  sum(wrappers) as wrappers,
  sum(sports_balls) as sports_balls
from trash_collection_monthly
group by all
```
