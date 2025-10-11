# trash-wheel-analysis

**A [data pipeline](https://bchaoss.github.io/trash-wheel-analysis/pipeline/#!/overview) & [dashboard](https://bchaoss.github.io/trash-wheel-analysis/evidence_bi/) for analyzing trash wheel collection data.**

Data Source: [Trash Wheel: Semi-autonomous trash interceptors in Baltimore Harbor](https://www.mrtrashwheel.com/)

<img width="1842" height="370" alt="diagram-export-10-9-2025-4_17_41-AM-overlay" src="https://github.com/user-attachments/assets/7a1dab3a-9baa-463b-885f-11acc5236c4e" />

<img width="496" height="244" alt="image" src="https://github.com/user-attachments/assets/e00103fc-3115-4e1e-b6a2-95c37d0c97eb" />

[![DBT](https://img.shields.io/badge/DBT-orange?style=for-the-badge&logo=dbt)](https://www.getdbt.com/)
[![DuckDB](https://img.shields.io/badge/DuckDB-yellow?style=for-the-badge&logo=duckdb)](https://duckdb.org/)
[![MotherDuck](https://img.shields.io/badge/MotherDuck-green?style=for-the-badge&logo=motherduck)](https://www.motherduck.com/)
[![Evidence](https://img.shields.io/badge/evidence-grey?style=for-the-badge&logo=evidence)](https://github.com/evidence-dev/evidence)


### Data Stack

| Stack | Purpose (Modern & Open-source) |
| :--- | :--- |
| [dbt](https://www.getdbt.com/) | Generate data transformation pipeline (models, documentation, and tests) in SQL |
| [DuckDB](https://duckdb.org/) | Analytical database engine |
| [MotherDuck](https://www.motherduck.com/) | Cloud deployment for DuckDB (free plan available) |
| [Evidence](https://github.com/evidence-dev/evidence?tab=readme-ov-file) | BI tool using SQL and Markdown |
| [Github Action](https://docs.github.com/en/actions/get-started/understand-github-actions) | CI/CD (to run pipeline, deploy docs to [GitHub Page](https://docs.github.com/en/pages/getting-started-with-github-pages/configuring-a-publishing-source-for-your-github-pages-site)) |


### Structure
<pre>
.
├── dbt_pipeline/
│   ├── macros/
│   ├── models/
│   │   ├── ingest/
│   │   ├── staging/
│   │   └── marts/
│   ├── seeds/
│   ├── dbt_project.yml
│   └── profiles.yml
│
├── evidence_BI/
│   ├── pages/
│   ├── sources/
│   ├── build/
│   ├── evidence.config.yaml
│   ├── package.json
│   └── etc.
│
├── .devcontainer/
├── .github/workflows
└── requirements.txt
</pre>


### Data model, DAG and Document

**[dbt docs](https://bchaoss.github.io/trash-wheel-analysis/pipeline/#!/overview)** : shows SQL models info and structure.

<img width="2434" height="249" alt="dbt-dag (1)" src="https://github.com/user-attachments/assets/f504ca42-e8cb-4cb3-b199-eb71af7d85c8" />

0. Seeds
   
   Static CSV file `trash_wheel_info`: Stores wheel names and assosiated Google Sheet IDs

   Data source: Google Sheet Link (contain 4 sheets each for a trash wheel).
   
2. Ingest Layer
   
   seed: `trash_wheel_info` -> stg: `config_trash_wheel` (for downstream extraction process)
   
   Source google sheet by `get_csv` -> `ingest_trash_wheel` (raw, untransformed data)
   
3. Staging Layer (Transformation)
   
   `ingest_trash_wheel` ->
   
     -> `stg_trash_format` (renames columns, formats date fields and join wheel info)
     
     -> `stg_trash_unique` (creates clean and unique primary key of each dumpster by wheel)
     
     -> `stg_trash_type` (data type casting)
   
5. Marts Layer

   Fact Table:
   
     `stg_trash_type` -> `fact_trash_collection`
   
   Dimension Table:
   
     `config_trash_wheel` -> `dim_trash_wheel`

<br>

<br>

###  Get start

0\. Clone the Repo

1\. Create MotherDuck account and set environment variable `MOTHERDUCK_TOKEN`

2\. Setup Environment

Use Github Codespace setup by `.devcontainer.json`, OR in local machine: Python + Node.js

| Environment | Dependencies |
| :--- | :--- |
| Python 3 | `pip install -r requirements.txt` | 
| Node.js | `cd evidence_bi/ && npm install` |

3\. Run the dbt Pipeline

```bash
cd dbt_pipeline/

dbt debug  # Verify connection

dbt build  # Run the full pipeline (ingest -> staging -> mart) and tests
```

3\. Build the dashboard by Evidence

Define motherduck connection in `sources/connection.yaml`;

Edit dashboard in  `pages/index.md`;

```
cd evidence_bi/

echo "EVIDENCE_SOURCE__trash_wheel__token=${MOTHERDUCK_TOKEN}" > .env

npm run sources

npm run build
```

<br>

### TBD:
- [x] test and build dbt
- [x] mart analysis table
- [ ] incremental (ingest or refresh)
- [x] github action
- [x] dashboard deploy
- [ ] analysis and generate insight (TODO)

### Reference:
- [TidyTuesday data on 2024-03-05](https://github.com/rfordatascience/tidytuesday/blob/main/data/2024/2024-03-05/readme.md)
- [How the Trash Wheel works](https://www.mrtrashwheel.com/how-it-works)
- [Baltimore Healthy Harbor](https://www.waterfrontpartnership.org/healthy-harbor-initiative)
