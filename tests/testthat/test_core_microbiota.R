library(coremicrobiota)

df <- data.frame(x = 1:10, y = 1:10)
rownames(df) <- letters[1:10]

res <- list(c("e", "f", "g", "h", "i", "j"), c("f", "g", "h", "i", "j"), 0.83333333)
names(res) <- c("core rarefied biota", "core unrarefied biota", "rai")

test_that("ASV names", {
  expect_equal(core_microbiota(df, seed = 123),
               res)
})

#> Test passed 🎉

