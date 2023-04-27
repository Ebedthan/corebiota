#' Modelling species abundance distribution of ASV/OTU following Poisson
#' distribution
#'
#' @param x A data frame representing a ASV/OTU table with raw counts or
#'          phyloseq object.
#'
#' @param taxa_are_rows A logical indicating if OTU are rows
#'
#' @return A data frame of species abundance distribution
#'
#' @examples
#' df <- data.frame(x = seq(0, 10), y = seq(11, 21))
#' sad(df)
#'
#' @export
sad <- function(x, taxa_are_rows = FALSE) {
  # Check data validity ------------------------------------------------------
  if (!is.data.frame(x) && !is.matrix(x) && !methods::is(x, "phyloseq")) {
    stop(
      "supplied object is neither a data frame or a phyloseq object."
    )
  }

  # Get ASV/OTU table from phyloseq object
  if (methods::is(x, "phyloseq")) {
    # The phyloseq object is a S4 class
    x <- as.data.frame(phyloseq::otu_table(x))
  }

  if (!taxa_are_rows) {
    x <- as.data.frame(x)
  } else if (taxa_are_rows) {
    x <- as.data.frame(x)
    x <- t(x)
  }

  # ASV/OTU sample's occupancy calculation
  occupancy <- colSums(x != 0)

  # matrix transformation and zero removal in data
  x_na <- as.matrix(x)
  x_na[x_na == 0] <- NA

  # fast computation of variance and mean of each ASV/OTU
  x_var <- matrixStats::colVars(x_na, na.rm = TRUE)
  x_mean <- matrixStats::colMeans2(x_na, na.rm = TRUE)

  # compute variance-to-mean ratio
  vmr <- x_var / x_mean

  # compute the observed chi sq of vmr and its log10 transformation
  chi_sq <- vmr * occupancy
  log_chi_sq <- log10(chi_sq)

  result <- as.data.frame(cbind(chi_sq, log_chi_sq, occupancy))
  colnames(result) <- c("chi_observed", "log_chi_observed", "occupancy")

  # computed expected chi sq with 2.5% confidence
  p <- c(0.975)
  nb_samples <- seq(min(occupancy), max(occupancy))

  exp_chi_sq <- outer(p, nb_samples, function(x, y) stats::qchisq(x, y))
  exp_chi_sq <- t(exp_chi_sq)

  colnames(exp_chi_sq) <- p
  rownames(exp_chi_sq) <- nb_samples
  exp_chi_sq_log <- log10(exp_chi_sq)

  # compute the confidence line for the plot
  conflim <- as.data.frame(cbind(nb_samples, exp_chi_sq, exp_chi_sq_log))
  colnames(conflim) <- c("occupancy", "chi_expected", "log_chi_expected")

  result$asv <- rownames(result)
  result2 <- merge(result, conflim, by = "occupancy")
  result2 <- stats::na.omit(result2)
  rownames(result2) <- result2$asv
  result2 <- result2[, -4]

  result2 <- transform(
    result2,
    type = ifelse(result2$log_chi_observed > result2$log_chi_expected,
      "core",
      "satellite"
    )
  )

  return(result2)
}
