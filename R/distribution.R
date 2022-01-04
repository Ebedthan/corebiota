#' Draw the distribution of the relative abundance or ubiquity
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#'
#' @return Plot a histogram of relative abundance and ubiquity.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' distribution(df)
#'
#' @export
distribution <- function(x) {
  # Data preparation -----------------------------------------------------------
  df <- get_core_table(x)

  # Drawing histograms ---------------------------------------------------------
  # Split the pane into two rows
  graphics::par(mfrow = c(1, 2))

  # Add first histogram on relative abundance
  graphics::hist(df$relative_abundance,
                 main = "Histogram of ASVs/OTUs relative abundance",
                 xlab = "Relative abundance",
                 col = grDevices::rgb(0, 0, 1, 1/4))

  # Add second histogram on relative abundance
  graphics::hist(df$ubiquity,
                 main = "Histogram of samples ubiquity",
                 xlab = "Samples ubiquity",
                 col = grDevices::rgb(1, 0, 0, 1/4))
}
