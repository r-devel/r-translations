# Translations from the Collaboration Campfire 

This repo provides translation files for the 
"How to Contribute to a Translation Team" [Collaboration Campfire](https://contributor.r-project.org/events/collaboration-campfires).

The `po_dir_setup.R` script provides code to 

1. Extract the `po` directories from 
a local copy of the R sources (e.g. a git checkout of r-devel/r-svn) and put 
them in this repo in a directory named by the current version of R-devel.
2. Download the source code for the recommended packages, extract the 
corresponding `po` directories (if they exist for the package) and put them in 
the `Recommended` directory of this repo.

The `branch_setup.R` script provides code to set up branches for each language, 
removing files for other languages for convenience.
