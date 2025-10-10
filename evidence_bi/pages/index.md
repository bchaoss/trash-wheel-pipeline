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
  sum(weight) as "Weight (ton)",
  sum(volume) as "Volume (cubic yard)"
from trash_collection_monthly
group by 1
order by 1 desc
limit 6
```

## Know the Trach Wheel Family
> "**Baltimore's [Mr. Trash Wheel Family](https://www.mrtrashwheel.com/trash-wheel-family) is made up of four devices, each protecting one corner of the harbor**: Mr. Trash Wheel (2014), Professor Trash Wheel (2016), Captain Trash Wheel (2018), and Gwynnda the Good Wheel of the West (2021)."

<AreaChart 
	data={monthly_by_wheel}
	x="Month"
	y="weight"
  series=trash_wheel
/>

```sql monthly_by_wheel
select date as Month
  , wheel_name as trash_wheel
  , sum(weight) as weight
  , sum(volume) as volume
from trash_collection_monthly
group by all
order by 1 desc
```

Comparison by Wheel, After all 4 wheels started working:
<Grid cols=2>
<ECharts config={
    {
        title: {
          text: 'Percentage % by Wheel (Weight)',
          left: 'center'
        },        
        tooltip: {
            formatter: '{b}: {c} ({d}%)'
        },
        series: [
        {
          type: 'pie',
          data: [...pie_data],
        }
      ]
      }
    }
/>

<DataTable data={monthly_info_by_wheel} totalRow=true>
	<Column id=trash_wheel totalAgg="All"/>
  <Column id=num_of_dumpster_monthly title="# Dumpster"/>
	<Column id=average_weight_per_dumpster title="Avg. Weight per Dumpster" contentType=colorscale colorScale=info totalAgg=mean/>
  <Column id=homes_powered_monthly contentType=bar/>
</DataTable>
</Grid>

```sql mature_data_by_wheel
select
  wheel_name as trash_wheel
  , count(distinct date) as cnt_month
  , round(sum(weight)) as weight
  , sum(num_dumpster) as num_of_dumpster
  , sum(weight) / sum(num_dumpster) as average_weight_per_dumpster
  , sum(homes_powered) as homes_powered
from trash_collection_monthly
where date >= '2021-07-01'
group by all
```

```sql monthly_info_by_wheel
select
  trash_wheel
  , cnt_month
  , weight / cnt_month as weight_monthly
  , num_of_dumpster / cnt_month as num_of_dumpster_monthly
  , average_weight_per_dumpster
  , homes_powered / cnt_month as homes_powered_monthly
from ${mature_data_by_wheel}
```

```sql pie_data
select 
  trash_wheel as name
  , weight as value
from ${mature_data_by_wheel}
group by all
```

### Trash Collection by Wheels in Latest Month

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


## What kind of Trash Is Collected ?

in 2025

<!-- <DateRange
    name=year_range
    data={year_list}
    dates=year
/>

From {inputs.year_range.start} to {inputs.year_range.end} -->

<DataTable data={num_category_25} totalRow=true>
	<Column id=wheel_name totalAgg="Total"/>
  <Column id=plastic_bottles contentType=bar/>
  <Column id=polystyrene contentType=bar/>
  <Column id=cigarette_butts contentType=bar/>
  <Column id=glass_bottles contentType=bar/>
  <Column id=plastic_bags contentType=bar/>
  <Column id=wrappers contentType=bar/>
  <Column id=sports_balls contentType=bar/>
</DataTable>

```sql num_of_trash
select year,
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

```sql num_category
SELECT 
  year
  , wheel_name
  , category
  , round(num) as num
FROM ${num_of_trash}
UNPIVOT (
  num FOR category IN (plastic_bottles, polystyrene, cigarette_butts, glass_bottles, plastic_bags, wrappers, sports_balls)
)
where wheel_name = '${inputs.trash_wheel_picker}'
order by year
```

By wheel:
<ButtonGroup 
    data={wheel_list} 
    name=trash_wheel_picker 
    value=wheel_name
    defaultValue="Mister"
/>
The {inputs.trash_wheel_picker} Trash Wheel

<Heatmap  
    data={num_category}
    x=year
    y=category
    value=num
    xSort=year
    legend=true
    filter=true
    emptySet=pass
    valueFmt='#,##0,"k"'
    connectGroup=wheel
/>

```sql wheel_list
select
  wheel_name
from trash_collection_monthly
where date = '2025-06-01'
group by all
```

```sql year_list
select
  -- (year::int || '-01-01')::date as year
  year
from trash_collection_monthly
group by all
```

<!-- <LineChart
	data={num_category}
	x=year
	y=num
  series=category
  order=year
/> -->

```sql num_category_25
select *
from ${num_of_trash}
where year = 2025
  -- year >= ${inputs.year_range.start}
  -- and year <= ${inputs.year_range.end}
```

