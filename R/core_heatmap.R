#' Draw the heatmap of the core members across samples
#'
#' @param df A data frame which represents the ASV/OTU table with raw counts. The ASVs/OTUs names should be set as the row names of the data frame.
#' @param abundance A number (between 0 and 100) representing the relative abundance threshold (inclusive).
#' @param ubiquity A number (between 0 and 100) representing the ubiquity of ASV/OTU in sample threshold (inclusive).
#'
#' @return Plot a heatmap.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' core_heatmap(df, abundance = 10, ubiquity = 100)
#'
#' @export
core_heatmap <- function(df, abundance = 5, ubiquity = 80) {
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

  if (is.null(ubiquity)) {
    df <- df[
      (df["relative_abundance"] >= (abundance / 100)),
    ]
  } else if (is.null(abundance)) {
    df <- df[
      (df["ubiquity"] >= ubiquity),
    ]
  } else {
    df <- df[
      (df["relative_abundance"] >= (abundance / 100) & df["ubiquity"] >= ubiquity),
    ]
  }

  df <- df[,-which(names(df) %in% c("total_counts", "relative_abundance", "ubiquity"))]

  df <- scale(df)

  stats::heatmap(as.matrix(df))

}
