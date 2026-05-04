## Resubmission

Following the CRAN team's request, the ORCID entries in the `Authors@R`
field of the DESCRIPTION file have been changed from
`comment = structure("....", .Names = "ORCID")` to the recommended
`comment = c(ORCID = "....")` form.

The `if (class(a) == "factor")` checks in `R/tidycomb.R` have also been
replaced with `inherits(a, "factor")` to address the related NOTE.
