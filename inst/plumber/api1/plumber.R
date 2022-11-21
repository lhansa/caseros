#* @apiTitle Caseros Package API
#* @apiDescription API for support programmatic access to caseros Shiny App.

#* Return data frame with info
#* @param mark Lower bound mark
#* @serializer unboxedJSON
#* @post /echo
function(mark=0) {
  jsonlite::toJSON(
    caseros::get_reviews_over(mark),
    auto_unbox =TRUE
  )
}

