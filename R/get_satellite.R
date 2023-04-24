#' Get satellite microbiota based on ASV Poisson modelling
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object.
#'
#' @return A data frame of species abundance distribution of satellite species
#'
#' @examples
#' df <- data.frame(x=seq(0,10), y=seq(11,21))
#' get_satellite(df)
#'
#' @export
get_satellite <- function(x) {
    xsad <- sad(x)
    return(xsad[xsad$type == "satellite", ])
}
