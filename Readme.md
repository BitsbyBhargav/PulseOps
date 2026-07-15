# PulseOps: Predictive Maintenance Engine
### Industrial Telemetry Analytics & Failure Prediction System

![Python](https://img.shields.io/badge/Python-3.8+-3776AB?style=flat&logo=python&logoColor=white)
![Random Forest](https://img.shields.io/badge/Random%20Forest-ML%20Model-008080?style=flat)
![SQL Server](https://img.shields.io/badge/MS%20SQL%20Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=flat&logo=powerbi&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-2ECC71?style=flat)

---

## Overview

PulseOps is an end-to-end industrial internet-of-things (IIoT) analytics and predictive maintenance application designed to anticipate machinery failure before it occurs. The system pairs a high-performance Random Forest classification model with an interactive, enterprise-grade Power BI business intelligence portal. By processing multi-variable telemetry data, PulseOps enables operations managers and floor engineers to transition from reactive downtime management to proactive, scheduled maintenance protocols.

---

## Business Problem

Industrial manufacturing lines operate heavy machinery under extreme thermal and physical stress. Unexpected mechanical breakdowns lead to:
- Severe and costly operational downtime
- Elevated emergency repair expenditures and logistics bottlenecks
- Safety hazards stemming from catastrophic component failure
- High scrap rates and inventory loss during sudden mid-cycle stoppages

**Current state:** Facility maintenance is schedule-based or purely reactive, resulting in unnecessary expenditures or sudden breakdowns.
**Solution:** A predictive risk-scoring engine flagging high-risk machinery 24–48 hours before failure occurs, paired with a live tracking dashboard for floor technicians.

---

## Project Structure

```
PULSEOPS/
├── Assets/
│   ├── risk_score_distribution.png # Model failure distribution visualization
│   ├── sensor_vs_failure.png       # Telemetry correlation breakdown
│   ├── System Architecture.png     # End-to-end operational pipeline diagram
│   └── temp_differential.png       # Thermal anomaly scaling plot
├── Dashboard/
│   └── pulseops_enriched.pbix      # 4-page Power BI executive application
├── DATA/
│   ├── Processed/
│   │   ├── pulseops_enriched_with_ml.csv # Telemetry unified with model probabilities
│   │   └── pulseops_enriched.csv         # Feature-engineered telemetry base
│   ├── Raw/                       # Sourced raw factory input logs
│   └── Synthetic/
│       └── pulseops_rf_model.joblib      # Trained Random Forest classifier artifact
├── Docs/
│   ├── DATA_DICTIONARY.md          # Database schema and field metrics documentation
│   ├── INSIGHTS.md                 # Strategic findings and process observations
│   ├── PROJECT_BREIF.md            # System roadmap, KPIs, and operational scope
│   └── PROJECT_LOGBOOK.md          # Chronological engineering execution logs
├── Notebooks/
│   ├── _data_inspection.ipynb     # Initial dataset profile and shape audits
│   ├── _eda_analysis.ipynb        # Statistical distributions and outlier extraction
│   ├── _feature_engineering.ipynb # Risk indexing, boundaries, and metric flags logic
│   ├── _ml_model.ipynb            # Random Forest pipeline optimization and training
│   ├── _sql_connection.ipynb      # Database connection layers and upload procedures
│   └── data.ipynb                 # Unified asset dataframe compilation notebook
├── SQL/
│   ├── Pulse Ops Database.sql     # Database structural definitions and table schemas
│   └── sql_analysis.sql           # Anomaly queries, rolling metrics, and risk extractions
├── .gitignore
├── LICENSE
└── Readme.md
```

---

## System Architecture

```
Raw Machine Telemetry (Torque, RPM, Tool Wear)
                     │
                     ▼
          Python Processing Layer
    Pandas · NumPy · Matplotlib · Seaborn
     (Cleaning, Outliers, Engineering)
                     │
                     ▼
          MS SQL Server (Local)
    Schema design · Anomalous indexing
    Rolling averages · Combined stress flags
                     │
                     ▼
          Random Forest (ML Model)
    Hyperparameter-tuned classification
    10,000 train / 2,000 test partition
    Failure probability output vector
                     │
                     ▼
         Power BI Dashboard (4 Pages)
    Overview Portal · Health · Analysis · Risk
```

---

## Dataset

| Attribute | Detail |
|---|---|
| Source | Synthetic — modeled on real-world manufacturing telemetry |
| Records | 10,000 asset profiles |
| Features | 14 columns |
| Target Variables | Machine failure (Binary), Failure Type (Categorical) |
| Parameters | Air temperature, Process temperature, Torque, Rotational Speed, Tool Wear |
| Null Values | Zero |

**Key columns:** `UDI`, `Type`, `Air temperature [K]`, `Process temperature [K]`, `Rotational speed [rpm]`, `Torque [Nm]`, `Tool wear [min]`, `Machine failure`, `temp_diff`, `low_temp_diff_flag`, `high_torque_flag`, `high_tool_wear_flag`

---

## Tech Stack

| Layer | Tools |
|---|---|
| Data Processing | Python 3.8+, Pandas, NumPy |
| Visualization | Matplotlib, Seaborn |
| Database | Microsoft SQL Server (Transact-SQL) |
| Machine Learning | Scikit-learn (Random Forest Classifier) |
| Model Serialization | Joblib |
| Business Intelligence | Power BI Desktop |
| Version Control | Git, GitHub |

---

## Model Performance

The classification core relies on an optimized Random Forest model designed to prioritize high fault recall, minimizing unpredicted operational downtime.

| Metric | Value |
|---|---|
| Algorithm | Random Forest Classifier |
| Evaluation Split | 80% Train (8,000 records) / 20% Holdout Test (2,000 records) |
| ROC-AUC Score | **0.980** (Exceptional class separation) |
| Recall | **0.824** (Successfully captures 82.4% of actual breakdowns in advance) |
| Precision | **0.609** |
| F1-Score | **0.700** |
| Overall Accuracy | **97.6%** |

### Confusion Matrix (Test Set)
- **True Negatives (Predicted Safe, Stayed Safe):** 1,896 units
- **True Positives (Predicted Fault, Failed):** 56 units
- **False Negatives (Missed Failures):** 12 units (Highly minimized)
- **False Positives (False Alarms):** 36 units

### Feature Importance Weights
The engine calculates feature dependencies dynamically to isolate top mechanical degradation drivers:
1. **Torque [Nm]**: `0.2893` (Primary structural load metric)
2. **Rotational speed [rpm]**: `0.2453`
3. **Tool wear [min]**: `0.1799` (Cumulative component friction)
4. `high_torque_flag`: `0.0703`
5. `temp_diff`: `0.0511`

---

## Key Findings

- **Primary Load Failure:** Mechanical torque above 60 Nm represents the single most significant catalyst for immediate physical shear failure.
- **Wear Threshold Curve:** Component degradation remains stable until approximately 200 minutes of continuous tool wear runtime, after which failure probability accelerates non-linearly.
- **Thermal Anomalies:** Low temperature differences between process and air environments scale failure likelihood by ~5x due to heat dissipation failure.
- **Variant Susceptibility:** Low-tier variants (`L` class) exhibit the highest degradation rates, requiring a 15% more frequent inspection cycle compared to premium high-tier (`H` class) variants.

---

## Project Phase Completion

| Phase | Description | Status |
|---|---|---|
| Phase 1 | Data ingestion, schema design, and local SQL integration | Completed |
| Phase 2 | Feature engineering, stress threshold indexing, and flag creation | Completed |
| Phase 3 | Random Forest training, hyperparameter tuning, and serialization | Completed |
| Phase 4 | 4-Page Power BI executive application and navigation portal | Completed |

---

## Getting Started

### Prerequisites
```text
Python 3.8+
Microsoft SQL Server (Local or Express)
Power BI Desktop
```

### Setup
```bash
# Clone repository
git clone https://github.com/BitsbyBhargav/PulseOps.git
cd PulseOps

# Install dependencies
pip install pandas numpy matplotlib seaborn scikit-learn joblib pyodbc sqlalchemy
```

### Execution Order
```
1. Notebooks/_data_inspection.ipynb     → Validate telemetry profiles
2. Notebooks/_eda_analysis.ipynb        → Profile variable distributions
3. Notebooks/_feature_engineering.ipynb → Compute compound operational flags
4. Notebooks/_ml_model.ipynb            → Train and save Random Forest classifier
5. SQL/Pulse Ops Database.sql           → Load schema & telemetry records
6. Dashboard/pulseops_enriched.pbix     → Open executive Power BI application
```

---

## Project Context

This system architecture, data enrichment pipeline, predictive modeling framework, and front-end interface were constructed independently to prove the commercial viability of utilizing high-recall machine learning algorithms to reduce corporate asset expenditure and prevent unplanned factory downtime.

---

## Author

**Bhargav Sonawane**
Computer Science — Big Data & Cloud Engineering
MIT ADT University, Pune

[![GitHub](https://img.shields.io/badge/GitHub-BitsbyBhargav-181717?style=flat&logo=github)](https://github.com/BitsbyBhargav)
[![Email](https://img.shields.io/badge/Email-officialbhargav22@gmail.com-D14836?style=flat&logo=gmail)](mailto:officialbhargav22@gmail.com)

---

## License

MIT License — see LICENSE file for details.

*PulseOps Predictive Maintenance Engine Framework — 2026*