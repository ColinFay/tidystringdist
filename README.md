<!-- README.md is generated from README.Rmd. Please edit that file -->
tidystringdist
==============

Compute string distance the tidy way. Built on top of the {stringdist} package.

tidystringdist basics
---------------------

``` r
library(tidystringdist)
library(dplyr)
data(starwars)
tidy_stringdist(starwars$name,method= "osa")
#> # A tibble: 3,741 x 3
#>                V1                 V2 string_dist
#>  *         <fctr>             <fctr>      <list>
#>  1 Luke Skywalker              C-3PO   <dbl [1]>
#>  2 Luke Skywalker              R2-D2   <dbl [1]>
#>  3 Luke Skywalker        Darth Vader   <dbl [1]>
#>  4 Luke Skywalker        Leia Organa   <dbl [1]>
#>  5 Luke Skywalker          Owen Lars   <dbl [1]>
#>  6 Luke Skywalker Beru Whitesun lars   <dbl [1]>
#>  7 Luke Skywalker              R5-D4   <dbl [1]>
#>  8 Luke Skywalker  Biggs Darklighter   <dbl [1]>
#>  9 Luke Skywalker     Obi-Wan Kenobi   <dbl [1]>
#> 10 Luke Skywalker   Anakin Skywalker   <dbl [1]>
#> # ... with 3,731 more rows
```

The goal is to provide a convenient interface to work with other tools from the tidyverse.

``` r
tidy_stringdist(starwars$name,method= "jaccard") %>%
  filter(string_dist > 0.80)
#> # A tibble: 1,926 x 3
#>                V1             V2 string_dist
#>            <fctr>         <fctr>      <list>
#>  1 Luke Skywalker          C-3PO   <dbl [1]>
#>  2 Luke Skywalker          R2-D2   <dbl [1]>
#>  3 Luke Skywalker          R5-D4   <dbl [1]>
#>  4 Luke Skywalker Obi-Wan Kenobi   <dbl [1]>
#>  5 Luke Skywalker         Greedo   <dbl [1]>
#>  6 Luke Skywalker Wedge Antilles   <dbl [1]>
#>  7 Luke Skywalker           Yoda   <dbl [1]>
#>  8 Luke Skywalker      Palpatine   <dbl [1]>
#>  9 Luke Skywalker      Boba Fett   <dbl [1]>
#> 10 Luke Skywalker          IG-88   <dbl [1]>
#> # ... with 1,916 more rows
```

tidycomb
--------

The tidycomb function creates a tibble with all possible combinations from a list :

``` r
tidy_comb(vec = LETTERS[1:5])
#> # A tibble: 10 x 2
#>        V1     V2
#>  * <fctr> <fctr>
#>  1      A      B
#>  2      A      C
#>  3      A      D
#>  4      A      E
#>  5      B      C
#>  6      B      D
#>  7      B      E
#>  8      C      D
#>  9      C      E
#> 10      D      E
```
