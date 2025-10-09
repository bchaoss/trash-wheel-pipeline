---
title: Dashboard - Trash Wheels' Collection
---

```sql lastest_month
select 
  max(date) as month
  , max(load_time) as load_time
from trash_collection_monthly
```

## How Many Trash Collected by the Trash Wheel ?

(Data last updated on <Value
    data={lastest_month}
    value="load_time"
/>; Latest active month of trash wheel is <Value
    data={lastest_month}
    value="month"
/>)

```sql last_month_sum
select 
  sum(weight) as weight
  , sum(volume) as volume
from trash_collection_monthly
where date >= (select month from ${lastest_month} )
```

```sql total_sum
select 
  sum(weight) as weight
  , sum(volume) as volume
from trash_collection_monthly
```


<BigValue
    title="Latest month weight"
    data={last_month_sum}
    value="weight"
/>


<BigValue
    title="Latest month volume"
    data={last_month_sum}
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

## Trash Collection by Wheels in Lastest Month

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
where date >= (select month from ${lastest_month} )
group by 1
order by 1 desc
```

## Is there any pattern of Trash Collection?

```sql monthly_by_year
select 
  year
  , season
  , sum(weight) as weight
  , sum(volume) as volume
from trash_collection_monthly
group by 1, 2
order by 1, 2
```

<LineChart
	data={monthly_by_year}
	x="season"
	y="weight"
  series="year"
  order="year"
/>

