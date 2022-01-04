#' Sniff the number of members of the core microbiota given the parameters
#'
#' @param df A data frame which represents the ASV/OTU table with raw counts. The ASVs/OTUs names should be set as the row names of the data frame.
#' @param abundance A number (between 0 and 100) representing the relative abundance threshold (inclusive).
#' @param ubiquity A number (between 0 and 100) representing the ubiquity of ASV/OTU in sample threshold (inclusive).
#'
#' @return The number of members of the core microbiota given the parameters.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' sniff(df)
#'
#' @export
sniff <- function(df, abundance = 5, ubiquity = 80) {
  # Input validation
  if (!is.null(abundance)) {
    if (abundance < 0 & abundance > 100) {
      stop("Supplied relative abundance is not in percentage")
    }
  }

  if (!is.null(ubiquity)) {
    if (ubiquity < 0 & ubiquity > 100) {
      stop("Supplied ubiquity is not in percentage")
    }
  }

  df <- get_core_table(df)

  df_result <- ""
  if (is.null(ubiquity)) {
    df_result <- df[
      (df["relative_abundance"] >= (abundance / 100)),
    ]
  } else if (is.null(abundance)) {
    df_result <- df[
      (df["ubiquity"] >= ubiquity),
    ]
  } else {
    df_result <- df[
      (df["relative_abundance"] >= (abundance / 100) & df["ubiquity"] >= ubiquity),
    ]
  }

  if (nrow(df_result) == 0) {
    cat(paste0("No ASVs/OTUs was found at the defined abundance (", abundance, " %) and (", ubiquity, " %) ubiquity threshold"))
  } else {
    cat(paste(nrow(df_result), "ASVs/OTUs were found as members of the core microbiota"))
  }
}
