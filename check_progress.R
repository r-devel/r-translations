
# script to check progress for a given language ---------------------------

library(tibble)
library(purrr)

get_po_status <- function(pot_file, lang) {
    # define matching po_file file
    po_file <- paste0(lang, ".po")
    if (grepl("RGui.*", pot_file)) po_file <- paste0("RGui-", po_file)
    if (grepl("R-.*", pot_file)) po_file <- paste0("R-", po_file)
    po_file <- file.path(dirname(pot_file), po_file)
    if (!file.exists(po_file)){
        return(tibble(pot = pot_file,
                      n = NA,
                      translated = NA,
                      fuzzy = NA))
    }
    txt <- readLines(po_file, encoding = "UTF-8")
    # get lines for untranslated and (potentially) translated strings
    msg_id <- grep("^msgid ", txt)[-1]
    msgstr_id <- grep('^msgstr( \\"|\\[0).*', txt)[-1]

    # split text into entries for each message
    new_entry <- which(txt == "")
    n_lines <- diff(c(0, new_entry, length(txt)))
    grp <- rep.int(x = seq(0, length(n_lines) - 1), times = n_lines)
    entries <- split(txt, grp)[-1]

    # ignore old messages
    any_grepl <- function(x, pattern) any(grepl(pattern, x))
    old <- vapply(entries, any_grepl, logical(1), "#~")
    entries <- entries[!old]

    # fuzzy translations
    fuzzy <- vapply(entries, any_grepl, logical(1), "^#,.*fuzzy.*")

    # translated messages
    translated <- grepl('\\".+\\"', txt[msgstr_id]) |
        grepl('\\".+\\"', txt[msgstr_id + 1])

    # summarise
    tibble(pot = pot_file,
           n = length(entries),
           translated = mean(translated),
           fuzzy = mean(fuzzy))
}

# set language code -------------------------------------------------------

# https://www.phpkb.com/kb/article/iso-639-1-standard-language-codes-255.html
if (interactive()) lang <- "es"

# get current status-------------------------------------------------------

pot <- list.files(pattern = paste0("*[.]pot$"), recursive = TRUE)
po_status <- map_df(pot, get_po_status, lang = lang)

if (interactive()) View(po_status)

if (!interactive()) po_status
