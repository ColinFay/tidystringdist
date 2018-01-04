#' @importFrom stringdist stringdist
#' @importFrom rlang quo_name enquo
#' @importFrom dplyr tibble
#'
tibble_dist <- function(df, v1 = V1, v2 = V2, method){
  col_name <- enquo(method)
  str_dist <- stringdist(df[[quo_name(enquo(v1))]],
                         df[[quo_name(enquo(v2))]],
                         method)
  tibble(!! method := str_dist)
}
