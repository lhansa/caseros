#' Display marker info
#'
#' Display marker information.
#'
#' @param id Shiny module
#'
#' @return A Shiny Module UI.
showMarkerUI <- function(id) {

  shiny::absolutePanel(
    id = "marker_info",
    class = "panel panel-default", fixed = TRUE,
    draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
    width = 330, height = "auto",

    shiny::uiOutput(NS(id, "panel_clicked"))


  )
}

#' @param id Shiny module
#' @param df_locs Reactive data frame with locs info
#'
#' @return A shiny module server
#' @describeIn showMarkerUI Server side for displaying marker info.
showMarkerServer <- function(id, df_locs) {
  shiny::moduleServer(id, function(input, output, session) {

    shiny::observeEvent(input$map_marker_click, {
      output$panel_clicked <- shiny::renderUI({
        event <- input$map_marker_click
        df_marker <- df_locs()

        cuantos_decs <- 5

        df_marker <- df_marker[
          round(df_marker$lat, cuantos_decs) == round(event$lat, cuantos_decs) &
            round(df_marker$lon, cuantos_decs) == round(event$lng, cuantos_decs),
        ]

        shiny::tagList(
          # df_marker[, c("address", "flat", "mark", "comment")]
          create_html_marker_info(
            df_marker$date,
            df_marker$address,
            df_marker$flat,
            df_marker$mark,
            df_marker$comment
          )
        )
      })
    })

  })
}

#' @param date Review date.
#' @param address Address from marker.
#' @param flat Flat from marker.
#' @param mark Mark from marker.
#' @param comment Comment review from marker.
#'
#' @return A `htmltools::HTML` object
#' @importFrom htmltools HTML
#' @describeIn showMarkerUI Create HTML for marker info display.
create_html_marker_info <- function(date,
                                    address,
                                    flat,
                                    mark,
                                    comment) {

  line_date <- sprintf("<b>Fecha: </b> %s", format(date, "%B %Y"))
  line_address <- sprintf("<b>Direcci\u00f3n. </b> %s", address)
  line_flat <- sprintf("<b>Piso. </b> %s", flat)
  line_mark <- sprintf("<b>Puntos. </b> %s", mark)
  line_comment <- sprintf("<b>Comentario. </b> %s", comment)

  return(HTML(paste0(
    "<p>",
    c(line_date, line_address, line_flat, line_mark, line_comment),
    "</p>"
  )))

}
