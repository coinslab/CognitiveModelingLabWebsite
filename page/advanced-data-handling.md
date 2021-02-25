@def title = "Advanced Data Handling "
@def hascode = true

@def rss_title = "Advanced Data Handling"
@def rss_pubdate = Date(2021, 5, 1)

@def tags = ["syntax", "code", "image"]

# Advanced Data Handling

@@colbox-yellow All code used in this module is available [here](https://github.com/coinslab/ComputationalCognitiveModeling/blob/main/julia-scripts/data-handling/advanced-data-handling.jl).@@

@@colbox-blue Please read [Fundamentals of Data Handling](/page/getting-to-know-your-data) before reading this module.@@

\\ 

Most of the times, the data you get wouldn't be in the format that you require them to be in. In those cases you rely on the querying functionalities (like those supported by SQL) that your language supports for data manipulation. A package that provides a really neat querying syntax is `DataFramesMeta`.  In this module, you will learn how to use various functionalities from the `DataFramesMeta` package to manipulate your raw data. 

Loading the packages and the `cars` dataset from `Rdatasets`

```julia
using RDatasets
using StatsBase
using DataFrames
using DataFramesMeta
cars = dataset("datasets", "mtcars")
```

Before going further, we need to know the column names. We will use the `describe()` function to get the column names as well as some other summary statistics of the data. 

```julia
describe(cars)
```

```julia
12×7 DataFrame
 Row │ variable  mean     min          median  max         nmissing  eltype   
     │ Symbol    Union…   Any          Union…  Any         Int64     DataType 
─────┼────────────────────────────────────────────────────────────────────────
   1 │ Model              AMC Javelin          Volvo 142E         0  String
   2 │ MPG       20.0906  10.4         19.2    33.9               0  Float64
   3 │ Cyl       6.1875   4            6.0     8                  0  Int64
   4 │ Disp      230.722  71.1         196.3   472.0              0  Float64
   5 │ HP        146.688  52           123.0   335                0  Int64
   6 │ DRat      3.59656  2.76         3.695   4.93               0  Float64
   7 │ WT        3.21725  1.513        3.325   5.424              0  Float64
   8 │ QSec      17.8487  14.5         17.71   22.9               0  Float64
   9 │ VS        0.4375   0            0.0     1                  0  Int64
  10 │ AM        0.40625  0            0.0     1                  0  Int64
  11 │ Gear      3.6875   3            4.0     5                  0  Int64
  12 │ Carb      2.8125   1            2.0     8                  0  Int64
```

\\

Let's say you only want data about the cars that have 4 cylinders. How would we get that?

```julia
@linq cars |>
        where(:Cyl .==4)
```

```julia
11×12 DataFrame
 Row │ Model           MPG      Cyl    Disp     HP     DRat     WT       QSec     VS     AM     Gear   Carb  
     │ String          Float64  Int64  Float64  Int64  Float64  Float64  Float64  Int64  Int64  Int64  Int64 
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ Datsun 710         22.8      4    108.0     93     3.85    2.32     18.61      1      1      4      1
   2 │ Merc 240D          24.4      4    146.7     62     3.69    3.19     20.0       1      0      4      2
   3 │ Merc 230           22.8      4    140.8     95     3.92    3.15     22.9       1      0      4      2
   4 │ Fiat 128           32.4      4     78.7     66     4.08    2.2      19.47      1      1      4      1
   5 │ Honda Civic        30.4      4     75.7     52     4.93    1.615    18.52      1      1      4      2
   6 │ Toyota Corolla     33.9      4     71.1     65     4.22    1.835    19.9       1      1      4      1
   7 │ Toyota Corona      21.5      4    120.1     97     3.7     2.465    20.01      1      0      3      1
   8 │ Fiat X1-9          27.3      4     79.0     66     4.08    1.935    18.9       1      1      4      1
   9 │ Porsche 914-2      26.0      4    120.3     91     4.43    2.14     16.7       0      1      5      2
  10 │ Lotus Europa       30.4      4     95.1    113     3.77    1.513    16.9       1      1      5      2
  11 │ Volvo 142E         21.4      4    121.0    109     4.11    2.78     18.6       1      1      4      2
```

- `@linq` is a macro that's telling Julia to lookout for LINQ (Language-Integrated Query) style of querying. The `|>` is called the pipe operator and is used in between query operations. The `where` command tells Julia to filter out data satisfying the condition specified. Here the `:Cyl .==4` filter out any rows that's not satisfying the condition.

With the same logic, we can also get the details of a specific car model:

```julia
@linq cars |>
        where(:Model .== "Honda Civic")
```

```julia
1×12 DataFrame
 Row │ Model        MPG      Cyl    Disp     HP     DRat     WT       QSec     VS     AM     Gear   Carb  
     │ String       Float64  Int64  Float64  Int64  Float64  Float64  Float64  Int64  Int64  Int64  Int64 
─────┼────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ Honda Civic     30.4      4     75.7     52     4.93    1.615    18.52      1      1      4      2
```

If you want to have more than one condition, you can list all them together with a comma separating each condition.

```julia
@linq cars |>
        where(:Cyl .==4, :Gear .==5)
```

```julia
2×12 DataFrame
 Row │ Model          MPG      Cyl    Disp     HP     DRat     WT       QSec     VS     AM     Gear   Carb  
     │ String         Float64  Int64  Float64  Int64  Float64  Float64  Float64  Int64  Int64  Int64  Int64 
─────┼──────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ Porsche 914-2     26.0      4    120.3     91     4.43    2.14      16.7      0      1      5      2
   2 │ Lotus Europa      30.4      4     95.1    113     3.77    1.513     16.9      1      1      5      2
```

But suppose you want to have an OR logic between your conditions. 

```julia
@linq cars |>
        where( .|(:Cyl .==4, :Cyl .==6))
```

```julia
18×12 DataFrame
 Row │ Model           MPG      Cyl    Disp     HP     DRat     WT       QSec     VS     AM     Gear   Carb  
     │ String          Float64  Int64  Float64  Int64  Float64  Float64  Float64  Int64  Int64  Int64  Int64 
─────┼───────────────────────────────────────────────────────────────────────────────────────────────────────
   1 │ Mazda RX4          21.0      6    160.0    110     3.9     2.62     16.46      0      1      4      4
   2 │ Mazda RX4 Wag      21.0      6    160.0    110     3.9     2.875    17.02      0      1      4      4
   3 │ Datsun 710         22.8      4    108.0     93     3.85    2.32     18.61      1      1      4      1
   4 │ Hornet 4 Drive     21.4      6    258.0    110     3.08    3.215    19.44      1      0      3      1
   5 │ Valiant            18.1      6    225.0    105     2.76    3.46     20.22      1      0      3      1
  ⋮  │       ⋮            ⋮       ⋮       ⋮       ⋮       ⋮        ⋮        ⋮       ⋮      ⋮      ⋮      ⋮
  14 │ Fiat X1-9          27.3      4     79.0     66     4.08    1.935    18.9       1      1      4      1
  15 │ Porsche 914-2      26.0      4    120.3     91     4.43    2.14     16.7       0      1      5      2
  16 │ Lotus Europa       30.4      4     95.1    113     3.77    1.513    16.9       1      1      5      2
  17 │ Ferrari Dino       19.7      6    145.0    175     3.62    2.77     15.5       0      1      5      6
  18 │ Volvo 142E         21.4      4    121.0    109     4.11    2.78     18.6       1      1      4      2
                                                                                               8 rows omitted
```

- The `.|` before the `(  )` is broadcasting the OR operator to all the conditions within the `( )`.

But out of all the columns, if you are only interested in a subset of the columns in the data, you can use the `select()` function to choose the ones you are interested in. 

```julia
@linq cars |>
        where(:Cyl .!=4) |>
        select(:Model, :MPG)
```

```julia
21×2 DataFrame
 Row │ Model                MPG     
     │ String               Float64 
─────┼──────────────────────────────
   1 │ Mazda RX4               21.0
   2 │ Mazda RX4 Wag           21.0
   3 │ Hornet 4 Drive          21.4
   4 │ Hornet Sportabout       18.7
   5 │ Valiant                 18.1
  ⋮  │          ⋮              ⋮
  17 │ Camaro Z28              13.3
  18 │ Pontiac Firebird        19.2
  19 │ Ford Pantera L          15.8
  20 │ Ferrari Dino            19.7
  21 │ Maserati Bora           15.0
                     11 rows omitted
```

- Here we are saying, we only want to see the Model and MPG of the cars whose number of cylinders is anything but 4. 

You can also order the data using `orderby()` command. By default it will be in the ascending order. To list them in a descending way you can add `-`ve sign to the variable. 

```julia
@linq cars |>
        where(:Cyl .==4) |>
        select(:Model, :MPG) |>
        orderby(-:MPG)
```

```julia
11×2 DataFrame
 Row │ Model           MPG     
     │ String          Float64 
─────┼─────────────────────────
   1 │ Toyota Corolla     33.9
   2 │ Fiat 128           32.4
   3 │ Honda Civic        30.4
   4 │ Lotus Europa       30.4
   5 │ Fiat X1-9          27.3
   6 │ Porsche 914-2      26.0
   7 │ Merc 240D          24.4
   8 │ Datsun 710         22.8
   9 │ Merc 230           22.8
  10 │ Toyota Corona      21.5
  11 │ Volvo 142E         21.4
```

Sometimes in your data pre-processing, you have to create new meaningful variables from your dataset. This is called **feature engineering** and can be achieved with the help of `transform()` command in `DataFramesMeta`.

```julia
@linq cars |>
        transform(KPL = :MPG .* 0.425144) |>
        by(:Cyl, meanMPG = mean(:MPG))
```

```julia
3×2 DataFrame
 Row │ Cyl    meanMPG 
     │ Int64  Float64 
─────┼────────────────
   1 │     6  19.7429
   2 │     4  26.6636
   3 │     8  15.1
```

- For illustration, here we have created a new column called `KPL` (kilometers per liter).

`unstack` and `stack` are commands we use to reshape a data from wide format to long format and vice-versa.

```julia
unstack(cars,:Model,:Cyl,:MPG)
```

```julia
32×4 DataFrame
 Row │ Model              6          4          8
     │ String             Float64?   Float64?   Float64?  
─────┼────────────────────────────────────────────────────
   1 │ Mazda RX4               21.0  missing    missing   
   2 │ Mazda RX4 Wag           21.0  missing    missing   
   3 │ Datsun 710         missing         22.8  missing   
   4 │ Hornet 4 Drive          21.4  missing    missing   
   5 │ Hornet Sportabout  missing    missing         18.7
  ⋮  │         ⋮              ⋮          ⋮          ⋮
  28 │ Lotus Europa       missing         30.4  missing   
  29 │ Ford Pantera L     missing    missing         15.8
  30 │ Ferrari Dino            19.7  missing    missing   
  31 │ Maserati Bora      missing    missing         15.0
  32 │ Volvo 142E         missing         21.4  missing   
                                           22 rows omitted
```







