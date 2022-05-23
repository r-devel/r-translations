library(rvest)

# path to library in checkout of R sources (from GitHub or svn)
r_svn <- "../r-svn"
src_lib <- file.path(r_svn, "src", "library")

# Get R version -----------------------------------------------------------

## extract version from R sources
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

# Download po directories for recommended packages ------------------------

## get list of available tarballs for recommended packages
rec_url <- file.path("https://cran.r-project.org/src/contrib", ver,
                     "Recommended")
rec_html <- read_html(rec_url)
tar <- html_attr(html_nodes(rec_html, xpath="//a[contains(., '.tar.gz')]"),
                 "href")
rec_pkg <- gsub("([^_]+).*", "\\1", tar)
dir.create("Recommended", showWarnings = FALSE)

## download into temp file and extract po sub-directory (if present)
tmp <- tempfile(fileext = ".tar.gz")
for (i in seq_along(rec_pkg)){
    message(tar[i])
    download.file(file.path(cran, tar[i]), tmp)
    system(paste0("tar -xvf ", tmp, " -C Recommended ", rec_pkg[i], "/po"))
}
