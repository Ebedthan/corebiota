#' Compute relative sequence abundance and ubiquity across all samples
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#'
#' @return A data frame with raw counts, relative abundance, and ubiquity of
#'         ASVs/OTUs.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' get_core_table(df)
#'
#' @export
get_core_table <- function(x) {
  # Input validation -----------------------------------------------------------
  # If object is not a data frame or phyloseq object then stop
  if (!is.data.frame(x) & class(x) != "phyloseq") {
    stop(
      paste("Supplied 'x' object is neither a data frame or a phyloseq object.",
           "\n  Please check the class of your input object:",
           deparse(substitute(x))
           )
    )
  }

  # Data preparation -----------------------------------------------------------
  # Get ASV/OTU table from phyloseq object
  if (class(x) == "phyloseq") {
    # The phyloseq object is a S4 class
    x <- as.data.frame(x@otu_table)
  }

  # Initial number of column for further computation
  number_of_cols <- ncol(x)

  # Ubiquity computation
  ubiquity_vec <- round((rowSums(x != 0) / number_of_cols))

  # Total count computation
  x["total_counts"] <- rowSums(x)
  total_abundance <- sum(x["total_counts"])

  # Add ubiquity to data frame
  x["ubiquity"] <- ubiquity_vec

  # Relative abundance computing
  x["relative_abundance"] <- x["total_counts"] / total_abundance

  # Order data frame by relative abundance
  x <- x[order(x$relative_abundance, decreasing = TRUE),]

  return(x)
}
