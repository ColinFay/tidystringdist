#' @importFrom stringdist stringdist
#' @importFrom rlang quo_name enquo enquos
#' @importFrom tibble tibble
#'
tibble_dist <- function(df, v1, v2, method, ...){
  str_dist <- stringdist(a=df[[quo_name(enquo(v1))]],
                         b=df[[quo_name(enquo(v2))]],
                         method=method,
                         ...)

  tibble(!! method := str_dist)
}
