library(corebiota)

df <- data.frame(x = 1:10, y = 1:10)
rownames(df) <- letters[1:10]

res <- list(c("e", "f", "g", "h", "i", "j"), c("f", "g", "h", "i", "j"), "e", 0.83333333, 123)
names(res) <- c("rarefied_core_biota", "unrarefied_core_biota", "diff", "rai", "seed")

test_that("ASV names", {
  expect_equal(core_microbiota(df, seed = 123),
               res)
})

#> Test passed 🎉

