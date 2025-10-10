# trash-wheel-analysis

**A [data pipeline](https://bchaoss.github.io/trash-wheel-analysis/pipeline/#!/overview) & [dashboard](https://bchaoss.github.io/trash-wheel-analysis/evidence_bi/) for analyzing trash wheel collection data.**

Data Source: [Trash Wheel: Semi-autonomous trash interceptors in Baltimore Harbor](https://www.mrtrashwheel.com/)

<img width="1842" height="370" alt="diagram-export-10-9-2025-4_17_41-AM-overlay" src="https://github.com/user-attachments/assets/7a1dab3a-9baa-463b-885f-11acc5236c4e" />

<img width="496" height="244" alt="image" src="https://github.com/user-attachments/assets/e00103fc-3115-4e1e-b6a2-95c37d0c97eb" />


<!-- <br> -->

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
│   │   └── mart/
│   ├── seeds/
│   ├── dbt_project.yml
│   └── profiles.yml
│
├── evidence_BI/
│   ├── pages/
│   ├── sources/
│   └── etc.
│
├── .devcontainer/
├── .github/workflows
└── requirements.txt
</pre>

### Docs & DAG

**[dbt docs](https://bchaoss.github.io/trash-wheel-analysis/pipeline/#!/overview)** : shows SQL models info and structure.

<!-- <img width="2355" height="431" alt="dbt-dag" src="https://github.com/user-attachments/assets/0c0a2468-effd-4a65-97bf-c6aa5184b632" /> -->

<img width="2434" height="249" alt="dbt-dag (1)" src="https://github.com/user-attachments/assets/f504ca42-e8cb-4cb3-b199-eb71af7d85c8" />

<br>
<br>


###  Get start

0\. Clone the Repo

1\. Create MotherDuck account and set environment variable `MOTHERDUCK_TOKEN`

2\. Setup Environment

| Option | Notes |
| :--- | :--- |
| **Local Machine** | Python 3 and `pip install -r requirements.txt` | 
| **Github Codespace** | Uses the `.devcontainer` to set up |

3\. Run the dbt Pipeline

```bash
cd dbt_pipeline

dbt debug  # Verify connection

dbt build  # Run the full pipeline (ingest -> staging -> mart) and tests
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
