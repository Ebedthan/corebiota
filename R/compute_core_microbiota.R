#' Compute core microbiota from ASV/OTU table
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#' @param abundance A number (between 0 and 100) or NULL representing the
#'                  relative abundance threshold (inclusive).
#' @param ubiquity A number (between 0 and 100) or NULL representing the
#'                 ubiquity of ASV/OTU in sample threshold (inclusive).
#' @param stats A boolean value (default FALSE) to enable outputting of relative
#'              abundance and ubiquity along ASVs/OTUs names.
#' @param to_exclude A vector of ASVs/OTUs to exclude from analysis.
#'
#'
#' @return A list of ASV/OTU names belonging to the defined core microbiota.
#'
compute_core_microbiota <- function(x, abundance = 0.1, ubiquity = 0.8, stats = FALSE, to_exclude = NULL) {
  # Input validation -----------------------------------------------------------
  # If abundance value is not NULL and not between 0 an 1 then stop
  if (!is.null(abundance)) {
    if (ubiquity < 0) {
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
               "Did you mean ", ubiquity/100)
      )
    }
  }

  # If to_exclude is not NULL, check if it is a vector or list
  if (!is.null(to_exclude)) {
    if (!is.vector(to_exclude)) {
      stop(
        paste0("Supplied to_exclude: ", deparse(to_exclude),", is not a vector nor a list.")
      )
    }
  }

  # Data preparation -----------------------------------------------------------
  # Remove unwanted ASVs/OTUs using their names, if values are supplied
  if (!is.null(to_exclude)) {
    x <- x[!rownames(x) %in% to_exclude,]
  }

  # Get core table with relative abundance, ubiquity and total counts
  df <- core_table(x)

  # Start filtering using supplied parameters ----------------------------------
  # If ubiquity is null, then filter only on abundance
  if (is.null(ubiquity)) {
    x <- df[which(rowSums(df[,1:length(df)-1] >= abundance) >= abundance),]

    # If abundance is null, then filter only on ubiquity
  } else if (is.null(abundance)) {
    x <- df[which(df["ubiquity"] >= ubiquity),]

    # Filtering using both criteria
  } else {
    x <- df[
      (rowSums(df[,1:length(df)-1] >= abundance) & rowSums(df["ubiquity"] >= ubiquity)),
    ]
  }

  # Outputting -----------------------------------------------------------------
  # If stats is FALSE, then just output the number of ASVs/OTUs
  if (!stats) {
    if (nrow(x) == 0) {
      message(
        paste0("No ASVs/OTUs was found at the defined abundance (",
               abundance,
               "%) and ubiquity (",
               ubiquity * 100,
               "%) threshold")
      )
    } else {
      return(rownames(x))
    }
    # If stats is TRUE, then output ASVs/OTUs names along with relative abundance
    # and ubiquity value
  } else {
    return(df)
  }

}
