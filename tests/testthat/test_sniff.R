library(coremicrobiota)

df <- data.frame(x = 1:10, y = 1:10)

test_that("ASV names", {
  expect_output(sniff(df, abundance = NULL, ubiquity = 100),
               "10 ASVs/OTUs were found as members of the core microbiota")
  expect_output(sniff(df),
               "8 ASVs/OTUs were found as members of the core microbiota")
})

#> Test passed 🎉
