#' Plot core/satellite graphic
#'
#' @param x A data frame of species abundance distribution generated using
#'          \code{sad}.
#'
#' @return A plot
#'
#' @examples
#' df <- data.frame(x = seq(0, 10), y = seq(11, 21))
#' sad <- sad(df)
#' plot_graph(sad)
#'
#' @export
plot_graph <- function(x) {
  plot(x$occupancy,
    x$log_chi_observed,
    col = as.factor(x$type),
    xlab = "ASV/OTU occurence",
    ylab = "Index of dispersion (Log 10)",
    pch = 20
  )
  graphics::lines(x$occupancy, x$log_chi_expected, col = "orange", lwd = 2)
  graphics::legend(
    x = "topleft",
    legend = c("core", "satellite", "confidence line"),
    col = c("black", "red", "orange"),
    pch = 19,
    cex = 0.8
  )
}
