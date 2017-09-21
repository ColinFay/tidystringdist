## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE--------------------------------------------------------
#  devtools::install_github("ColinFay/tidystringdist")

## ------------------------------------------------------------------------
library(tidystringdist)

tidy_comb_all(LETTERS[1:3])

## ------------------------------------------------------------------------
tidy_comb_all(iris, Species)

## ------------------------------------------------------------------------
tidy_comb("Paris", state.name[1:3])

## ----example, warnings = FALSE, error=FALSE, message=FALSE---------------
library(dplyr)
data(starwars)
tidy_comb_sw <- tidy_comb_all(starwars, name)
tidy_stringdist(tidy_comb_sw, method = "jw")

## ------------------------------------------------------------------------
tidy_stringdist(tidy_comb_sw, method= "osa") %>%
  filter(string_dist > 20) %>%
  arrange(desc(string_dist))

## ------------------------------------------------------------------------
starwars %>%
  filter(species == "Droid") %>%
  tidy_comb_all(name) %>%
  tidy_stringdist() %>% 
  filter(string_dist > 2) %>%
  arrange(desc(string_dist))

