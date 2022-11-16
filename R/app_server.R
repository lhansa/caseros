#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic
  path_to_data <- "inst/extdata/locs.rds"

  df_locs <- reactiveFileReader(
    intervalMillis = 2000,
    session = NULL,
    filePath = path_to_data,
    readFunc = readRDS
  )

  inputReviewServer("panel_review", path_to_data)
  showMapServer("main_map", df_locs)
  showMarkerServer("main_map", df_locs)
}
