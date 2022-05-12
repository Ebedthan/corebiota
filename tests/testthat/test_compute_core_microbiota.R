library(corebiota)

df <- data.frame(x = 1:10, y = 1:10)
rownames(df) <- letters[1:10]

test_that("to_exclude is not null", {
  expect_equal(compute_core_microbiota(df, to_exclude = "a"), c("f","g","h","i","j"))
})

test_that("abundance is null", {
  expect_equal(compute_core_microbiota(df, abundance = NULL), letters[1:10])
})

test_that("ubiquity is null", {
  expect_equal(compute_core_microbiota(df, ubiquity = NULL), c("f", "g", "h", "i", "j"))
})

res <- data.frame(x_rel_abun = 1:10/55, y_rel_abun = 1:10/55, ubiquity = rep(1, 10))
rownames(res) <- letters[1:10]

test_that("stats", {
  expect_equal(compute_core_microbiota(df, stats = TRUE), res)
})

# Testing errors
test_that("abundance < 1", {
  expect_error(compute_core_microbiota(df, abundance = -1), "Supplied abundance: -1, is less than 0.")
})

#> Test passed 🥳

test_that("abundance > 1", {
  expect_error(compute_core_microbiota(df, abundance = 10), "Supplied abundance: 10, is greater than 1. Did you mean 0.1?")
})

#> Test passed 🥳

test_that("ubiquity < 1", {
  expect_error(compute_core_microbiota(df, ubiquity = -1), "Supplied ubiquity: -1, is less than 0.")
})

#> Test passed 🥳

test_that("ubiquity > 1", {
  expect_error(compute_core_microbiota(df, ubiquity = 10), "Supplied ubiquity: 10, is greater than 1. Did you mean 0.1?")
})

#> Test passed 🥳

test_that("cma with incorrect to exclude data", {
  expect_error(compute_core_microbiota(df, to_exclude = df), "Supplied to_exclude data is not a vector nor a list.")
})
