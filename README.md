
# pottR

<!-- badges: start -->

<!-- badges: end -->

# pottR <img src="man/figures/logo.png" align="right" height="139" alt="Hex logo for the pottR package. The hex contains a flat-colour image of the author's forehead, eyes, and glasses, with the R logo overlaid." />

**pottR** is a personal utility package that brings together functions I
regularly use in my work—primarily for data summarisation, presentation,
and formatting.

The aim of this package is twofold:  
- To simplify repetitive workflows in my day-to-day R projects.  
- To build confidence and familiarity with R package development best
practices.

------------------------------------------------------------------------

## Installation

You can install the development version of **pottR** directly from
GitHub:

``` r
# Install devtools if not already installed
# install.packages("devtools")

devtools::install_github("jasonpott/pottR")
usethis::use_logo("pottr_hex.png")
```

------------------------------------------------------------------------

## Example

Below is an example showing several utility functions in action, applied
to the built-in `mtcars` dataset.

``` r
library(pottR)
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(gt)

mtcars |>
  group_by(cyl) |>
  summarise(
    mileage = pottR::mean_sd(mpg),
    med_disp = pottR::med_iqr(disp),
    pro_with_more_than_3_gears = pottR::prop_n_greater(
      variable = gear,
      value_of_interest = 3,
      rounding_value = 1
    ),
    pro_with_3_gears = pottR::prop_n(
      variable = gear,
      value_of_interest = 3,
      rounding_value = 1
    )
  )
#> # A tibble: 3 × 5
#>     cyl mileage                 med_disp pro_with_more_than_3…¹ pro_with_3_gears
#>   <dbl> <chr>                   <chr>    <chr>                  <chr>           
#> 1     4 26.6636363636364  ( 4.… 108  [ … 100% (n =11)           9.1% (n = 1)    
#> 2     6 19.7428571428571  ( 1.… 167.6  … 100% (n =7)            28.6% (n = 2)   
#> 3     8 15.1  ( 2.560048076471… 350.5  … 100% (n =14)           85.7% (n = 12)  
#> # ℹ abbreviated name: ¹​pro_with_more_than_3_gears
```

------------------------------------------------------------------------

## License

MIT © Jason Pott
