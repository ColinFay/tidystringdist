#' tidy_comb
#'
#' @param vec a list of elements to combine
#'
#' @importFrom utils combn
#'
#' @return a tibble with all possible combination of a list
#' @export
#'
#' @examples
#' tidy_comb(vec = LETTERS[1:5])

tidy_comb <- function(vec) {
  a <- as.data.frame(t(combn(vec, 2)))
  structure(a, class = c("tbl_df", "tbl", "data.frame"))
}
