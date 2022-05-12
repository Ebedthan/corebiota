library(coremicrobiota)

set1 <- c("a", "b", "c", "d")
set2 <- c("b", "c", "d")

test_that("test rarefaction aware index", {
  expect_equal(rai(set2, set1), 0.75)
})

#> Test passed 🎉
