#' Show Map
#'
#' Shiny module functions for displaying leaflet map
#'
#' @param id Shiny module
#'
#' @return A leaflet shiny output
showMapUI <- function(id) {
  leaflet::leafletOutput(
    shiny::NS(id, "map"),
    width = "100%", height = "100%"
  )
}

#' @param id Shiny module
#' @param df_locs Reactive data frame with locs info
#'
#' @return A server shiny module.
#' @export
#' @describeIn showMapUI Server module
#'
#' @import shiny
#' @import leaflet
showMapServer <- function(id, df_locs) {
  moduleServer(id, function(input, output, session) {

    output$map <- renderLeaflet({

      m <- leaflet() %>%
        addProviderTiles("CartoDB.Positron") %>%
        setView(-3.7, 40.45, zoom = 13)

      if(!is.null(df_locs())) {
        # Add markers with addresses
        m <- m %>%
          addMarkers(
            df_locs()$lon,
            df_locs()$lat
          )
      }

      # Generate map
      m

    })
  })
}
