#' Get core microbiota from ASV/OTU table
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#' @param abundance A number (between 0 and 100) or NULL representing the
#'                  relative abundance threshold (inclusive).
#' @param ubiquity A number (between 0 and 100) or NULL representing the
#'                 ubiquity of ASV/OTU in sample threshold (inclusive).
#' @param to_exclude A vector of ASVs/OTUs to exclude from analysis.
#'
#' @param seed A single integer value passed to `set.seed`, which is used
#'             to fix a seed for reproducibly random number generation.
#'
#'
#' @return A list of ASV/OTU names belonging to the defined core microbiota.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' core_microbiota(df, abundance = 0.01, ubiquity = 1)
#'
#' @export
core_microbiota <- function(x, abundance = 0.1, ubiquity = 0.8, to_exclude = NULL, seed = FALSE) {
  # Seed management
  xs <- 0
  if (!seed) {
    xs <- sample(1:2^15, 1)
  } else {
    xs <- seed
  }

  # Input validation -----------------------------------------------------------
  # If abundance value is not NULL and not between 0 an 1 then stop
  if (!is.null(abundance)) {
    if (abundance < 0) {
      stop(
        paste0("Supplied abundance: ", deparse(abundance),", is less than 0.")
      )
    } else if (abundance > 1) {
      stop(
        paste0("Supplied abundance: ", deparse(abundance),", is greater than 1.",
               " Did you mean ", abundance/100, "?")
      )
    }
  }

  # If ubiquity value is not NULL and not between 0 an 1 then stop
  if (!is.null(ubiquity)) {
    if (ubiquity < 0) {
      stop(
        paste0("Supplied ubiquity: ", deparse(ubiquity),", is less than 0.")
      )
    } else if (ubiquity > 1) {
      stop(
        paste0("Supplied ubiquity: ", deparse(ubiquity),", is greater than 1.",
               " Did you mean ", ubiquity/100)
      )
    }
  }

  # If to_exclude is not NULL, check if it is a vector or list
  if (!is.null(to_exclude)) {
    if (!is.vector(to_exclude)) {
      stop(
        paste0("Supplied to_exclude data is not a vector nor a list.")
      )
    }
  }

  # Rarefying the table
  rarefied_table <- as.data.frame(
    phyloseq::rarefy_even_depth(
      phyloseq::phyloseq(phyloseq::otu_table(x, taxa_are_rows = T), NULL, NULL, NULL),
      rngseed = xs))

  # Get core rarefied biota
  core_rarefied_biota <- compute_core_microbiota(rarefied_table, abundance = abundance, ubiquity = ubiquity, to_exclude = to_exclude)


  # Get core unrarefied biota
  core_unrarefied_biota <- compute_core_microbiota(x, abundance = abundance, ubiquity = ubiquity, to_exclude = to_exclude)

  # Get rarefaction aware index
  rai_index <- rai(core_rarefied_biota, core_unrarefied_biota)

  # Outputting -----------------------------------------------------------------
  difference <- union(setdiff(core_rarefied_biota, core_unrarefied_biota), setdiff(core_unrarefied_biota, core_rarefied_biota))
  result <- list(core_rarefied_biota, core_unrarefied_biota, difference, rai_index, xs)
  names(result) <- c("rarefied_core_biota", "unrarefied_core_biota", "diff", "rai", "seed")

  if (length(core_rarefied_biota) == 0 & length(core_unrarefied_biota) == 0){
    message(
      paste0("No ASVs/OTUs was found at the defined abundance for the rarefied and unrarefied data (",
             abundance * 100,
             "%) and ubiquity (",
             ubiquity * 100,
             "%) threshold")
      )
  } else {
    return(result)
  }
}
