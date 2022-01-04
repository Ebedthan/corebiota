#' Draw the heatmap of the core members across samples
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#' @param pheatmap A boolean specifying the use or not of pheatmap to draw
#'                 the heatmap. Default is set to FALSE.
#'
#'
#' @return Plot a heatmap.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' core_heatmap(get_core_table(df))
#'
#' @export
core_heatmap <- function(x, pheatmap = FALSE) {
  # Data preparation -----------------------------------------------------------
  # Get core table with relative abundance, ubiquity and total counts
  df <- get_core_table(x)

  # Get data frame with wanted columns only
  df <- df[,
           - which(
             names(df) %in% c("total_counts", "relative_abundance", "ubiquity")
             )
           ]

  # Get relative abundance for columns
  df <- proportions(as.matrix(df), margin = 2)

  if (pheatmap) {
    pheatmap::pheatmap(df)
  } else {
    stats::heatmap(df, cexRow = 1, cexCol = 1.2, margins = c(10, 7),
                   col = grDevices::heat.colors(ncol(df)))

    graphics::legend(x = "bottomright", legend = c("min", "med", "max"),
                     fill = grDevices::heat.colors(ncol(df)))
  }

}
