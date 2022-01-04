#' Draw the distribution of the relative abundance or ubiquity
#'
#' @param df A data frame which represents the ASV/OTU table with raw counts. The ASVs/OTUs names should be set as the row names of the data frame.
#' @param type A character string specifying the type of histogram to plot. Can be either abundance or ubiquity.
#'
#' @return Plot a histogram.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' distribution(df, type = "abundance")
#'
#' @export
distribution <- function(df, type = "abundance") {
  if (type != "abundance" & type != "ubiquity") {
    stop("Supplied type of histogram is not supported")
  }

  df <- get_core_table(df)

  if (type == "abundance") {
    graphics::hist(df$relative_abundance,
              main = "Histogram of ASVs/OTUs relative abundance",
              xlab = "Relative abundance",
              col = grDevices::rgb(0, 0, 1, 1/4))

  } else if (type == "ubiquity") {
    graphics::hist(df$ubiquity,
                   main = "Histogram of samples ubiquity",
                   xlab = "Samples ubiquity",
                   col = grDevices::rgb(1, 0, 0, 1/4))
  }
}
