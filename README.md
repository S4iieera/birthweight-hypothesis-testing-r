# Birthweight Hypothesis Testing in R

Statistical analysis of a birthweight dataset in **R**, applying formal hypothesis
testing to investigate the relationship between maternal factors (notably smoking) and
infant birth weight.

## What it demonstrates

- **Descriptive statistics** — grouped means, standard deviations and standard errors.
- **Hypothesis testing** — independent two-sample t-test, chi-square test of
  independence, and Fisher's exact test on contingency tables.
- **Assumption checking** — Q-Q plots and histograms for normality.
- **Simulation** — Monte Carlo simulation of t-tests under null and alternative
  hypotheses, with a p-value distribution to illustrate statistical power.
- **Visualisation** — `ggplot2` boxplots and base-R diagnostic plots.

## Project structure

```
birthweight-hypothesis-testing-r/
├── analysis.R            # the full statistical analysis
├── generate_dataset.R    # reproducibly builds the dataset from MASS::birthwt
└── data/birthweight.csv  # the dataset used by analysis.R
```

## Running it

```r
# from R / RStudio, in the project root:
source("generate_dataset.R")   # optional — regenerates data/birthweight.csv
source("analysis.R")
```

Requires the `MASS`, `dplyr`, `tibble` and `ggplot2` packages.

## Notes

Originally developed as individual university coursework (COMP1814, Statistical
Techniques with R).

— Sameer Ali
