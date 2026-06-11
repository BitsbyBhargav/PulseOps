PULSEOPS — PROJECT LOGBOOK
Predictive Maintenance Intelligence System
Self-initiated during internship at Adani Ports
and SEZ Ltd., Hazira, Surat



SESSION 001 — June 10, 2026 (Morning)
Time spent: ~1 hour
Phase: Project Ideation & Concept Finalization

CONTEXT
Following the induction meeting with the HOD
and senior team members, it was communicated
that no specific task would be assigned for
the first month — the period was open for
self-directed learning, observation, and
initiative. Goal set: identify a project that
would be genuinely useful to the IT department
and demonstrate applied analytics capability.

OBJECTIVE
Evaluate possible project directions relevant
to port/logistics operations and finalize one
concept aligned with both department value and
personal skill-building goals (Python, SQL,
ML, Cloud, Power BI).

WHAT WAS DONE

1. Project Options Evaluated
   Five potential directions were assessed
   based on relevance, complexity, and
   real-world applicability to port operations:

   - Option A: Port Operations Analytics
     Dashboard (KPI visualization — VTT,
     berth occupancy, cargo dwell time)
   - Option B: Predictive Maintenance
     Intelligence System (equipment failure
     prediction using sensor data)
   - Option C: Supply Chain Delay Root
     Cause Analyzer
   - Option D: IT Department Productivity
     Tracker
   - Option E: Bank Marketing Analysis
     reframed for logistics/BD context

2. Evaluation Criteria
   - Visibility and business impact
   - Technical complexity vs current skill
     stack (SQL, Python, Power BI)
   - Learning value (new skills: ML, AWS)
   - Relevance to Adani Ports operational
     context
   - Portfolio differentiation value

3. Decision
   - Selected: Predictive Maintenance
     Intelligence System (Option B)
   - Reasoning: Equipment downtime is a
     high-cost, high-visibility problem in
     port operations (crane/conveyor
     failures cause significant operational
     loss). This option combines analytics,
     machine learning, SQL, and cloud —
     the broadest skill coverage of all
     options — while producing a result
     directly translatable to operational
     value.

4. Project Naming
   - Evaluated names: PortGuard Analytics,
     SentinelIQ, IronWatch, VigilIQ,
     OpsRadar, PulseOps
   - Final name: PulseOps
   - Reasoning: "Pulse" reflects continuous
     equipment health monitoring via sensor
     data; "Ops" anchors it to operational
     context. Name is domain-flexible,
     professional, and distinct from
     similarly-themed peer projects.

5. Initial Scope Defined
   - Core idea: analyze equipment sensor
     data to predict failures before they
     occur, shifting from reactive to
     predictive maintenance
   - Tech stack identified: Python, SQL
     Server, AWS (S3/Athena), Power BI,
     Scikit-learn
   - Bank Marketing Analysis project
     confirmed to continue in parallel as
     a separate, independent deliverable

KEY DECISIONS
- PulseOps selected as the primary
  self-initiated project for the
  internship period
- Project to be built independently,
  documented to professional standard,
  and presented to the IT department/HOD
  toward the end of the internship
- Two-project parallel track established:
  Bank Marketing Analysis (academic/
  portfolio) + PulseOps (Adani-context,
  internship deliverable)

BLOCKERS
None

NEXT SESSION (002)
- Set up GitHub repository: pulseops
- Design system architecture (5-layer
  pipeline)
- Define folder structure and project brief

─────────────────────────────────────
SESSION 002 — June 10, 2026
Time spent: ~1 hour
Phase: Repository Setup & Initialization

OBJECTIVE
Set up GitHub repository and push initial
project structure with architecture diagram.

WHAT WAS DONE

1. GitHub Repository Created
   - Repo name: pulseops
   - Visibility: Public
   - Added README, .gitignore (Python),
     MIT License

2. Folder Structure Pushed
   - data/ (raw, processed, synthetic)
   - notebooks/
   - sql/
   - src/
   - dashboard/
   - docs/
   - assets/

3. Dataset Added
   - UCI AI4I 2020 Predictive Maintenance
     Dataset downloaded
   - Placed in data/raw/ai4i2020.csv

4. Architecture Diagram
   - Exported architecture_diagram.png
     from draw.io
   - Added to assets/ folder
   - Linked in README.md

5. First Commit
   - All files pushed together
   - Repo officially live

KEY DECISIONS
- Project structure finalized before any
  coding began
- README includes architecture diagram
  for immediate visual context

BLOCKERS
None

NEXT SESSION (003)
- Begin Week 1 work: data inspection
- Open notebooks/01_data_inspection.ipynb
- Load dataset, check structure, types,
  nulls, target distribution

─────────────────────────────────────

SESSION 003 — June 11, 2026
Time spent: ~2 hour
Phase: Data Inspection (Week 1)

OBJECTIVE
Load AI4I dataset, understand structure,
analyze target variable and 5 failure
types, check data quality before any
cleaning or modeling.

WHAT WAS DONE

1. Dataset Loaded
   - File: data/raw/ai4i2020.csv
   - Shape: 10,000 rows x 14 columns
   - Columns confirmed: UDI, Product ID,
     Type, Air temperature, Process
     temperature, Rotational speed,
     Torque, Tool wear, Machine failure,
     TWF, HDF, PWF, OSF, RNF

2. Data Quality Check
   - All 14 columns: 10,000 non-null
   - Missing values: 0 (across all columns)
   - Duplicate rows: 0
   - Dataset is clean — no preprocessing
     needed for nulls/duplicates

3. Target Variable Analysis
   - "Machine failure" distribution:
     0 (no failure): 9,661
     1 (failure):      339
   - Failure rate: 3.39%
   - Severe class imbalance confirmed
     (~1:28 ratio) — more extreme than
     Bank Marketing dataset (1:7)

4. Five Failure Types Analyzed
   TWF (Tool Wear Failure):        46  (0.46%)
   HDF (Heat Dissipation Failure): 115 (1.15%)
   PWF (Power Failure):            95  (0.95%)
   OSF (Overstrain Failure):       98  (0.98%)
   RNF (Random Failure):           19  (0.19%)
   - HDF is the most common failure type,
     RNF is the rarest

5. Failure Overlap Check
   - Rows with 0 failures:  9,652
   - Rows with 1 failure:     324
   - Rows with 2 failures:     23
   - Rows with 3 failures:      1
   - Most failures are isolated (single
     type), but 24 rows show simultaneous
     multi-failure events

6. Sensor Reading Summary
   - Air temperature [K]: mean 300.0,
     range 295.3 - 304.5
   - Process temperature [K]: mean 310.01,
     range 305.7 - 313.8
   - Rotational speed [rpm]: mean 1538.78,
     range 1168 - 2886 (wide spread,
     possible outliers at high end)
   - Torque [Nm]: mean 39.99,
     range 3.8 - 76.6
   - Tool wear [min]: mean 107.95,
     range 0 - 253

7. Product Type Distribution
   - Type L: 6,000 (60%)
   - Type M: 2,997 (~30%)
   - Type H: 1,003 (~10%)

KEY OBSERVATIONS
- Dataset is fully clean — zero nulls,
  zero duplicates, ready for analysis
- Failure rate (3.39%) is far more
  imbalanced than Bank Marketing dataset
  (11.3%) — will need stronger imbalance
  handling (class_weight, possibly SMOTE)
- Rotational speed shows widest range
  relative to mean — worth checking for
  outliers in EDA
- HDF (Heat Dissipation) is the dominant
  failure type — likely strong candidate
  for feature engineering around
  temperature differential
  (Process temp - Air temp)
- 24 multi-failure rows are rare edge
  cases — decide later whether to keep,
  flag separately, or exclude
- Product Type L dominates (60%) — check
  if failure rate differs by type

BLOCKERS
None

NEXT SESSION (004)
- Bivariate analysis: each sensor reading
  vs Machine failure (boxplots)
- Visualize failure rate by Product Type
  (L/M/H)
- Engineer temperature differential
  feature (Process temp - Air temp)
- Check correlation between sensor
  readings and failure types
- Begin EDA visualizations

─────────────────────────────────────