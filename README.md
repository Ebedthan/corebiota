# corebiota <img src="man/figures/logo.png" align="right" width="120"/>

<!-- badges: start -->

[![R-CMD-check](https://github.com/Ebedthan/corebiota/workflows/R-CMD-check/badge.svg)](https://github.com/Ebedthan/corebiota/actions) [![Codecov test coverage](https://codecov.io/gh/Ebedthan/corebiota/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Ebedthan/corebiota?branch=main) [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0) [![Codacy Badge](https://app.codacy.com/project/badge/Grade/08d7c6cba76849f4bfae2cc3f0ef5b17)](https://www.codacy.com/gh/Ebedthan/corebiota/dashboard?utm_source=github.com&utm_medium=referral&utm_content=Ebedthan/corebiota&utm_campaign=Badge_Grade)

<!-- badges: end -->

## Probabilistic core microbiota analysis

The goal of corebiota is to provide a set of functions to easily and robustly perform core microbiota analysis from an ASV/OTU table. It also put emphasis on robustness by providing a probabilistic framework and reproducibility.

The API is as follow:

-   First, with the function [`sad`](https://ebedthan.github.io/corebiota/reference/sad.html) you can rapidly perform a species abundance distribution modeling following a Poisson distribution and identify microbes belonging to either core or satellite group in your community.

-   You can also directly get the core microbiota through [`get_core`](https://ebedthan.github.io/corebiota/reference/get_core.html).

Miscellaneous functions, nonetheless important, are:

-   [`plot_graph`](https://ebedthan.github.io/corebiota/reference/plot_graph.html) function which plot a nice graph showin the partition of you microbiome into satellite and core members.
-   [`get_satellite`](https://ebedthan.github.io/corebiota/reference/get_satellite.html) which return the satellite members of your community.

Yes, all the function can take as input a phyloseq object.

This package have only phyloseq as an external dependcy for your joy. We therefore, extensively use R Base and only pheatmap, covr and usethis as suggests.

## Installation

You can install the development version of corebiota like so:

``` r
# Install devtools package (if not already done!)
install.package("remotes")

# Load devtools package
library(remotes)

# Install corebiota package
install_github("Ebedthan/corebiota")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(corebiota)

# Some fake data
asv_tbl <- data.frame(sample1 = 1:10, sample2 = 10:1, sample3 = 80:89)
rownames(asv_tbl) <- paste0("ASV", "_", 1:10)

sad(asv_tbl)
```

Enjoy!

## Some great papers on designing a core microbiota analysis

-   Neu, A.T., Allen, E.E., Roy, K., 2021. Defining and quantifying the core microbiome: Challenges and prospects. PNAS 118. <https://doi.org/10.1073/pnas.2104429118>
-   Berg, G., Rybakova, D., Fischer, D. et al., 2020. Microbiome definition re-visited: old concepts and new challenges. Microbiome 8, 103. <https://doi.org/10.1186/s40168-020-00875-0>
-   Astudillo‐García, C., Bell, J.J., Webster, N.S. et al., 2017. Evaluating the core microbiota in complex communities: A systematic investigation. Environ Microbiol 19, 1450–1462. <https://doi.org/10.1111/1462-2920.13647>
