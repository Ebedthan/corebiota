test_that("sad works", {
    df <- data.frame(x=seq(0,10), y = seq(11,21))
    df <- sad(df)
    res <- data.frame(occupancy = c(10, 11),
                      chi_observed = c(16 + 2/3, 7.56250),
                      log_chi_observed = c(1.22184875, 0.87866539),
                      chi_expected = c(20.483177350807395, 21.9200493),
                      log_chi_expected = c(1.31139733, 1.34084153),
                      type = c("satellite", "satellite"))
    rownames(res) <- c("x", "y")
    expect_equal(df, res)
})

#> Test passed 🥇

