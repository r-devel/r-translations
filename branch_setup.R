library(git2r)

# use `config()` to set user.name and user.email for commits
config(user.name = NULL, user.email = NULL)

# set languages to create branches for (put regional variations together)
# https://www.phpkb.com/kb/article/iso-639-1-standard-language-codes-255.html
lang <- c("zh", "da", "fr", "de", "en", "hi", "hu", "it", "ja", "ko", "lt",
          "nn", "pl", "pt", "ru", "es", "tr")

for (i in seq_along(lang)[-1]){
    # checkout main branch to start with
    checkout(branch = "main")
    # create lang branch from main and checkout
    checkout(branch = lang[i], create = TRUE)
    # sync with branch of same name on the remote repo
    push(name = "origin", refspec = paste0("refs/heads/", lang[i]),
         set_upstream = TRUE)

    # remove all .po except lang.po, R-lang.po or RGui-lang.po
    all_po <- list.files(pattern = "*[.]po$", recursive = TRUE)
    keep <- list.files(pattern = paste0("*", lang[i], ".*po"), recursive = TRUE)
    file.remove(setdiff(all_po, keep))

    # commit change
    commit(message = "remove files for other languages", all = TRUE)
    push()
}
