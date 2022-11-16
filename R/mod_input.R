#' Input Window Module
#'
#' @param id Shiny module
#'
#' @return A UI module
#' @import shiny
inputReviewUI <- function(id) {
  absolutePanel(
    id = "review_input",
    class = "panel panel-default", fixed = TRUE,
    draggable = TRUE, top = 60, left = 20, right = "auto", bottom = "auto",
    width = 330, height = "auto",

    # tagList(
    # TODO upload a file
    textInput(
      inputId = NS(id, "google_key"),
      label = NULL,
      placeholder = "Escribe aqu\u00ed tu Google key"
    ),
    textInput(
      inputId = NS(id, "address"),
      label = NULL,
      placeholder = "Escribe aqu\u00ed la direcci\u00f3n"
    ),
    textInput(
      inputId = NS(id, "which_flat"),
      label = NULL,
      placeholder = "Aqu\u00ed va el piso"
    ),
    sliderInput(
      inputId = NS(id, "the_mark"),
      label = "Calificaci\u00f3n",
      min = 0,
      max = 10,
      value = 5,
      step = 1
    ),
    textInput(
      inputId = NS(id, "the_comment"),
      label = NULL,
      placeholder = "Tus impresiones"
    ),
    actionButton(NS(id, "add_marker"),
                 label = "A\u00f1ade la valoraci\u00f3n")
  )

  # )


}

#' @param id Shiny module.
#' @param path_to_data Path to rds.
#'
#' @importFrom shiny moduleServer
#' @importFrom shiny observeEvent
#'
#' @return A Server module.
#' @describeIn inputReviewUI Server side of the module.
inputReviewServer <- function(id, path_to_data) {
  moduleServer(id, function(input, output, session) {
    observeEvent(input$add_marker, {
      update_with_new_address(
        google_key = input$google_key,
        path = path_to_data,
        new_address = input$address,
        flat = input$which_flat,
        mark = input$the_mark,
        comment = input$the_comment
      )

    })
  })
}
