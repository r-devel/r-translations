# path to library in checkout of R sources
r_svn <- "../r-svn"
src_lib <- file.path(r_svn, "src", "library")

# N.B. This considers base packages only, need to extend to get po for
# Recommended files as well

# Get R version -----------------------------------------------------------

ver <- readLines(file.path(r_svn, "VERSION"))
ver <- gsub("(^[^ ]*).*", "\\1", ver)
dir.create(ver, showWarnings = FALSE)

# Identify packages with po files -----------------------------------------

po_dir <- dir(src_lib, pattern = "^[^.]*po$",
              include.dirs = TRUE, recursive = TRUE)
pkg <- sub("/po", "", po_dir)


# Copy over contents of po dir --------------------------------------------

# Seem to need gc() to avoid slow down
for (i in seq_along(po_dir)){
    message(po_dir[i])
    dir.create(file.path(ver, po_dir[i]),
               showWarnings = FALSE, recursive = TRUE)
    file.copy(file.path(src_lib, po_dir[i]), file.path(ver, pkg[i]),
              recursive=TRUE)
    gc()
}

