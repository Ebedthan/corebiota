#' Compute relative sequence abundance and ubiquity across all samples
#'
#' @param df A data frame which represents the ASV/OTU table with raw counts. The ASVs/OTUs names should be set as the row names of the data frame.
#'
#' @return A data frame with raw counts, relative abundance, and ubiquity of ASVs/OTUs.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' get_core_table(df)
#'
#' @export
get_core_table <- function(df) {
  if (!is.data.frame(df)) {
    stop("Provided tbl object is not a matrix or a data frame")
  }

  number_of_cols <- ncol(df)

  # Ubiquity computing
  ubiquity_vec <- round((rowSums(df != 0) / number_of_cols) * 100)

  # Total count computing
  df["total_counts"] <- rowSums(df)
  total_abundance <- sum(df["total_counts"])

  # Add ubiquity to data frame
  df["ubiquity"] <- ubiquity_vec

  # Relative abundance computing
  df["relative_abundance"] <- df["total_counts"] / total_abundance

  return(df)
}
