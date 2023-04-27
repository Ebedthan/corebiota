library(testthat)

# Define test data
test_df <- data.frame(
  ASV1 = c(0, 1, 2, 0, 4),
  ASV2 = c(1, 1, 0, 1, 0),
  ASV3 = c(0, 0, 0, 0, 1),
  row.names = c("Sample1", "Sample2", "Sample3", "Sample4", "Sample5")
)

test_phylo <- phyloseq::phyloseq(
  phyloseq::otu_table(as.matrix(test_df), taxa_are_rows = F), NULL, NULL
)

# Define tests
test_that("input validation works", {
  # Test non-data frame or matrix input
  expect_error(sad(list()), "supplied object is neither a data frame or a phyloseq object.")
})

test_that("ASV/OTU sample occupancy calculation is correct", {
  # Test ASV/OTU sample occupancy calculation
  expected_occupancy <- c(3, 3)
  result <- sad(test_df)
  expect_equal(result$occupancy, expected_occupancy)
})

test_that("ASV/OTU variance and mean calculation is correct", {
  # Test ASV/OTU variance and mean calculation
  expected_x_var <- c(1, 0)
  expected_x_mean <- c(-1.11e-16, -Inf)
  result <- sad(test_df)
  expect_equal(result$chi_observed / result$occupancy, expected_x_var, tolerance = 0.01)
  expect_equal(result$log_chi_observed - log10(result$occupancy), expected_x_mean, tolerance = 0.01)
})

test_that("ASV/OTU chi square calculation is correct", {
  # Test ASV/OTU chi square calculation
  expected_chi_sq <- c(3, 0)
  result <- sad(test_df)
  expect_equal(result$chi_observed, expected_chi_sq, tolerance = 0.01)
})
