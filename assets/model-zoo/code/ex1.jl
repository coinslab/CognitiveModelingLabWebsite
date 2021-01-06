# This file was generated, do not modify it. # hide
# Loading Packages & Models from packages
using ScikitLearn
using RDatasets
import ScikitLearn: CrossValidation
@sk_import linear_model: LogisticRegression
@sk_import metrics: confusion_matrix
@sk_import metrics: classification_report
@sk_import metrics: roc_curve
############################################