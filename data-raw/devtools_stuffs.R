# Devtools

library(devtools)

# init stuffs
use_code_of_conduct()
use_mit_license()
use_news_md()
use_readme_rmd()
use_testthat()
use_travis()

#init tests
devtools::use_testthat()
devtools::use_test("tidy_comb")
devtools::use_test("tidy_string_dist")

# package dependencies

devtools::use_package("purrr")
devtools::use_package("stringdist")
devtools::use_package("rlang")
devtools::use_package("tidyr")
devtools::use_package("magrittr")
devtools::use_package("purrr")
devtools::use_package("assertthat")

# Vignette

devtools::use_vignette("Getting_started")
build_vignettes()

# run tests

test()
build_win()
check()

# Roxygen

roxygen2::roxygenise()
