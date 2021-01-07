@def title = "Getting Data"
@def hascode = true

@def rss_title = "Getting Data"
@def rss_pubdate = Date(2019, 5, 1)

@def tags = ["syntax", "code", "image"]

# Getting the data 

Though we will be mostly using toy datasets from `RDatasets`, you are encouraged to explore and fiddle with publicly available open datasets for your own learning and for your class project. Some of the data repositories you should checkout are:

- [Kaggle](https://www.kaggle.com/datasets): For all sorts of datasets.
-  [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets.php?task=cla&area=&type=&view=table): For all sorts of datasets.
- [UCLA Library](https://guides.library.ucla.edu/c.php?g=180221&p=1188487) : For Psychological datasets.  
- [CMU DataShop](https://pslcdatashop.web.cmu.edu/): For Educational & Psychological datasets. 
- [CRCN](https://crcns.org/data-sets): For Neuroscience datasets.
- [OpenNeuro](https://openneuro.org/public/datasets): For Neuroscience datasets 
- [RDatasets](https://github.com/JuliaStats/RDatasets.jl): A collection of common datasets used in all Statistical/ Machine Learning textbooks 

Once you have found a dataset, the first step in your Machine Learning programing workflow is to get the data into your work environment. Either the dataset came with a package, or you found a dataset from a repository like the UCI Machine Learning Repository, or you already have them in your computer. Here we  describe how you can load the datasets in each of the mentioned scenarios. 

## From URLs

Suppose the data you wanted to use is available in a `.csv` format in a public domain like this [https://gist.githubusercontent.com/curran/a08a1080b88344b0c8a7/raw/0e7a9b0a5d22642a06d3d5b9bcbad9890c8ee534/iris.csv](https://gist.githubusercontent.com/curran/a08a1080b88344b0c8a7/raw/0e7a9b0a5d22642a06d3d5b9bcbad9890c8ee534/iris.csv)  

The following code will help you to download the URL to your current working directory:

```julia
url = "https://gist.githubusercontent.com/curran/a08a1080b88344b0c8a7/raw/0e7a9b0a5d22642a06d3d5b9bcbad9890c8ee534/iris.csv"
dataname = "iris.csv" # Here you can give any name you wish instead of iris 
download(url, dataname)
```

```julia
"iris.csv"
```



### :mag: Useful Tip

If in case you forgot your current working directory (where the above code will be downloading the dataset into), you just can run the following code and it will print your current working directory.

```julia
pwd()
```

```julia
"C:\\Users\\BBS"
```

:point_up_2: ​In this case, Julia is telling us that we are at file location  `C:\Users\BBS`

## From Your Computer 

Suppose you downloaded the dataset using the above step or you already had the dataset in your current working directory. Then you can load the dataset into your Julia environment using the following code: 

```julia
using CSV # This is a pacakge we use for loading CSV Files.
using DataFrames
```

 @@colbox-blue :mag:  If you haven't installed the package, you can check the [*Software Setup*](/software-setup/#installing_julia_packages) page to learn how to install packages in Julia. @@

```julia
data = CSV.read("iris.csv", DataFrame) # This will load the dataset and convert it into a DataFrame
```

```julia
150×5 DataFrame
 Row │ sepal_length  sepal_width  petal_length  petal_width  species   
     │ Float64       Float64      Float64       Float64      String    
─────┼─────────────────────────────────────────────────────────────────
   1 │          5.1          3.5           1.4          0.2  setosa
   2 │          4.9          3.0           1.4          0.2  setosa
   3 │          4.7          3.2           1.3          0.2  setosa
   4 │          4.6          3.1           1.5          0.2  setosa
   5 │          5.0          3.6           1.4          0.2  setosa
  ⋮  │      ⋮             ⋮            ⋮             ⋮           ⋮
 146 │          6.7          3.0           5.2          2.3  virginica
 147 │          6.3          2.5           5.0          1.9  virginica
 148 │          6.5          3.0           5.2          2.0  virginica
 149 │          6.2          3.4           5.4          2.3  virginica
 150 │          5.9          3.0           5.1          1.8  virginica
                                                       140 rows omitted
```



## From Packages 

Sometimes  you want toy datasets to develop the "proof-of-concept" code or check your algorithms. In that case,`Rdatasets` is a good starting point. 

The `RDatasets` comes with the `Iris` data, and the following code will illustrate how to load them into your Julia environment. 

```julia
using RDatasets 
data = dataset("datasets", "iris")
```

```julia
150×5 DataFrame
 Row │ sepal_length  sepal_width  petal_length  petal_width  species   
     │ Float64       Float64      Float64       Float64      String    
─────┼─────────────────────────────────────────────────────────────────
   1 │          5.1          3.5           1.4          0.2  setosa
   2 │          4.9          3.0           1.4          0.2  setosa
   3 │          4.7          3.2           1.3          0.2  setosa
   4 │          4.6          3.1           1.5          0.2  setosa
   5 │          5.0          3.6           1.4          0.2  setosa
  ⋮  │      ⋮             ⋮            ⋮             ⋮           ⋮
 146 │          6.7          3.0           5.2          2.3  virginica
 147 │          6.3          2.5           5.0          1.9  virginica
 148 │          6.5          3.0           5.2          2.0  virginica
 149 │          6.2          3.4           5.4          2.3  virginica
 150 │          5.9          3.0           5.1          1.8  virginica
                                                       140 rows omitted
```





