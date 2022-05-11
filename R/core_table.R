#' Compute relative sequence abundance and ubiquity across all samples
#'
#' @param df A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#'
#' @return A data frame with relative abundance, and ubiquity of ASVs/OTUs.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' core_table(df)
#'
#' @export
core_table <- function(df) {
  # Input validation -----------------------------------------------------------
  # If object is not a data frame or phyloseq object then stop
  if (!is.data.frame(df) & class(df) != "phyloseq") {
    stop(
      paste("Supplied 'df' object is neither a data frame or a phyloseq object.",
           "\n  Please check the class of your input object:",
           deparse(substitute(df))
           )
    )
  }

  # Data preparation -----------------------------------------------------------
  # Get ASV/OTU table from phyloseq object
  if (class(df) == "phyloseq") {
    # The phyloseq object is a S4 class
    df <- as.data.frame(df@otu_table)
  }

  # Initial number of column for further computation
  number_of_cols <- ncol(df)

  # Ubiquity computation
  ubiquity_vec <- (rowSums(df != 0) / number_of_cols)

  # Compute relative abundance
  df <- sweep(df, 2, colSums(df), "/")
  colnames(df) <- paste0(colnames(df), "_rel_abun")


  # Add ubiquity to data frame
  df["ubiquity"] <- ubiquity_vec


  # Order data frame by relative abundance
  df <- df[order(df$ubiquity, decreasing = TRUE),]

  return(df)
}
