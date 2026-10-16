# Data center energy analysis in SQL
**New portfolio demonstration · Entirely synthetic data**

This small, reproducible example illustrates how facility energy records can become decision-ready indicators. It complements Vuyani Makeleni’s résumé-described experience with SQL, ESG dashboards, and data center energy tracking. It was created for this portfolio; it is not a historical employer deliverable.

## Run it
With Python 3 installed, run from this directory:

```sh
python run_demo.py
```

No external packages are required. The script creates an in-memory SQLite database, executes [analysis.sql](analysis.sql), verifies the calculations, checks invalid-input rejection, and writes [expected-results.csv](expected-results.csv).

## Metrics and assumptions
- **Aggregate PUE:** sum of total facility electricity divided by sum of IT electricity. This uses the ratio of totals rather than averaging monthly ratios.
- **Illustrative electricity emissions:** sum of total facility kWh multiplied by each record’s invented kg CO2e/kWh factor, divided by 1,000 to obtain tonnes.
- Facility and IT energy must be positive; IT energy cannot exceed facility energy. Factors cannot be negative. Facility-month records must be unique.
- All values and factors are fictional. The example excludes other emissions sources, renewable-energy instruments, operational boundary decisions, and real reporting methodology requirements. It is not a full Scope 2 inventory.

## Results
| Synthetic facility | Facility kWh | IT kWh | Aggregate PUE | Illustrative electricity tCO2e |
| --- | ---: | ---: | ---: | ---: |
| Example East | 295,000 | 200,000 | 1.475 | 88.50 |
| Example West | 348,000 | 240,000 | 1.450 | 139.20 |

In this invented dataset, West has a lower PUE but a higher electricity-emissions estimate because consumption and the assigned emission factor also matter. PUE alone does not establish climate performance or prove an efficiency intervention caused a change.

## Power BI extension concept
These outputs could support KPI cards for facility energy, IT energy, aggregate PUE, and illustrative emissions, plus facility comparisons and a monthly trend. A production model would also need source lineage, meter coverage, reporting boundaries, factor provenance, data-quality review, and documented approval controls. No Power BI file is included or claimed.

[← Portfolio](../README.md)
