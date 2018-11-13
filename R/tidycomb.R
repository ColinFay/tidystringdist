#' Tidy combine
#'
#' Get all combinations from a dataframe column or from a list
#'
#' @param data data object containing the list of words, either a list or a data.frame
#' @param base the base word to compare with all the words
#' @param ... if data is a data.frame, the col where the words to combine are
#'
#' @importFrom utils combn
#' @importFrom rlang quo_name quo
#'
#' @return a tibble with all possible combination of elements from a list
#' @export
#'
#' @examples
#' tidy_comb(iris, "this", Species)
#' tidy_comb(state.name, "Paris")

tidy_comb <- function(data, base, ...){
  UseMethod("tidy_comb")
}

#' @rdname tidy_comb
#' @export

tidy_comb.data.frame <- function(data, base, ...) {
  col <- quo_name(quo(...))
  a <- data[[col]]
  if (class(a) == "factor"){
    a <- as.character(a)
  }
  ret <- data.frame(V1 = base, V2 = unique(a), stringsAsFactors = FALSE)
  structure(ret, class = c("tbl_df", "tbl", "data.frame"))
}

#' @rdname tidy_comb
#' @export


tidy_comb.default <- function(data, base,...) {
  ret <- data.frame(V1 = base, V2 = data, stringsAsFactors = FALSE)
  structure(ret, class = c("tbl_df", "tbl", "data.frame"))
}


#' Tidy combine all
#'
#' Get all combinations from a dataframe column
#'
#' @param data a list or a data.frame with the elements to combine
#' @param ... if data is a data.frame, the col where the words to combine are
#'
#' @return a tibble with all possible combination of elements from a list
#' @export
#'
#' @examples
#' tidy_comb_all(iris, Species)
#' tidy_comb_all(state.name)
#'

tidy_comb_all <- function(data,...){
  UseMethod("tidy_comb_all")
}

#' @rdname tidy_comb_all
#' @export
#' @importFrom utils combn
#' @importFrom rlang quo_name

tidy_comb_all.data.frame <- function(data, ...) {
  col <- quo_name(quo(...))
  a <- data[[col]]
  if (class(a) == "factor"){
    a <- as.character(a)
  }
  a <- as.data.frame(t(combn(unique(a), 2)), stringsAsFactors = FALSE)
  structure(a, class = c("tbl_df", "tbl", "data.frame"))
}

#' @rdname tidy_comb_all
#' @export
#' @importFrom utils combn
#' @importFrom rlang quo_name

tidy_comb_all.default <- function(data, ...) {
  a <- as.data.frame(t(combn(data, 2)), stringsAsFactors = FALSE)
  structure(a, class = c("tbl_df", "tbl", "data.frame"))
}

