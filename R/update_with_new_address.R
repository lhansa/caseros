#' Update RDS file with provided address
#'
#' Updates the RDS file with locations with the location of the new address
#'
#' @param google_key Google App key
#' @param path Path to RDS file
#' @param new_address Address whose coordinates you want to query.
#' @param flat Text with flat.
#' @param mark Number from 1 to 10 with the review's mark.
#' @param comment Text with the review's comment.
#'
#' @return Nothing
#' @export
#'
#' @importFrom ggmap geocode
#' @importFrom ggmap register_google
#' @importFrom ggmap showing_key
update_with_new_address <- function(google_key,
                                    path,
                                    new_address,
                                    flat,
                                    mark,
                                    comment) {
  # if (requireNamespace("ggmap", quietly = TRUE)) {
    library(ggmap)
    # options(ggmap = list(google = list(second_limit = 50L,
    #                                    day_limit = 2500)))
    register_google(key = google_key)
    df_locs <- readRDS(path)
    df_locs_new <- geocode(new_address)


    df_locs_new$date <- Sys.Date()
    df_locs_new$address <- new_address
    df_locs_new$flat <- flat
    df_locs_new$mark <- mark
    df_locs_new$comment <- comment

    saveRDS(
      rbind(df_locs, df_locs_new),
      path
    )

  # }


}
