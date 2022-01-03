# Core microbiota!
#
# This function get the core microbiota
# based on the ASV/OTU table with raw counts by
# applying a threshold of total relative abundance
#

core_microbiota <- function(df, threshold = 5) {
  if (!is.matrix(df) || !is.data.frame(df)) {
    stop(simpleError("Provided tbl object is not a matrix or a data frame"))
  }

  df["relative_abundance"] <- rowSums(df)

  return(df[(df["relative_abundance"] > threshold / 100),])

}
