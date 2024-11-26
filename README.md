<<<<<<< HEAD

<!-- README.md is generated from README.Rmd. Please edit that file -->

# wnbaherstory R Package <img src="data-raw/wnba.png" align="right" height="139"/>

<!-- badges: start -->
<!-- badges: end -->

## Overview

The goal of wnbaherstory is to provide historical data on the WNBA.
Users can discover past and present WNBA teams, player history, player
awards, game attendance and more.

## Installation

You can install the development version of wnbaherstory from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("sds270-f24/wnbaherstory")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
#library(wnbaherstory)
#map_WNBA_teams(year_range = 1997:2024)
```

``` r
library(wnbaherstory)
storm_win_rate <- winRate("Seattle Storm")
cat("Seattle Storm Winning Percentage:", storm_win_rate, "%\n")
#> Seattle Storm Winning Percentage: 52.60664 %
```

## See Also

Basketball Reference: The primary source of data for this package.
tidygeocoder: Used for geocoding team locations. ggplot2: Visualization
tool for mapping.

## Contributors

- [Jane Loo](https://github.com/janeloo10)
- [Ella Sylvester](https://github.com/esylvester04)
- [Alina Abdulina](https://github.com/AlinaAbdulina)
=======
# wnbar
WNBA package showing historical trends
>>>>>>> c3608f6ef3c9cbf29730d1e4518c0bc79516aa52
