#' runPredicTER
#'
#' @return launches the PredicTER shiny app
#' @export
#'
#' @examples
#' \dontrun{
#'runPredicTER()
#'}
runPredicTER <- function() {
  appDir <- system.file("shiny-examples", "PredicTER", package = "PredicTER")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `PredicTER`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
