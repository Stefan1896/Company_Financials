#' cube_root
#'
#' @description Function for cube_root transformatting, since taken (1/3) as exponential does not work for negative values
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd


cube_root <- function(x) {
  sign(x) * abs(x)^(1/3)
}
