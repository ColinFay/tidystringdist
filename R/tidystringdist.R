#' Tidy stringdist calculation
#'
#' @param df a dataframe containing the strings to compare
#' @param v1 the name of the first columns
#' @param v2 the name of the second columns
#' @param method one of the methods implemented in the stringdist package — "osa", "lv", "dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex". See \code{\link[stringdist]{stringdist-metrics}}
#' @param ... other parameters passed to \code{\link[stringdist]{stringdist}}
#'
#' @importFrom stringdist stringdist
#' @importFrom rlang quo_name enquo enquos
#' @importFrom attempt stop_if_not
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
                                                             "cosine", "jaccard", "jw", "soundex"),...) {

  v1 <- enquo(v1)
  v2 <- enquo(v2)
  a <- all(method %in% c("osa", "lv", "dl", "hamming", "lcs", "qgram",
                    "cosine", "jaccard", "jw", "soundex"))
  stop_if_not(a, msg = "One or more provided method(s) is not a stringdist method")

  tmp_df <- lapply(method, function(.x, ...) tibble_dist(df, v1 = !!v1, v2 = !!v2, method = .x, ...),...)
  tmp_df <- do.call(cbind, tmp_df)
  structure(cbind(df, tmp_df),
            class = c("tbl_df", "tbl", "data.frame"))
}


