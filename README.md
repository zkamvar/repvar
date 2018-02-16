
<!-- README.md is generated from README.Rmd. Please edit that file -->
repvar
======

[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

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
monilinia[1:10, 1:10]
#>      CHMFc4.224 CHMFc4.231 CHMFc4.238 CHMFc5.85 CHMFc5.97 CHMFc5.111 CHMFc5.105 CHMFc5.107 CHMFc5.113 CHMFc12.163
#> A004          1          0          0         1         0          0          0          0          0           1
#> A002          1          0          0         0         1          0          0          0          0           0
#> A011          1          0          0         0         1          0          0          0          0           0
#> A009          1          0          0         0         1          0          0          0          0           0
#> A006          1          0          0         0         1          0          0          0          0           0
#> A013          1          0          0         0         1          0          0          0          0           1
#> A008          1          0          0         0         0          1          0          0          0           1
#> A016          0          1          0         1         0          0          0          0          0           0
#> A012          0          1          0         1         0          0          0          0          0           1
#> A021          0          1          0         0         1          0          0          0          0           0

# extract minimum set of samples
(i <- get_minimum_set(monilinia))
#>  [1] 136 244  93 242 253 102 147 152 239  48  62 133 140  51 121 180 256   7 157 115 199 127 111 166 175 163  36  21   8
#> [30] 169  31  65   9
monilinia[i, 1:10]
#>      CHMFc4.224 CHMFc4.231 CHMFc4.238 CHMFc5.85 CHMFc5.97 CHMFc5.111 CHMFc5.105 CHMFc5.107 CHMFc5.113 CHMFc12.163
#> A233          0          1          0         0         0          0          0          1          0           1
#> A610          1          0          0         0         0          0          0          0          1           1
#> A154          0          1          0         0         1          0          0          0          0           1
#> A603          0          0          1         0         1          0          0          0          0           0
#> A666          0          1          0         0         1          0          0          0          0           0
#> A163          0          1          0         0         1          0          0          0          0           0
#> A293          1          0          0        NA        NA         NA         NA         NA         NA           0
#> A339          1          0          0         0         1          0          0          0          0           0
#> A590          0          1          0         0         1          0          0          0          0           1
#> A071          1          0          0         1         0          0          0          0          0           0
#> A085          1          0          0         0         1          0          0          0          0           1
#> A218          0          1          0         0         1          0          0          0          0           0
#> A269          0          1          0         0         1          0          0          0          0           1
#> A074          1          0          0         0         0          0          1          0          0           0
#> A182          0          1          0         0         1          0          0          0          0           0
#> A417          1          0          0         1         0          0          0          0          0           1
#> A681          0          1          0         0         1          0          0          0          0           1
#> A008          1          0          0         0         0          1          0          0          0           1
#> A366          1          0          0         0         1          0          0          0          0           0
#> A176          1          0          0         0         0          1          0          0          0           1
#> A489          1          0          0         0         1          0          0          0          0           0
#> A191          0          1          0         0         1          0          0          0          0           0
#> A172          1          0          0         0         1          0          0          0          0           0
#> A394          0          1          0         0         1          0          0          0          0           0
#> A406          1          0          0         0         1          0          0          0          0           0
#> A390          1          0          0         1         0          0          0          0          0           1
#> A039          0          1          0         0         1          0          0          0          0           0
#> A010          0          0          1         0         1          0          0          0          0           0
#> A016          0          1          0         1         0          0          0          0          0           0
#> A398          1          0          0         0         1          0          0          0          0           0
#> A034          0          1          0         0         1          0          0          0          0          NA
#> A088          1          0          0         0         1          0          0          0          0           1
#> A012          0          1          0         1         0          0          0          0          0           1
```
