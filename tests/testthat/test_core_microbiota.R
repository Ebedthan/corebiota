library(corebiota)

df <- data.frame(x = 1:10, y = 1:10)
rownames(df) <- letters[1:10]

res <- list(c("e", "f", "g", "h", "i", "j"), c("f", "g", "h", "i", "j"), "e", 0.83333333, 123)
names(res) <- c("rarefied_core_biota", "unrarefied_core_biota", "diff", "rai", "seed")

test_that("cma with seed", {
  expect_equal(core_microbiota(df, seed = 123),
               res)
})

#> Test passed 🎉

res <- list(c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j"), c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j"), character(0), 1, 123)
names(res) <- c("rarefied_core_biota", "unrarefied_core_biota", "diff", "rai", "seed")
cma <- core_microbiota(df)

test_that("cma without seed", {
  expect_equal(cma$unrarefied_core_biota, c("f", "g", "h", "i", "j"))
})

#> Test passed 🥳

# Testing errors
test_that("abundance < 1", {
  expect_error(core_microbiota(df, abundance = -1), "Supplied abundance: -1, is less than 0.")
})

#> Test passed 🥳

test_that("abundance > 1", {
  expect_error(core_microbiota(df, abundance = 10), "Supplied abundance: 10, is greater than 1. Did you mean 0.1?")
})

#> Test passed 🥳

test_that("ubiquity < 1", {
  expect_error(core_microbiota(df, ubiquity = -1), "Supplied ubiquity: -1, is less than 0.")
})

#> Test passed 🥳

test_that("ubiquity > 1", {
  expect_error(core_microbiota(df, ubiquity = 10), "Supplied ubiquity: 10, is greater than 1. Did you mean 0.1?")
})

#> Test passed 🥳

test_that("cma with incorrect to exclude data", {
  expect_error(core_microbiota(df, to_exclude = df), "Supplied to_exclude data is not a vector nor a list.")
})

