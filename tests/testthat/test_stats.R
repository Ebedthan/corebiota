library(corebiota)

df <- data.frame(x = 1:10, y = 1:10)
rownames(df) <- letters[1:10]

res <- data.frame(x = 10:1, y = 10:1, x_rel_abun = 10:1/55,
                  y_rel_abun = 10:1/55, taxa_tot_cnt = seq(20, 2, -2),
                  ubiquity = rep(1, 10), total_rel_abun = 10:1/55)
rownames(res) <- rev(letters[1:10])

test_that("get stats", {
  expect_equal(stats(df), res)
})

test_that("error", {
  expect_error(stats("a"), "Supplied 'x' object is neither a data frame or a phyloseq object")
})
