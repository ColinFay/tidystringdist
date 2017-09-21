#' Tidy stringdist calculation
#'
#' @param df a dataframe containing the strings to compare
#' @param v1 the name of the first columns
#' @param v2 the name of the second columns
#' @param method one of the methods implemented in the stringdist package — "osa", "lv", "dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex". See \code{\link[stringdist]{stringdist-metrics}}
#'
#' @importFrom stringdist stringdist
#' @importFrom purrr map2
#' @importFrom rlang quo_name enquo
#' @importFrom tidyr unnest
#'
#' @return a tibble with string distance
#' @export
#'
#' @examples
#' proust <- tidy_comb_all(c("Albertine", "Françoise", "Gilberte", "Odette", "Charles"))
#' tidy_stringdist(proust, method= "jw")


tidy_stringdist <- function(df, v1 = V1, v2 = V2, method = c("osa", "lv", "dl", "hamming", "lcs", "qgram",
                                             "cosine", "jaccard", "jw", "soundex")) {
  v1 <- rlang::quo_name(rlang::enquo(v1))
  v2 <- rlang::quo_name(rlang::enquo(v2))
  df$string_dist <- purrr::map2_dbl(.x = df[[v1]], .y = df[[v2]], .f = stringdist::stringdist, method)
  df <- tidyr::unnest(df)
  structure(df, class = c("tbl_df", "tbl", "data.frame"))
}

