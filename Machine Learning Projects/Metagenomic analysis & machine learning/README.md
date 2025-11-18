# Metagenomics Analysis Pipeline -- README

This repository contains a full end-to-end metagenomics analysis
pipeline implemented in Python.\
It includes preprocessing, diversity analysis, dimensionality reduction,
PERMANOVA, and multiple machine‑learning models with SHAP
explainability.

------------------------------------------------------------------------

## 🚀 Features

### **1. Data Input**

-   Reads a CSV file containing metadata and species abundance tables.
-   User configuration allows specifying:
    -   CSV path
    -   Target group column
    -   ID column
    -   Metadata fields
    -   Species column prefix

------------------------------------------------------------------------

## ⚙️ **2. Data Filtering & Transformations**

-   **Low‑abundance species filtering** based on prevalence and mean
    abundance.
-   **TSS normalization** generates compositional profiles.
-   **CLR transformation** with pseudocount correction.
-   Outputs:
    -   `X_TSS.csv`
    -   `X_CLR.csv`

------------------------------------------------------------------------

## 📊 **3. Diversity Analyses**

### **Alpha Diversity**

-   Shannon Index\
-   Simpson Index\
    Results saved to:
-   `metadata_with_alpha.csv`
-   `alpha_diversity_shannon.png`

### **Beta Diversity**

-   Bray--Curtis distance matrix
-   Classical PCoA\
    Outputs:
-   `pcoa_coordinates.csv`
-   `pcoa_plot.png`

------------------------------------------------------------------------

## 🧪 **4. PERMANOVA**

A custom implementation of PERMANOVA evaluates community differences
between groups.\
Results saved in: - `PERMANOVA_results.txt`

------------------------------------------------------------------------

## 🤖 **5. Machine Learning Models**

Trains multiple classifiers: - XGBoost\
- Random Forest\
- Logistic Regression\
- SVM\
- KNN\
- MLP Neural Network

Evaluates: - Accuracy - ROC--AUC\
- ROC curve plot

Outputs: - Trained model `.pkl` files - `model_performance.csv` -
`ROC_comparison.png`

------------------------------------------------------------------------

## 🔍 **6. SHAP Feature Importance**

-   SHAP summary plot for XGBoost\
    Output:\
-   `SHAP_summary.png`

------------------------------------------------------------------------

## 📁 **Output Directory**

All results are generated inside:

    analysis_outputs/

------------------------------------------------------------------------

## ▶️ Running the Pipeline

1.  Install dependencies:

```{=html}
<!-- -->
```
    pip install scikit-learn xgboost shap seaborn matplotlib joblib pandas numpy scipy scikit-bio statsmodels

2.  Edit the **USER CONFIG** section in the script:

``` python
CSV_PATH = "path/to/file.csv"
TARGET_COL = "Delivery_Mode"
ID_COL = "Infant_Number"
```

3.  Run the script in Python:

```{=html}
<!-- -->
```
    python analysis_pipeline.py

------------------------------------------------------------------------

## 📝 Author

Suprise Baloyi\
Metagenomic Analysis Workflow -- 2025
