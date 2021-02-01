@def title = "Logistic Regression"
@def hascode = true

@def tags = ["syntax", "code", "image"]

# Logistic Regression 

@@colbox-yellow All code used in this module is available [here](https://github.com/coinslab/ComputationalCognitiveModeling/blob/main/julia-scripts/model-zoo/logisitic.jl).@@

## Loading Packages & Modules from packages 

```julia
using CSV # This is a pacakge we use for loading CSV Files.
using DataFrames
@sk_import model_selection: train_test_split
@sk_import linear_model: LogisticRegression
@sk_import metrics: accuracy_score
@sk_import metrics: confusion_matrix
@sk_import metrics: classification_report
@sk_import model_selection: cross_val_score
```



## Loading the dataset 

```julia
data = CSV.read("covid_cleaned.csv", DataFrame) 
```

```julia
20352×16 DataFrame
   Row │ intubed  pneumonia  age    pregnancy  diabetes  copd   asthma  inmsupr  hypertension  other_disease  cardiovascular  obesity  renal_chronic  tobacco  contact_other_covid  covid_res 
       │ Int64    Int64      Int64  Int64      Int64     Int64  Int64   Int64    Int64         Int64          Int64           Int64    Int64          Int64    Int64                Int64     
───────┼──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
     1 │       0          0     25          0         0      0       0        0             0              0               0        0              0        0                    1          1
     2 │       0          0     52          0         0      0       0        0             0              0               0        1              0        1                    1          1
     3 │       0          1     51          0         0      0       0        0             0              0               0        0              0        0                    1          1
     4 │       1          1     67          0         1      0       0        0             1              0               0        1              0        0                    1          1
     5 │       0          1     59          0         1      0       0        0             0              0               0        0              0        0                    1          1
     6 │       0          0     52          0         1      0       0        0             1              0               1        0              0        0                    0          1
     7 │       0          1     54          0         0      0       0        0             0              0               0        0              0        0                    0          1
     8 │       0          1     78          0         0      0       0        0             1              0               0        1              0        0                    1          1
   ⋮   │    ⋮         ⋮        ⋮        ⋮         ⋮        ⋮      ⋮        ⋮          ⋮              ⋮              ⋮            ⋮           ⋮           ⋮              ⋮               ⋮
 20346 │       1          1     65          0         0      0       0        0             0              0               0        0              0        0                    0          0
 20347 │       0          1     49          0         0      0       0        0             0              0               0        0              0        0                    0          0
 20348 │       0          1     80          0         1      0       0        0             0              0               0        0              0        0                    0          0
 20349 │       0          0     13          0         0      0       0        0             0              0               0        0              0        0                    0          0
 20350 │       1          0     23          0         0      0       0        0             0              1               0        0              0        1                    0          0
 20351 │       0          1      1          0         0      0       0        0             0              0               0        0              0        0                    0          0
 20352 │       0          1     55          0         0      0       0        0             0              0               0        1              0        0                    0          0
                                                                                                                                                                            20337 rows omitted
```



The `ScikitLearn` package only accepts the data in array form, hence we need to convert our data into Arrays 

```julia
X = convert(Array, data[!,Not(:covid_res)])
y = convert(Array, data[!,:covid_res]) # :covid_res is our target variable
```

### Splitting the data into training set and test set 

```julia
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42) # You can define the train/test size ratio using the test_size argument
```

- `train_test_split` is a function provided by the scikit-learn package. 
- If you want random sampling while splitting the data, assign a number the the `random_state` argument to the `train_test_split` function. 
- `test_size` specifies what should be the ratio of test data in the collection after splitting the data into training set and test set. Here we have specified that we need a test dataset of size = 33% of the original data. 

### Model Definition 

```julia
simplelogistic = LogisticRegression(penalty=:none)
```

- This is how you define a simple logistic regression. `LogisticRegression()` is equally correct, but when you don't specify penalty to be `:none`, scikit learn chooses L2 regularization by default. 

### Model Fitting 

```julia
fit!(simplelogistic,X_train,y_train)
```

- This will fit your model to the training dataset. 

### Model Evaluation 

Classification report with the training data: 

```julia
y_pred = predict(simplelogistic,X_train)
print(classification_report(y_train,y_pred))
```

```julia
>	      precision    recall  f1-score   support

           0       0.63      0.45      0.52      5684
           1       0.67      0.81      0.74      7951

    accuracy                           0.66     13635
   macro avg       0.65      0.63      0.63     13635
weighted avg       0.65      0.66      0.65     13635
```

Classification report with the test data:

```julia
y_pred = predict(simplelogistic,X_test)
print(classification_report(y_test,y_pred))
```

```julia
>              precision    recall  f1-score   support

           0       0.64      0.45      0.53      2763
           1       0.68      0.82      0.74      3954

    accuracy                           0.67      6717
   macro avg       0.66      0.64      0.64      6717
weighted avg       0.66      0.67      0.66      6717
```

#### Cross Validation 

```julia
cross_val_score(LogisticRegression(penalty=:none ), X_train, y_train)
```

 ```julia
5-element Array{Float64,1}:
 0.6615328199486615
 0.6563989732306564
 0.6604327099376605
 0.6585991932526586
 0.654932159882655
 ```

#### Confusion Matrix 

```julia
plot_confusion_matrix(simplelogistic,X_train,y_train)
gcf()
```

![](/img/cmatrix_logistic.PNG)