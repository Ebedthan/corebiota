% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_core.R
\name{get_core}
\alias{get_core}
\title{Get core microbiota based on ASV Poisson modelling}
\usage{
get_core(x, taxa_are_rows = F)
}
\arguments{
\item{x}{A data frame representing a ASV/OTU table with raw counts or
phyloseq object.}

\item{taxa_are_rows}{A logical indicating if OTU are rows}
}
\value{
A data frame of species abundance distribution of core microbiome.
}
\description{
Get core microbiota based on ASV Poisson modelling
}
\examples{
df <- data.frame(x=seq(0,10), y=seq(11,21))
get_core(df)

}
