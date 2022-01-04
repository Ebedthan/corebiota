#' Sniff the number of members of the core microbiota given the parameters
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#' @param abundance A number (between 0 and 100) or NULL representing the
#'                  relative abundance threshold (inclusive).
#' @param ubiquity A number (between 0 and 100) or NULL representing the
#'                 ubiquity of ASV/OTU in sample threshold (inclusive).
#'
#' @return The number of members of the core microbiota given the parameters.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- paste0("OTU", "_", 1:10)
#' sniff(df)
#'
#' @export
sniff <- function(x, abundance = 0.1, ubiquity = 0.8) {
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

  # Data preparation -----------------------------------------------------------
  # Get core table with relative abundance, total_count and ubiquity
  df <- get_core_table(x)

  # Start filtering using supplied parameters ----------------------------------
  # If ubiquity is null, then omit filtering with this value
  if (is.null(ubiquity)) {
    df <- df[(df["relative_abundance"] >= abundance),]

  # If abundance is null, then omit filtering with this value
  } else if (is.null(abundance)) {
    df <- df[(df["ubiquity"] >= ubiquity),]

  # Filtering using both criteria
  } else {
    df <- df[
      (df["relative_abundance"] >= abundance & df["ubiquity"] >= ubiquity),
    ]
  }

  # Outputting results ---------------------------------------------------------
  if (nrow(df) == 0) {
    cat(
      paste0("No ASVs/OTUs was found at the defined abundance (",
             abundance,
             " %) and (",
             ubiquity,
             " %) ubiquity threshold")
      )
  } else {
    cat(
      paste(nrow(df), "ASVs/OTUs were found as members of the core microbiota")
      )
  }
}
