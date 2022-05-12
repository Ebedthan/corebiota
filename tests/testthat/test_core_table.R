library(corebiota)

test_that("error", {
  expect_error(core_table("a"), "Supplied 'df' object is neither a data frame or a phyloseq object")
})
