# coremicrobiota <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/Ebedthan/coremicrobiota/workflows/R-CMD-check/badge.svg)](https://github.com/Ebedthan/coremicrobiota/actions)
[![Codecov test coverage](https://codecov.io/gh/Ebedthan/coremicrobiota/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Ebedthan/coremicrobiota?branch=main)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/08d7c6cba76849f4bfae2cc3f0ef5b17)](https://www.codacy.com/gh/Ebedthan/coremicrobiota/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=Ebedthan/coremicrobiota&amp;utm_campaign=Badge_Grade)
<!-- badges: end -->

## Core Microbiota Analysis with automated accounting for library size difference

The goal of coremicrobiota is to provide a set of functions to easily and efficiently perform core microbiota analysis from an ASV/OTU table. It also put emphasis on accounting library size difference in core microbiota analysis by introducing the rarefaction aware index. 

The API is as follow:

*  First, with the function [`core_microbiota`](https://ebedthan.github.io/coremicrobiota/reference/core_microbiota.html) you can rapidly perform a core microbiota analysis while accounting for different library size through the rarefaction aware index.

*  You can also directly compute the [`rarefaction_aware_index`](https://ebedthan.github.io/coremicrobiota/reference/rarefaction_aware_index.html), using two set of core microbiota members.

Miscellaneous functions are:

*  [`stats`](https://ebedthan.github.io/coremicrobiota/reference/stats.html) function which compute the overall relative abundance and ubiquity of each ASV/OTU.
*  [`core_table`](https://ebedthan.github.io/coremicrobiota/reference/core_table.html) which return the core microbiota taxa informations in a table.

Yes, all the function can take as input a phyloseq object.

This package have only phyloseq as an external dependcy for your joy. We therefore,
extensively use R Base and only pheatmap, covr and usethis as suggests.

## Installation

You can install the development version of coremicrobiota like so:

``` r
# Install devtools package (if not already done!)
install.package("remotes")

# Load devtools package
library(remotes)

# Install coremicrobiota package
install_github("Ebedthan/coremicrobiota")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(coremicrobiota)

# Some fake data
asv_tbl <- data.frame(sample1 = 1:10, sample2 = 10:1, sample3 = 80:89)
rownames(asv_tbl) <- paste0("ASV", "_", 1:10)

core_microbiota(asv_tbl)
```

Enjoy!

## Some great papers on designing a core microbiota analysis

*  Neu, A.T., Allen, E.E., Roy, K., 2021. Defining and quantifying the core microbiome: Challenges and prospects. PNAS 118. https://doi.org/10.1073/pnas.2104429118
*  Berg, G., Rybakova, D., Fischer, D., Cernava, T., Vergès, M.-C.C., Charles, T., Chen, X., Cocolin, L., Eversole, K., Corral, G.H., Kazou, M., Kinkel, L., Lange, L., Lima, N., Loy, A., Macklin, J.A., Maguin, E., Mauchline, T., McClure, R., Mitter, B., Ryan, M., Sarand, I., Smidt, H., Schelkle, B., Roume, H., Kiran, G.S., Selvin, J., Souza, R.S.C. de, van Overbeek, L., Singh, B.K., Wagner, M., Walsh, A., Sessitsch, A., Schloter, M., 2020. Microbiome definition re-visited: old concepts and new challenges. Microbiome 8, 103. https://doi.org/10.1186/s40168-020-00875-0
*  Astudillo‐García, C., Bell, J.J., Webster, N.S., Glasl, B., Jompa, J., Montoya, J.M., Taylor, M.W., 2017. Evaluating the core microbiota in complex communities: A systematic investigation. Environ Microbiol 19, 1450–1462. https://doi.org/10.1111/1462-2920.13647







