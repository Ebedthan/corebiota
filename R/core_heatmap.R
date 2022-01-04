#' Draw the heatmap of the core members across samples
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object. The ASVs/OTUs names should be set as the row
#'          names of the data frame.
#' @param abundance A number (between 0 and 100) or NULL representing the
#'                  relative abundance threshold (inclusive).
#' @param ubiquity A number (between 0 and 100) or NULL representing the
#'                 ubiquity of ASV/OTU in sample threshold (inclusive).
#' @param pheatmap A boolean specifying the use or not of pheatmap to draw
#'                 the heatmap. Default is set to FALSE.
#'
#'
#' @return Plot a heatmap.
#'
#' @examples
#' df <- data.frame(sample_x = 1:10, sample_y = 1:10)
#' rownames(df) <- letters[1:10]
#' core_heatmap(df, abundance = 0.1, ubiquity = 0.8)
#'
#' @export
core_heatmap <- function(x, abundance = 0.1, ubiquity = 0.8, pheatmap = FALSE) {
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

  # Data preparation -----------------------------------------------------------
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
