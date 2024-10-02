
<!-- README.md is generated from README.Rmd. Please edit that file -->

# nhtsr

<!-- badges: start -->
<!-- badges: end -->

The goal of `nhtsr` is to make it considerably easier for R users to
interact with NHTS 2017 and 2022 datasets. The package contains eight
datasets:

- `nhts_households` and `nhts22_households`
- `nhts_persons` and `nhts22_persons`
- `nhts_vehicles` and `nhts22_vehicles`
- `nhts_trips` and `nhts22_trips`

### Citation:

From ORNL website:

> To recognize the valuable role of National Household Travel Survey
> (NHTS) data in the transportation research process and to facilitate
> repeatability of the research, users of NHTS data are asked to
> formally acknowledge the data source. Where possible, this
> acknowledgment should take place in the form of a formal citation,
> such as when writing a research report, planning document, on-line
> article, and other publications. The citation can be formatted as
> follows:

    U.S. Department of Transportation, Federal Highway Administration, 2022
    National Household Travel Survey. URL: http://nhts.ornl.gov.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("byu-transpolab/nhts2017")
```

## Example

Each of the datasets is a properly data-typed `tibble`, derived from the
`SPSS` files distributed by [Oak Ridge National
Laboratory](https://nhts.ornl.gov/). The variables have attribute labels
that appear in RStudio’s data set viewer, and factor variables have
correct labels appended.

For instance, to count the number of households completing records for
each day, we can simply do

``` r
library(nhtsr)
library(haven)
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.4
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ ggplot2   3.5.1     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.2     ✔ tidyr     1.3.1
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

nhts_households %>%
  group_by(travday) %>%
  summarise(
    count = n(),
    weighted = sum(wthhfin)
  )
#> # A tibble: 7 × 3
#>   travday        count  weighted
#>   <chr+lbl>      <int>     <dbl>
#> 1 01 [Sunday]    14479 16886890.
#> 2 02 [Monday]    20045 16886895.
#> 3 03 [Tuesday]   20197 16886892.
#> 4 04 [Wednesday] 20149 16886895.
#> 5 05 [Thursday]  20484 16886894.
#> 6 06 [Friday]    20227 16886890.
#> 7 07 [Saturday]  14115 16886895.
```

In one departure from the NHTS public data files, the datasets are
`tidy` in that each field appears only once in the dataset. E.g., the
`msasize` variable — indicating the size of the metropolitan area each
household resides in — is only appended to the `nhts_households` tibble
rather than to all four tibbles. Joining is trivial, however.

``` r
nhts22_trips |> 
  left_join(nhts22_households, by = "houseid") |> 
  group_by(msasize) |> 
  summarise(
    mean_trip_length = weighted.mean(trpmiles, wttrdfin)
  )
#> # A tibble: 6 × 2
#>   msasize                                         mean_trip_length
#>   <chr+lbl>                                                  <dbl>
#> 1 01 [In an MSA of Less than 250,000]                         12.6
#> 2 02 [In an MSA of 250,000 - 499,999]                         12.6
#> 3 03 [In an MSA of 500,000 - 999,999]                         11.2
#> 4 04 [In an MSA or CMSA of 1,000,000 - 2,999,999]             12.9
#> 5 05 [In an MSA or CMSA of 3 million or more]                 12.5
#> 6 06 [Not in MSA or CMSA]                                     15.3
```

Additionally, the `strttime` and `endtime` fields on the trips data have
been converted from four-character strings (e.g. `1310` for 1:10 PM)
into R `datetime` objects. This required setting a date, which was
arbitrarily chosen to be an appropriate weekday in October 2017 or
October 2022

``` r
ggplot(nhts_trips, aes(x = strttime)) + 
  geom_histogram()
#> `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="man/figures/README-strttime-1.png" width="100%" />
