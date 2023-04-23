#' Get core microbiota based on ASV Poisson modelling
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object.
#' @param taxa_are_rows A single logical specifying the orientation of
#'                      the abundance table.
#'
#' @return A data frame of species abundance distribution of core microbiome.
#'
#' @examples
#' df <- data.frame(x=seq(0,10), y=seq(11,21))
#' get_core(df)
#'
#' @export
get_core <- function(x, taxa_are_rows=FALSE) {
    xsad <- sad(x, taxa_are_rows=taxa_are_rows)
    return(xsad[xsad$type=="core", ])
}