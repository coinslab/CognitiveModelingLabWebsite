@def title = "Decision Trees"
@def hascode = true

@def tags = ["syntax", "code", "image"]

# Decision Tree

@@colbox-yellow All code used in this module is available [here](https://github.com/coinslab/ComputationalCognitiveModeling/blob/main/julia-scripts/model-zoo/tree.jl).@@

## Loading Packages

```julia
using DataFrames, CSV, ScikitLearn, PyPlot 
```

## Loading the dataset 

```julia
data = CSV.File("covid_cleaned.csv") |> DataFrame
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
@sk_import model_selection: train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.33, random_state=42) # You can define the train/test size ratio using the test_size argument
```

- `train_test_split` is a function provided by the scikit-learn package. 
- If you want random sampling while splitting the data, assign a number the the `random_state` argument to the `train_test_split` function. 
- `test_size` specifies what should be the ratio of test data in the collection after splitting the data into training set and test set. Here we have specified that we need a test dataset of size = 33% of the original data. 

### Model Definition 

```julia
@sk_import tree: DecisionTreeClassifier
tree = DecisionTreeClassifier()
```

- In this example we are using a Decision Tree classifier

### Model Fitting 

```julia
fit!(tree,X_train,y_train)
```

- This will fit your model to the training dataset. 

### Model Evaluation 

Classification report with the training data: 

```julia
y_pred = predict(tree,X_train)

@sk_import metrics: classification_report
print(classification_report(y_train,y_pred))
```

```julia
>              precision    recall  f1-score   support

           0       0.79      0.75      0.77      4245
           1       0.83      0.85      0.84      5931

    accuracy                           0.81     10176
   macro avg       0.81      0.80      0.80     10176
weighted avg       0.81      0.81      0.81     10176
```

Classification report with the test data:

#### Confusion Matrix 

```julia
@sk_import metrics: plot_confusion_matrix
plot_confusion_matrix(tree,X_train,y_train)
PyPlot.gcf()
```

![](/img/cmatrix_tree.PNG)