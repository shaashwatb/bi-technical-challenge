# BI Technical Challenge

## Overview
This project answers the BI technical challenge using dbt + DuckDB .  
Tranformation models have been implemented in SQL with a layered structure (staging → intermediate → marts).  

---

## Tech Stack
- Database: DuckDB 
- Transformation: dbt Core with DuckDB adapter
- Language: SQL
- Environment: Python virtual environment
- Version control: Git / GitHub

---

## Modeling Approach

### Staging
- Changing column names and data types
- Structured into:
  - staging/raw: raw CSV-backed views
  - staging/stg: staging models

### Intermediate
- Models after joining stg models

### Marts
- One model per business question and optional bonus analyses

### Use of Python
- Python has not been used in this challenge, however in real life scenario, we could use python to extract the data from backend and hubspot OR we can use python to create visualizations from the exported data. 
---

## Data Exports
Final mart outputs are exported as CSV files for external visualization.  
Exports are generated from the DuckDB database after dbt builds all models and are used for charts in an external tool.

---

# Business Questions – Answers & Insights

This section summarizes the results for each question, and the key assumptions made.

---

## Q1. How many customers do we have today?

**Answer:** **26 customers**

**Definition assumed**  
A customer is defined as a company with at least one closed-won deal.

---

## Q2. What is our ACV?

**Answer:** **12,967.74**

**Definition assumed**  
ACV is calculated as the **average deal amount of closed-won deals**.

---

## Q3. What is our user retention?

**Assumptions**
- Users are identified via `user_id` from backend events.
- A user’s cohort date is their first recorded activity date.
- A user is considered active if they generate any backend event on a given day.
- Backend events are used as product usage.

**Answer:**
- **7 day Retention:**  - **64%**
- **30 day Retention:** - **56%**

---

## Bonus 1. Product usage funnel (events)

**Goal**  
Identify where users drop off in the product usage journey.

**Funnel steps**
1. Search Created / Updated
2. Search Executed
3. Result Appraised
4. Full Text Viewed
5. Results Exported

**Key insight**
- Minimal drop-off until export.
- Largest drop occurs before exporting results, indicating the strongest value or monetization threshold.

---

## Bonus 2. Sales funnel (deals)

**Goal**  
Identify bottlenecks in the sales process.

**Assumptions**
- Deals are tracked through pipeline stages using stage entry timestamps.
- Funnel shows how many deals ever reached each stage.
- Drop-off rates are calculated between stages.

**Key insight**
- The main bottleneck is the final step: deal conversion drops sharply at Contract Negotiation → Closed Won.
- The rest of the funnel is relatively healthy: once deals reach Product Testing, drop-offs remain low 

---

## Dashboard
![alt text](image.png)