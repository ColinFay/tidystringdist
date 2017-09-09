#' Tidy stringdist calculation
#'
#' @param list a list of strings to compare
#' @param method one of the methods implemented in the stringdist package — "osa", "lv", "dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex". See \code{\link[stringdist]{stringdist-metrics}}
#'
#' @importFrom  stringdist stringdist
#' @importFrom purrr map2
#'
#' @return a tibble with string distance
#' @export
#'
#' @examples
#' proust <- c("Albertine", "Françoise", "Gilberte", "Odette", "Charles")
#' tidy_stringdist(proust,method= "osa")


tidy_stringdist <- function(list, method = c("osa", "lv", "dl", "hamming", "lcs", "qgram",
                                             "cosine", "jaccard", "jw", "soundex")) {
  df <- tidy_comb(list)
  df$string_dist <- purrr::map2(.x = df$V1, .y = df$V2, .f = stringdist, method)
  structure(df, class = c("tbl_df", "tbl", "data.frame"))
}

