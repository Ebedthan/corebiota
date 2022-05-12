#' Compute rarefaction aware indice
#'
#' @param rarefied_microbiota     A vector of core microbiota members
#' @param non_rarefied_microbiota A vector of core microbiota members
#'
#' @return A rarefaction aware index
#'
rai <- function(rarefied_microbiota, non_rarefied_microbiota) {

  union <- length(intersect(non_rarefied_microbiota, rarefied_microbiota))

  x <- union / (length(rarefied_microbiota) + length(non_rarefied_microbiota) - union )

  return(x)
}
