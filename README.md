<!-- README.md is generated from README.Rmd. Please edit that file -->
tidystringdist
==============

Compute string distance the tidy way. Built on top of the {stringdist} package.

Install tidystringdist
----------------------

``` r
devtools::install_github("ColinFay/tidystringdist")
```

tidystringdist basic workflow
-----------------------------

tidycomb
--------

First, you need to create a tibble with the combinations of words you want to compare. You can do this with the `tidy_comb` and `tidy_comb_all` functions. The first takes a base word and combines it with each elements of a list or a column of a data.frame, the 2nd combines all the possible couples from a list or a column.

If you already have a data.frame with two columns containing the strings to compare, you can skip this part.

``` r
library(tidystringdist)

tidy_comb_all(LETTERS[1:3])
#> # A tibble: 3 x 2
#>       V1     V2
#> * <fctr> <fctr>
#> 1      A      B
#> 2      A      C
#> 3      B      C
```

``` r
tidy_comb_all(iris, Species)
#> # A tibble: 3 x 2
#>           V1         V2
#> *     <fctr>     <fctr>
#> 1     setosa versicolor
#> 2     setosa  virginica
#> 3 versicolor  virginica
```

``` r
tidy_comb("Paris", state.name[1:3])
#> # A tibble: 3 x 2
#>        V1     V2
#> *  <fctr> <fctr>
#> 1 Alabama  Paris
#> 2  Alaska  Paris
#> 3 Arizona  Paris
```

### tidy\_string\_dist

Once you've got this data.frame, you can use `tidy_string_dist` to compute string distance. This function takes a data.frame, the two columns containing the strings, and a stringdist method.

Note that if you've used the `tidy_comb` function to create you data.frame, you won't need to set the column names.

``` r
library(dplyr)
data(starwars)
tidy_comb_sw <- tidy_comb_all(starwars, name)
tidy_stringdist(tidy_comb_sw, method = "jw")
#> # A tibble: 3,741 x 3
#>                V1                 V2 string_dist
#>  *         <fctr>             <fctr>       <dbl>
#>  1 Luke Skywalker              C-3PO   1.0000000
#>  2 Luke Skywalker              R2-D2   1.0000000
#>  3 Luke Skywalker        Darth Vader   0.5752165
#>  4 Luke Skywalker        Leia Organa   0.5335498
#>  5 Luke Skywalker          Owen Lars   0.4624339
#>  6 Luke Skywalker Beru Whitesun lars   0.4656085
#>  7 Luke Skywalker              R5-D4   1.0000000
#>  8 Luke Skywalker  Biggs Darklighter   0.5728291
#>  9 Luke Skywalker     Obi-Wan Kenobi   0.6349206
#> 10 Luke Skywalker   Anakin Skywalker   0.2816558
#> # ... with 3,731 more rows
```

The goal is to provide a convenient interface to work with other tools from the tidyverse.

``` r
tidy_stringdist(tidy_comb_sw, method= "osa") %>%
  filter(string_dist > 0.80) %>%
  arrange(desc(string_dist))
#> # A tibble: 3,741 x 3
#>                       V1                    V2 string_dist
#>                   <fctr>                <fctr>       <dbl>
#>  1                 C-3PO Jabba Desilijic Tiure          21
#>  2                 C-3PO Wicket Systri Warrick          21
#>  3                 R2-D2 Wicket Systri Warrick          21
#>  4                 R5-D4 Wicket Systri Warrick          21
#>  5 Jabba Desilijic Tiure                 IG-88          21
#>  6 Jabba Desilijic Tiure                 Cordé          21
#>  7 Jabba Desilijic Tiure                R4-P17          21
#>  8 Jabba Desilijic Tiure                   BB8          21
#>  9                 IG-88 Wicket Systri Warrick          21
#> 10 Wicket Systri Warrick                R4-P17          21
#> # ... with 3,731 more rows
```

``` r
starwars %>%
  filter(species == "Droid") %>%
  tidy_comb_all(name) %>%
  tidy_stringdist() %>% 
  filter(string_dist > 0.80) %>%
  arrange(desc(string_dist))
#> # A tibble: 10 x 3
#>        V1     V2 string_dist
#>    <fctr> <fctr>       <dbl>
#>  1  C-3PO  R2-D2           5
#>  2  C-3PO  R5-D4           5
#>  3  C-3PO  IG-88           5
#>  4  C-3PO    BB8           5
#>  5  R2-D2    BB8           5
#>  6  R5-D4    BB8           5
#>  7  R2-D2  IG-88           4
#>  8  R5-D4  IG-88           4
#>  9  IG-88    BB8           4
#> 10  R2-D2  R5-D4           2
```

### Contact

Questions and feedbacks [welcome](mailto:contact@colinfay.me) !
