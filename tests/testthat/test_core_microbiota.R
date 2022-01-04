library(coremicrobiota)

df <- data.frame(x = 1:10, y = 1:10)

test_that("ASV names", {
  expect_equal(core_microbiota(df, abundance = NULL, ubiquity = 1),
               c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10"))
  expect_equal(core_microbiota(df),
               c("6", "7", "8", "9", "10"))
})

#> Test passed 🎉

test_that("relative sequence abundance across all samples", {
  expect_equal(round(core_microbiota(df, abundance= NULL, ubiquity = 1, stats = T)$relative_abundance, 2),
               c(0.02, 0.04, 0.05, 0.07, 0.09, 0.11, 0.13, 0.15, 0.16, 0.18))
})

#> Test passed 😸

test_that("ubiquity all samples", {
  expect_equal(core_microbiota(df, stats = T)$ubiquity,
               c(1, 1, 1, 1, 1))
})

#> Test passed 😸
