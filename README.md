<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Coverage
Status](https://img.shields.io/codecov/c/github/ColinFay/tidystringdist/master.svg)](https://codecov.io/github/ColinFay/tidystringdist?branch=master)

[![Travis-CI Build
Status](https://travis-ci.org/ColinFay/tidystringdist.svg?branch=master)](https://travis-ci.org/ColinFay/tidystringdist)

tidystringdist
==============

Compute string distance the tidy way. Built on top of the ‘stringdist’
package.

Install tidystringdist
----------------------

You’ll get the dev version on:

``` r
devtools::install_github("ColinFay/tidystringdist")
```

Stable version is available with :

``` r
install.packages("tidystringdist")
```

tidystringdist basic workflow
-----------------------------

tidycomb
--------

First, you need to create a tibble with the combinations of words you
want to compare. You can do this with the `tidy_comb` and
`tidy_comb_all` functions. The first takes a base word and combines it
with each elements of a list or a column of a data.frame, the 2nd
combines all the possible couples from a list or a column.

If you already have a data.frame with two columns containing the strings
to compare, you can skip this part.

``` r
library(tidystringdist)

tidy_comb_all(LETTERS[1:3])
#> # A tibble: 3 x 2
#>      V1    V2
#> * <chr> <chr>
#> 1     A     B
#> 2     A     C
#> 3     B     C
```

``` r
tidy_comb_all(iris, Species)
#> # A tibble: 3 x 2
#>           V1         V2
#> *      <chr>      <chr>
#> 1     setosa versicolor
#> 2     setosa  virginica
#> 3 versicolor  virginica
```

``` r
tidy_comb("Paris", state.name[1:3])
#> # A tibble: 3 x 2
#>        V1    V2
#> *   <chr> <chr>
#> 1 Alabama Paris
#> 2  Alaska Paris
#> 3 Arizona Paris
```

### tidy\_string\_dist

Once you’ve got this data.frame, you can use `tidy_string_dist` to
compute string distance. This function takes a data.frame, the two
columns containing the strings, and a stringdist method.

Note that if you’ve used the `tidy_comb` function to create you
data.frame, you won’t need to set the column names.

``` r
library(dplyr)
data(starwars)
tidy_comb_sw <- tidy_comb_all(starwars, name)
tidy_stringdist(tidy_comb_sw)
#> Warning in do_dist(a = b, b = a, method = method, weight = weight, maxDist
#> = maxDist, : Non-printable ascii or non-ascii characters in soundex.
#> Results may be unreliable. See ?printable_ascii.
#> # A tibble: 3,741 x 12
#>                V1                 V2   osa    lv    dl hamming   lcs qgram
#>  *          <chr>              <chr> <dbl> <dbl> <dbl>   <dbl> <dbl> <dbl>
#>  1 Luke Skywalker              C-3PO    14    14    14     Inf    19    19
#>  2 Luke Skywalker              R2-D2    14    14    14     Inf    19    19
#>  3 Luke Skywalker        Darth Vader    11    11    11     Inf    17    17
#>  4 Luke Skywalker        Leia Organa    11    11    11     Inf    17    15
#>  5 Luke Skywalker          Owen Lars    12    12    12     Inf    15    11
#>  6 Luke Skywalker Beru Whitesun lars    16    16    16     Inf    22    18
#>  7 Luke Skywalker              R5-D4    14    14    14     Inf    19    19
#>  8 Luke Skywalker  Biggs Darklighter    13    13    13     Inf    21    19
#>  9 Luke Skywalker     Obi-Wan Kenobi    14    14    14      14    24    22
#> 10 Luke Skywalker   Anakin Skywalker     5     5     5     Inf     8     8
#> # ... with 3,731 more rows, and 4 more variables: cosine <dbl>,
#> #   jaccard <dbl>, jw <dbl>, soundex <dbl>
```

Default call compute all the methods. You can use specific method with
the `method` argument:

``` r
tidy_stringdist(tidy_comb_sw, method = c("osa","jw"))
#> # A tibble: 3,741 x 4
#>                V1                 V2   osa        jw
#>  *          <chr>              <chr> <dbl>     <dbl>
#>  1 Luke Skywalker              C-3PO    14 1.0000000
#>  2 Luke Skywalker              R2-D2    14 1.0000000
#>  3 Luke Skywalker        Darth Vader    11 0.5752165
#>  4 Luke Skywalker        Leia Organa    11 0.5335498
#>  5 Luke Skywalker          Owen Lars    12 0.4624339
#>  6 Luke Skywalker Beru Whitesun lars    16 0.4656085
#>  7 Luke Skywalker              R5-D4    14 1.0000000
#>  8 Luke Skywalker  Biggs Darklighter    13 0.5728291
#>  9 Luke Skywalker     Obi-Wan Kenobi    14 0.6349206
#> 10 Luke Skywalker   Anakin Skywalker     5 0.2816558
#> # ... with 3,731 more rows
```

Tidyverse workflow
------------------

The goal is to provide a convenient interface to work with other tools
from the tidyverse.

``` r
tidy_stringdist(tidy_comb_sw, method= "osa") %>%
  filter(osa > 20) %>%
  arrange(desc(osa))
#> # A tibble: 11 x 3
#>                       V1                    V2   osa
#>                    <chr>                 <chr> <dbl>
#>  1                 C-3PO Jabba Desilijic Tiure    21
#>  2                 C-3PO Wicket Systri Warrick    21
#>  3                 R2-D2 Wicket Systri Warrick    21
#>  4                 R5-D4 Wicket Systri Warrick    21
#>  5 Jabba Desilijic Tiure                 IG-88    21
#>  6 Jabba Desilijic Tiure                 Cordé    21
#>  7 Jabba Desilijic Tiure                R4-P17    21
#>  8 Jabba Desilijic Tiure                   BB8    21
#>  9                 IG-88 Wicket Systri Warrick    21
#> 10 Wicket Systri Warrick                R4-P17    21
#> 11 Wicket Systri Warrick                   BB8    21
```

``` r
starwars %>%
  filter(species == "Droid") %>%
  tidy_comb_all(name) %>%
  tidy_stringdist() %>% 
  summarise_if(is.numeric, mean)
#> # A tibble: 1 x 10
#>     osa    lv    dl hamming   lcs qgram    cosine   jaccard        jw
#>   <dbl> <dbl> <dbl>   <dbl> <dbl> <dbl>     <dbl>     <dbl>     <dbl>
#> 1   4.4   4.4   4.4     Inf   7.4   7.4 0.8304896 0.8671032 0.6422222
#> # ... with 1 more variables: soundex <dbl>
```

### Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me)!
