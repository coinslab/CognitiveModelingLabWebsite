# This file was generated, do not modify it. # hide
# Loading Packages & Models from packages
using ScikitLearn
using RDatasets
using ScikitLearn.CrossValidation: cross_val_score
@sk_import model_selection: train_test_split
@sk_import linear_model: LogisticRegression
@sk_import metrics: confusion_matrix
@sk_import metrics: classification_report
@sk_import metrics: roc_curve
############################################