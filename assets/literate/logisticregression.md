<!--This file was generated, do not modify it.-->
# Example for Multiclass Regression

```julia:ex1
# Loading Packages & Models from packages
using ScikitLearn
using RDatasets
using Plots
using ScikitLearn.CrossValidation: cross_val_score
@sk_import model_selection: train_test_split
@sk_import linear_model: LogisticRegression
@sk_import metrics: confusion_matrix
@sk_import metrics: classification_report
@sk_import metrics: roc_curve
############################################
```

## Loading Dataset

```julia:ex2
iris = dataset("datasets", "iris");
```

## Extracting the targets and predictors

```julia:ex3
X = convert(Array, iris[!, [:SepalLength, :SepalWidth, :PetalLength, :PetalWidth]]);
X[1:5,:]
```

```julia:ex4
y = y = convert(Array, iris[!, :Species]);
y[1:5,:]
```

## Spliting the dataset

```julia:ex5
X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=42);
```

## Initializing the model with 200 iterations

```julia:ex6
logisticmodel = LogisticRegression(fit_intercept=true, max_iter = 200);
```

## Model Fiting

```julia:ex7
fit!(logisticmodel, X_train, y_train)
```

## Checking the accuracy

```julia:ex8
accuracy = score(logisticmodel, X_train, y_train)
```

With Cross Validation

```julia:ex9
cross_val_score(LogisticRegression(max_iter=130), X_train, y_train; cv=5)

y_pred = predict(logisticmodel, X_train);
```

## Confusion Matrix

```julia:ex10
cf_matrix =confusion_matrix(y_train, y_pred)
```

## Precision & Recall

```julia:ex11
println(classification_report(y_train, y_pred))
```

