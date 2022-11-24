#' Get reviews over a given mark
#'
#' Returns a data frame with information related
#' to appartments with a mark above a given number
#'
#' @param points Lower bound mark
#'
#' @return A `data.frame`
#' @export
#'
#' @examples get_reviews_over(5)
get_reviews_over <- function(points) {

  df <- readRDS("inst/extdata/locs.rds")
  subset(
    df,
    mark >= points,
    select = c(date, address, flat, mark, comment)
  )

}
