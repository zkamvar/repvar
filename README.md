
<!-- README.md is generated from README.Rmd. Please edit that file -->
repvar
======

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental) [![Travis build status](https://travis-ci.org/zkamvar/repvar.svg?branch=master)](https://travis-ci.org/zkamvar/repvar) [![Coverage status](https://codecov.io/gh/zkamvar/repvar/branch/master/graph/badge.svg)](https://codecov.io/github/zkamvar/repvar?branch=master)

The goal of repvar is to find the minimum number of samples that will represent all variables in a data set. This was built for population genetic data, but is generalizable to any discrete data type that can be represented as an integer matrix.

Installation
------------

This package is not currently on CRAN, but you can install it like so:

``` r
# install.packages("remotes") # or devtools or ghit
remotes::install_github("zkamvar/repvar")
```

Example
-------

Here is a basic example of how you can identify the minimum set. We will use the pre-packaged `monilinia` data set from Everhart and Scherm 2016.

``` r
options(width = 120)

library("repvar")
data(monilinia)
dim(monilinia)
#> [1] 264  95
print.table(monilinia[1:10, 1:10], zero.print = ".")
#>      CHMFc4.224 CHMFc4.231 CHMFc4.238 CHMFc5.85 CHMFc5.97 CHMFc5.111 CHMFc5.105 CHMFc5.107 CHMFc5.113 CHMFc12.163
#> A004          1          .          .         1         .          .          .          .          .           1
#> A002          1          .          .         .         1          .          .          .          .           .
#> A011          1          .          .         .         1          .          .          .          .           .
#> A009          1          .          .         .         1          .          .          .          .           .
#> A006          1          .          .         .         1          .          .          .          .           .
#> A013          1          .          .         .         1          .          .          .          .           1
#> A008          1          .          .         .         .          1          .          .          .           1
#> A016          .          1          .         1         .          .          .          .          .           .
#> A012          .          1          .         1         .          .          .          .          .           1
#> A021          .          1          .         .         1          .          .          .          .           .

# Shuffle the data set 200 times to find an optimal number of samples
set.seed(2018)
id_list <- find_samples(monilinia, n = 200, cut = TRUE)
id_list
#> [[1]]
#>  [1] "A233" "A610" "A154" "A603" "A666" "A163" "A293" "A339" "A590" "A071" "A085" "A218" "A269" "A074" "A182" "A417"
#> [17] "A681" "A176" "A366" "A489" "A216" "A172" "A488" "A406" "A390" "A039" "A010" "A016" "A692" "A129"
#> 
#> [[2]]
#>  [1] "A233" "A610" "A154" "A603" "A666" "A163" "A293" "A339" "A590" "A071" "A085" "A218" "A269" "A074" "A182" "A417"
#> [17] "A681" "A176" "A367" "A489" "A191" "A172" "A488" "A408" "A390" "A404" "A387" "A016" "A692" "A571"
#> 
#> [[3]]
#>  [1] "A233" "A610" "A154" "A603" "A666" "A163" "A293" "A339" "A590" "A071" "A085" "A218" "A269" "A074" "A182" "A417"
#> [17] "A681" "A176" "A367" "A522" "A191" "A172" "A488" "A408" "A390" "A547" "A385" "A480" "A692" "A088"
lengths(id_list)
#> [1] 30 30 30
print.table(monilinia[id_list[[1]], 1:10], zero.print = ".")
#>      CHMFc4.224 CHMFc4.231 CHMFc4.238 CHMFc5.85 CHMFc5.97 CHMFc5.111 CHMFc5.105 CHMFc5.107 CHMFc5.113 CHMFc12.163
#> A233          .          1          .         .         .          .          .          1          .           1
#> A610          1          .          .         .         .          .          .          .          1           1
#> A154          .          1          .         .         1          .          .          .          .           1
#> A603          .          .          1         .         1          .          .          .          .           .
#> A666          .          1          .         .         1          .          .          .          .           .
#> A163          .          1          .         .         1          .          .          .          .           .
#> A293          1          .          .                                                                           .
#> A339          1          .          .         .         1          .          .          .          .           .
#> A590          .          1          .         .         1          .          .          .          .           1
#> A071          1          .          .         1         .          .          .          .          .           .
#> A085          1          .          .         .         1          .          .          .          .           1
#> A218          .          1          .         .         1          .          .          .          .           .
#> A269          .          1          .         .         1          .          .          .          .           1
#> A074          1          .          .         .         .          .          1          .          .           .
#> A182          .          1          .         .         1          .          .          .          .           .
#> A417          1          .          .         1         .          .          .          .          .           1
#> A681          .          1          .         .         1          .          .          .          .           1
#> A176          1          .          .         .         .          1          .          .          .           1
#> A366          1          .          .         .         1          .          .          .          .           .
#> A489          1          .          .         .         1          .          .          .          .           .
#> A216          .          1          .         .         1          .          .          .          .           .
#> A172          1          .          .         .         1          .          .          .          .           .
#> A488          .          1          .         .         1          .          .          .          .           1
#> A406          1          .          .         .         1          .          .          .          .           .
#> A390          1          .          .         1         .          .          .          .          .           1
#> A039          .          1          .         .         1          .          .          .          .           .
#> A010          .          .          1         .         1          .          .          .          .           .
#> A016          .          1          .         1         .          .          .          .          .           .
#> A692          1          .          .         .         1          .          .          .          .           1
#> A129          .          1          .         1         .          .          .          .          .           1
```

Because you get a list of ids, it's good to see which ones are actually useful. For this, you can calculate entropy. We will use the tidyverse to first create a table of samples and data, calculate entropy for each row, and then join them together. In general, we will want higher entropy values.

``` r
library("tibble")
library("dplyr")
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library("tidyr")
id_df <- tibble::enframe(id_list, name = "ID", value = "samples") %>%
  dplyr::rowwise() %>%
  dplyr::mutate(data = list(monilinia[samples, ]))
id_df
#> Source: local data frame [3 x 3]
#> Groups: <by row>
#> 
#> # A tibble: 3 x 3
#>      ID samples    data           
#>   <int> <list>     <list>         
#> 1     1 <chr [30]> <int [30 × 95]>
#> 2     2 <chr [30]> <int [30 × 95]>
#> 3     3 <chr [30]> <int [30 × 95]>

# Calculate entropy for each entry
dplyr::mutate(id_df, diversity = list(entropy(monilinia[samples, ]))) %>%
  dplyr::select(ID, diversity) %>%
  tidyr::unnest() %>%
  dplyr::inner_join(id_df, by = "ID")
#> # A tibble: 3 x 6
#>      ID    eH     G    E5 samples    data           
#>   <int> <dbl> <dbl> <dbl> <list>     <list>         
#> 1     1  55.2  39.7 0.714 <chr [30]> <int [30 × 95]>
#> 2     2  55.3  39.8 0.714 <chr [30]> <int [30 × 95]>
#> 3     3  54.7  39.1 0.708 <chr [30]> <int [30 × 95]>
```
