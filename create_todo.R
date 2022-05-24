library(gh)
library(tibble)
library(purrr)

lang <- c("zh_CN", "zh_TW", "da", "fr", "de", "en_GB", "hi", "hu", "it",
          "ja", "ko", "lt", "nn", "pl", "pt", "pt_BR", "ru", "es", "tr")
ver <- "4.3.0"

pot <- list.files(pattern = paste0("*[.]pot$"), recursive = TRUE)
po <- list.files(pattern = paste0("*", lang, "[.]po$"), recursive = TRUE)

get_po_status <- function(pot_file, lang) {
    # define matching po_file file
    po_file <- paste0(lang, ".po")
    if (grepl("RGui.*", pot_file)) po_file <- paste0("RGui-", po_file)
    if (grepl("R-.*", pot_file)) po_file <- paste0("R-", po_file)
    po_file <- file.path(dirname(pot_file), po_file)
    if (!file.exists(po_file)){
        return(tibble(pot = pot_file,
                      translated = 0,
                      fuzzy = 0))
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
           translated = mean(translated),
           fuzzy = mean(fuzzy))
}

for (i in seq_along(lang)[-1]){
    po_status <- map_df(pot, get_po_status, lang = lang[i])

    # create TODO list
    n <- length(pot)
    checkbox <- rep("- [ ] ", n)
    checkbox[po_status$translated == 1 & po_status$fuzzy == 0] <- "- [x] "

    gh::gh(
        endpoint = "POST /repos/r-devel/translations-campfire/issues",
        title = paste(lang[i], "TODO for R version", ver),
        body = paste0(checkbox, "`", po_status$pot, "`", collapse = "\n")
    )
}
