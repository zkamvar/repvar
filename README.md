
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
id_list <- replicate(200, get_minimum_set(monilinia[sample(nrow(monilinia)), ]))
nsamps  <- lengths(id_list)
prime_ids <- id_list[nsamps == min(nsamps)]
print.table(monilinia[prime_ids[[1]], 1:10], zero.print = ".")
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
