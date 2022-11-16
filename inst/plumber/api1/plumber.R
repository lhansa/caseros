# plumber.R

#* Return data frame with info
#* @param mark Lower bound mark
#* @serializer unboxedJSON
#* @get /echo
function(mark=0) {
  jsonlite::toJSON(
    caseros::get_reviews_over(mark),
    auto_unbox =TRUE
  )
}

