@def title = "Fundamentals of Data Handling"
@def hascode = true

@def rss_title = "Fundamentals of Data Handling"
@def rss_pubdate = Date(2019, 5, 1)

@def tags = ["syntax", "code", "image"]

# Fundamentals of Data Handling 

@@colbox-yellow All code used in this module is available [here](https://github.com/coinslab/ComputationalCognitiveModeling/blob/main/julia-scripts/data-handling/understanding-data.jl). @@

In this module we will be using the following packages: `Rdatasets`, `DataFrames`

 @@colbox-blue If you haven't installed those package and don't know how to install them, you can learn it from [here](/software-setup/#installing_julia_packages). @@

\toc

## Basics 

Let's first load the `iris` dataset from `RDatasets` package 

```julia
using RDatasets, DataFrames 
data = dataset("datasets", "iris")
```

**Sneak Peaking into your dataset**

One of the first thing you should be doing right after loading a dataset is to have a peek into them. You can do that with the help of `first()` function in Julia which accepts the data and no. of rows you want to see as arguments. 

```julia
first(data,4) # Here we are telling Julia to show the first 4 rows 
```

```julia
4×5 DataFrame
 Row │ SepalLength  SepalWidth  PetalLength  PetalWidth  Species 
     │ Float64      Float64     Float64      Float64     Cat…    
─────┼───────────────────────────────────────────────────────────
   1 │         5.1         3.5          1.4         0.2  setosa
   2 │         4.9         3.0          1.4         0.2  setosa
   3 │         4.7         3.2          1.3         0.2  setosa
   4 │         4.6         3.1          1.5         0.2  setosa
```

If you want to see the last few rows, just have a -ve sign to the no of rows.

```julia
first(data,-4) # Showing the last 4 rows 
```

 ```julia
4×5 DataFrame
 Row │ SepalLength  SepalWidth  PetalLength  PetalWidth  Species   
     │ Float64      Float64     Float64      Float64     Cat…      
─────┼─────────────────────────────────────────────────────────────
   1 │         6.3         2.5          5.0         1.9  virginica
   2 │         6.5         3.0          5.2         2.0  virginica
   3 │         6.2         3.4          5.4         2.3  virginica
   4 │         5.9         3.0          5.1         1.8  virginica
 ```

By examining the output of last two code blocks we can confidently conclude that there are 5 columns, out of which four have numerical values and one has labels. You will also notice that the first line of both outputs say `DataFrame`. This means that our `data` is of type `DataFrame`. Availability of a plethora of functions, across programing languages, to handle and pre-process data of type  `DataFrame`  makes it one of the most widely used and recommended data types in data science.



 @@colbox-blue To know the type of your data or variables, you can use the `typeof()` function in julia.@@

```julia
typeof(data)
```

```julia
DataFrame
```

**Converting data from one type to another**

Incase if you had data in some other type say `Array`, you can convert them into DataFrames using the `DataFrame()` function in `DataFrames` package.

```julia
A = [1 2 3;4 5 6] # Created an array with 2 rows and 3 columns 
```

```julia
2×3 Array{Int64,2}:
 1  2  3
 4  5  6
```

```julia
B = DataFrame(A) # Converts the above array into DataFrame and stores it in variable B
```

```julia
2×3 DataFrame
 Row │ x1     x2     x3    
     │ Int64  Int64  Int64 
─────┼─────────────────────
   1 │     1      2      3
   2 │     4      5      6
```

Suppose you are faced with a situation quite opposite to what we just illustrated. How would you convert our `iris` data, which is in a `DataFrame` type to `Array` type? For that scenario and for many other type conversions we can use Julia's inbuilt `convert()` function. `convert()` accepts the type you want your data to be converted into as its first argument and the data you want to convert as its second argument. 

```julia
array_data = convert(Array, data)
```

```julia
150×5 Array{Any,2}:
 5.1  3.5  1.4  0.2  CategoricalString{UInt8} "setosa"
 4.9  3.0  1.4  0.2  CategoricalString{UInt8} "setosa"
 4.7  3.2  1.3  0.2  CategoricalString{UInt8} "setosa"
 4.6  3.1  1.5  0.2  CategoricalString{UInt8} "setosa"
 5.0  3.6  1.4  0.2  CategoricalString{UInt8} "setosa"
 5.4  3.9  1.7  0.4  CategoricalString{UInt8} "setosa"
 4.6  3.4  1.4  0.3  CategoricalString{UInt8} "setosa"
 ⋮
 6.8  3.2  5.9  2.3  CategoricalString{UInt8} "virginica"
 6.7  3.3  5.7  2.5  CategoricalString{UInt8} "virginica"
 6.7  3.0  5.2  2.3  CategoricalString{UInt8} "virginica"
 6.3  2.5  5.0  1.9  CategoricalString{UInt8} "virginica"
 6.5  3.0  5.2  2.0  CategoricalString{UInt8} "virginica"
 6.2  3.4  5.4  2.3  CategoricalString{UInt8} "virginica"
 5.9  3.0  5.1  1.8  CategoricalString{UInt8} "virginica"
```

**What's the shape of your data?**

Though the first line of the output of the above code blocks prints the shape of your data, sometimes you require these information while running some algorithms.  You can get the shape of your data saved in the variables `m` and `n` using the following code 

```julia
m,n=size(data)
```

```julia
(150, 5)
```

## Referencing cells in your data

Sometime you just need to look at a specific column or row or a bunch or rows and columns. How would we do that? Well, there are a couple of ways to do that.

### Referencing by column/row number 

Accessing a single cell value: 

 ```julia
data[1,2] # returns value in 1st row and 2nd column 
 ```

```julia
3.5
```

Accessing an entire column: 

```julia
data[!,1] # returns all rows in 1st column 
```

```julia
 5.1
 4.9
 4.7
 4.6
 5.0
 5.4
 4.6
 ⋮
 6.8
 6.7
 6.7
 6.3
 6.5
 6.2
 5.9
```

Accessing an entire row:

```julia
 data[1,:]
```

```julia
DataFrameRow
│ Row │ SepalLength │ SepalWidth │ PetalLength │ PetalWidth │ Species      │
│     │ Float64     │ Float64    │ Float64     │ Float64    │ Categorical… │
├─────┼─────────────┼────────────┼─────────────┼────────────┼──────────────┤
│ 1   │ 5.1         │ 3.5        │ 1.4         │ 0.2        │ setosa       │
```

Accessing multiple columns:

```julia
data[!,[1,5]] # here we are accessing the 1st and 5th column
```

```julia
150×2 DataFrame
│ Row │ SepalLength │ Species      │
│     │ Float64     │ Categorical… │
├─────┼─────────────┼──────────────┤
│ 1   │ 5.1         │ setosa       │
│ 2   │ 4.9         │ setosa       │
│ 3   │ 4.7         │ setosa       │
│ 4   │ 4.6         │ setosa       │
│ 5   │ 5.0         │ setosa       │
⋮
│ 145 │ 6.7         │ virginica    │
│ 146 │ 6.7         │ virginica    │
│ 147 │ 6.3         │ virginica    │
│ 148 │ 6.5         │ virginica    │
│ 149 │ 6.2         │ virginica    │
│ 150 │ 5.9         │ virginica    │
```

Accessing multiple rows:

```julia
data[[1,3],:]
```

```julia
2×5 DataFrame
│ Row │ SepalLength │ SepalWidth │ PetalLength │ PetalWidth │ Species      │
│     │ Float64     │ Float64    │ Float64     │ Float64    │ Categorical… │
├─────┼─────────────┼────────────┼─────────────┼────────────┼──────────────┤
│ 1   │ 5.1         │ 3.5        │ 1.4         │ 0.2        │ setosa       │
│ 2   │ 4.7         │ 3.2        │ 1.3         │ 0.2        │ setosa       │
```

### Referencing by column name

Referencing by column numbers isn't the smartest way to access columns and are more prone to human error, so a recommended way is to reference them by their name. 

Accessing a single column 

```julia
data.Species # accessing the column for Species 
```

```julia 
150-element CategoricalArray{String,1,UInt8}:
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 "setosa"
 ⋮
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
 "virginica"
```

You can also access the same column like this: 

```julia
data[!,:Species];
```

Accessing multiple columns 

```julia
data[!,[:Species, :SepalLength]] # Also note that how column's position changed in the output 
```

```julia
150×2 DataFrame
│ Row │ Species      │ SepalLength │
│     │ Categorical… │ Float64     │
├─────┼──────────────┼─────────────┤
│ 1   │ setosa       │ 5.1         │
│ 2   │ setosa       │ 4.9         │
│ 3   │ setosa       │ 4.7         │
│ 4   │ setosa       │ 4.6         │
│ 5   │ setosa       │ 5.0         │
⋮
│ 145 │ virginica    │ 6.7         │
│ 146 │ virginica    │ 6.7         │
│ 147 │ virginica    │ 6.3         │
│ 148 │ virginica    │ 6.5         │
│ 149 │ virginica    │ 6.2         │
│ 150 │ virginica    │ 5.9         │
```

## Getting Column Names

But how do you get all the column names in your data?

```julia
names(data)
```

```julia
5-element Array{Symbol,1}:
 :SepalLength
 :SepalWidth
 :PetalLength
 :PetalWidth
 :Species
```

