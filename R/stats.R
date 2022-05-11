#' Compute total relative abundance and ubiquity for all samples
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
#' stats(df)
#'
#' @export
stats <- function(x) {
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
  ubiquity_vec <- (rowSums(x != 0) / number_of_cols)

  # Compute relative abundance
  rel_df <- sweep(x, 2, colSums(x), "/")
  colnames(rel_df) <- paste0(colnames(x), "_rel_abun")

  # Total count computation
  ttc <- rowSums(x)

  # Add relative abundance data
  x <- cbind(x, rel_df)

  # Add total count data
  x["taxa_tot_cnt"] <- ttc
  total_abundance <- sum(x["taxa_tot_cnt"])

  # Add ubiquity to data frame
  x["ubiquity"] <- ubiquity_vec

  # Relative abundance computing
  x["total_rel_abun"] <- x["taxa_tot_cnt"] / total_abundance

  # Order data frame by relative abundance
  x <- x[order(x$total_rel_abun, decreasing = TRUE),]

  return(x)
}
