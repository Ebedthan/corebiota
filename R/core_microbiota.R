#' Get core microbiota from ASV/OTU table
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
#'
#'
#' @return A list of ASV/OTU names belonging to the defined core microbiota.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' core_microbiota(df, abundance = 0.01, ubiquity = 1, stats = TRUE)
#'
#' @export
core_microbiota <- function(x, abundance = 0.1, ubiquity = 0.8, stats = FALSE, toExclude = NULL) {
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

  # If toExclude is not NULL, check if it is a vector or list
  if (!is.null(toExclude)) {
    if (!is.vector(toExclude)) {
      stop(
        paste0("Supplied toExclude: ", deparse(toExclude),", is not a vector nor a list.")
      )
    }
  }

  # Data preparation -----------------------------------------------------------
  # Remove unwanted ASVs/OTUs using their names, if values are supplied
  if (!is.null(toExclude)) {
    x <- x[!rownames(x) %in% toExclude,]
  }

  # Get core table with relative abundance, ubiquity and total counts
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

  # Outputting -----------------------------------------------------------------
  # If stats is FALSE, then just ouput the number of ASVs/OTUs
  if (!stats) {
    if (nrow(df) == 0) {
      cat(
        paste0("No ASVs/OTUs was found at the defined abundance (",
               abundance,
               " %) and (",
               ubiquity,
               " %) ubiquity threshold")
        )
    } else {
      return(rownames(df))
    }
  # If stats is TRUE, then output ASVs/OTUs names along with relative abundance
  # and ubiquity value
  } else {
    stats_df <- data.frame(relative_abundance = df$relative_abundance,
                           ubiquity = df$ubiquity)
    rownames(stats_df) <- rownames(df)

    return(stats_df)
  }

}
