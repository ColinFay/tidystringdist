#' Tidy stringdist calculation
#'
#' @param df a dataframe containing the strings to compare
#' @param v1 the name of the first columns
#' @param v2 the name of the second columns
#' @param method one of the methods implemented in the stringdist package — "osa", "lv", "dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex". See \code{\link[stringdist]{stringdist-metrics}}
#'
#' @importFrom stringdist stringdist
#' @importFrom rlang quo_name enquo
#' @importFrom dplyr mutate
#' @importFrom purrr map_dfc
#'
#' @include utils.R
#'
#' @return a tibble with string distance
#' @export
#'
#' @examples
#' proust <- tidy_comb_all(c("Albertine", "Françoise", "Gilberte", "Odette", "Charles"))
#' tidy_stringdist(proust)


tidy_stringdist <- function(df, v1 = V1, v2 = V2, method = c("osa", "lv", "dl", "hamming", "lcs", "qgram",
                                                             "cosine", "jaccard", "jw", "soundex")) {
  assertthat::assert_that(all(method %in% c("osa", "lv", "dl", "hamming", "lcs", "qgram",
                                        "cosine", "jaccard", "jw", "soundex")),
                          msg = "One or more provided method(s) is not a strindist method")
  structure(cbind(df, map_dfc(method, ~tibble_dist(df, v1 = V1, v2 = V2, method = .x ))),
            class = c("tbl_df", "tbl", "data.frame"))
}


