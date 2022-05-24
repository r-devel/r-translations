
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Translations from the Collaboration Campfire

This repo provides translation files for the “How to Contribute to a
Translation Team” [Collaboration
Campfire](https://contributor.r-project.org/events/collaboration-campfires).

The `po_dir_setup.R` script provides code to

1.  Extract the `po` directories from a local copy of the R sources
    (e.g. a git checkout of r-devel/r-svn) and put them in this repo in
    a directory named by the current version of R-devel.
2.  Download the source code for the recommended packages, extract the
    corresponding `po` directories (if they exist for the package) and
    put them in the `Recommended` directory of this repo.

The `branch_setup.R` script provides code to set up branches for each
language, removing files for other languages for convenience.

The `create-todo.R` script provides code to create an issue with a TODO
list for each language. The TODO is a checklist of all `.pot` files,
checked off if there exists a corresponding `.po` file for that
language, with all messages translated and none marked as fuzzy.

The `check_progress.R` script provides code to check progress for a
given language, producing a table as follows

``` r
lang <- "de"
library(devtools)
#> Loading required package: usethis
po_status <- source_url("https://raw.githubusercontent.com/r-devel/translations-campfire/main/check_progress.R")
#> ℹ SHA-1 hash of file is ce6513224e87563d09fb3da80183b3484939636d
knitr::kable(po_status$value)
```

| pot                                        |    n | translated |     fuzzy |
|:-------------------------------------------|-----:|-----------:|----------:|
| 4.3.0/base/po/R-base.pot                   |  583 |  0.9348199 | 0.0480274 |
| 4.3.0/base/po/R.pot                        | 1642 |  0.9713764 | 0.0517661 |
| 4.3.0/base/po/RGui.pot                     |  264 |  1.0000000 | 0.0227273 |
| 4.3.0/compiler/po/R-compiler.pot           |   38 |  1.0000000 | 0.0000000 |
| 4.3.0/graphics/po/graphics.pot             |  129 |  0.9767442 | 0.0155039 |
| 4.3.0/graphics/po/R-graphics.pot           |  154 |  0.9870130 | 0.0324675 |
| 4.3.0/grDevices/po/grDevices.pot           |  194 |  0.8711340 | 0.0360825 |
| 4.3.0/grDevices/po/R-grDevices.pot         |  142 |  0.9014085 | 0.0211268 |
| 4.3.0/grid/po/grid.pot                     |   38 |  0.6052632 | 0.0000000 |
| 4.3.0/grid/po/R-grid.pot                   |  174 |  0.9367816 | 0.0862069 |
| 4.3.0/methods/po/methods.pot               |   30 |  0.9000000 | 0.0333333 |
| 4.3.0/methods/po/R-methods.pot             |  406 |  0.9852217 | 0.0172414 |
| 4.3.0/parallel/po/parallel.pot             |   22 |  1.0000000 | 0.0000000 |
| 4.3.0/parallel/po/R-parallel.pot           |   37 |  0.8648649 | 0.0270270 |
| 4.3.0/splines/po/R-splines.pot             |   23 |  1.0000000 | 0.0000000 |
| 4.3.0/splines/po/splines.pot               |    3 |  1.0000000 | 0.0000000 |
| 4.3.0/stats/po/R-stats.pot                 |  794 |  0.9911839 | 0.0277078 |
| 4.3.0/stats/po/stats.pot                   |  209 |  0.9330144 | 0.0047847 |
| 4.3.0/stats4/po/R-stats4.pot               |    8 |  0.5000000 | 0.1250000 |
| 4.3.0/tcltk/po/R-tcltk.pot                 |   30 |  0.9666667 | 0.0000000 |
| 4.3.0/tcltk/po/tcltk.pot                   |   10 |  0.9000000 | 0.0000000 |
| 4.3.0/tools/po/R-tools.pot                 |  423 |  0.9101655 | 0.0449173 |
| 4.3.0/tools/po/tools.pot                   |   37 |  0.9189189 | 0.0540541 |
| 4.3.0/utils/po/R-utils.pot                 |  413 |  0.9370460 | 0.0411622 |
| 4.3.0/utils/po/utils.pot                   |   59 |  0.9661017 | 0.0677966 |
| Recommended/boot/po/R-boot.pot             |   78 |  1.0000000 | 0.0000000 |
| Recommended/class/po/R-class.pot           |   15 |  1.0000000 | 0.0000000 |
| Recommended/cluster/po/cluster.pot         |    7 |  1.0000000 | 0.0000000 |
| Recommended/cluster/po/R-cluster.pot       |   96 |  1.0000000 | 0.0000000 |
| Recommended/foreign/po/foreign.pot         |  162 |  1.0000000 | 0.0000000 |
| Recommended/foreign/po/R-foreign.pot       |   47 |  1.0000000 | 0.0000000 |
| Recommended/KernSmooth/po/R-KernSmooth.pot |    7 |  0.8571429 | 0.0000000 |
| Recommended/lattice/po/R-lattice.pot       |  128 |  1.0000000 | 0.0000000 |
| Recommended/MASS/po/R-MASS.pot             |  174 |  1.0000000 | 0.0000000 |
| Recommended/Matrix/po/Matrix.pot           |  242 |  1.0000000 | 0.0000000 |
| Recommended/Matrix/po/R-Matrix.pot         |  242 |  0.9834711 | 0.0041322 |
| Recommended/mgcv/po/mgcv.pot               |   14 |  1.0000000 | 0.0000000 |
| Recommended/mgcv/po/R-mgcv.pot             |  444 |  1.0000000 | 0.0000000 |
| Recommended/nlme/po/nlme.pot               |   12 |  1.0000000 | 0.0000000 |
| Recommended/nlme/po/R-nlme.pot             |  335 |  0.9970149 | 0.0119403 |
| Recommended/nnet/po/R-nnet.pot             |   25 |  1.0000000 | 0.0000000 |
| Recommended/rpart/po/R-rpart.pot           |   63 |  1.0000000 | 0.0000000 |
| Recommended/rpart/po/rpart.pot             |   12 |  1.0000000 | 0.0000000 |
| Recommended/spatial/po/R-spatial.pot       |   13 |  1.0000000 | 0.0000000 |
