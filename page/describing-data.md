@def title = "Describing Data "
@def hascode = true

@def rss_title = "Describing Data "
@def rss_pubdate = Date(2019, 5, 1)

@def tags = ["syntax", "code", "image"]

# Describing Data  

@@colbox-yellow All code used in this module is available [here](https://github.com/coinslab/ComputationalCognitiveModeling/blob/main/julia-scripts/data-handling/describe-data.jl). @@

```julia
using RDatasets 
data = dataset("datasets", "iris")
```



Once you have loaded your data into your Julia work environment, an easy way to get a quick summary of your dataset is to use the `describe()` function 

```julia
describe(data)
```

```julia
5×8 DataFrame
│ Row │ variable    │ mean    │ min    │ median │ max       │ nunique │ nmissing │ eltype                   │
│     │ Symbol      │ Union…  │ Any    │ Union… │ Any       │ Union…  │ Nothing  │ DataType                 │
├─────┼─────────────┼─────────┼────────┼────────┼───────────┼─────────┼──────────┼──────────────────────────┤
│ 1   │ SepalLength │ 5.84333 │ 4.3    │ 5.8    │ 7.9       │         │          │ Float64                  │
│ 2   │ SepalWidth  │ 3.05733 │ 2.0    │ 3.0    │ 4.4       │         │          │ Float64                  │
│ 3   │ PetalLength │ 3.758   │ 1.0    │ 4.35   │ 6.9       │         │          │ Float64                  │
│ 4   │ PetalWidth  │ 1.19933 │ 0.1    │ 1.3    │ 2.5       │         │          │ Float64                  │
│ 5   │ Species     │         │ setosa │        │ virginica │ 3       │          │ CategoricalString{UInt8} │
```

**So how do we interpret the above table ?**

- The first column in the above table shows the column number of all columns in the data a.k.a the position of each column in the data 

- The third, fourth, fifth, and sixth columns report the summary statistics of each column in the dataset. These summary statistics are important for understanding the dispersion and shape of the distribution of the variables you are interested.

- `nunique` returns the no of unique elements in a column. This is an important information when your data contains categorical variables. In this case, we can see that `Species` column is categorical in  nature and has 3 unique elements/levels. To get the levels information, you can either use `levels()` or `unique()`.  While `levels()` is just reserved for categorical type, `unique()`can be used for any element type. 


  ```julia
  unique(data.Species)	
  ```

  ```julia
  3-element Array{String,1}:
  "setosa"
  "versicolor"
  "virginica"
  ```

- One of the many serious problems everyone face who deal with real-world data is the problem of missing data. It is very important to know if your data have `missing`  elements. `nmissing` returns the no of missing values in each column of the data. For `iris` data, we don't have any missing values and hence the field is empty. 

**But suppose you are only interested in the statistics of a particular column or a bunch of columns.**

In that case you can use the functions provided by the `Statistics` standard library that comes with Julia. Suppose I am more interested in understanding `PetalWidth`

Standard Deviation: 

```julia
using Statistics
std(data.PetalWidth)
```

```julia
0.7622376689603466
```

Variance:

```julia
var(data.PetalWidth)
```

```julia
0.581006263982103
```

Mean:

```julia
mean(data.PetalWidth)
```

```julia
1.1993333333333336
```

Median:

```julia
median(data.PetalWidth)
```

```julia
1.3
```

Correlation: 

```julia
cor(data.PetalWidth, data.PetalLength)
```

```julia
0.9628654314027961
```





