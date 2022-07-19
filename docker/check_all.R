# bundled checks for protocols
check_all <- function(protocol_code) {
  #protocol_code <- Sys.getenv("PROTOCOL_CODE")
  fail <- FALSE
  tryCatch(
    protocolhelper::check_frontmatter(protocol_code),
    error = function(e) paste0(e, "\n\n"),
    fail = TRUE
  )
  tryCatch(
    protocolhelper::check_structure(protocol_code),
    error = function(e) e,
    fail = TRUE
  )
  if (fail) {
    stop("\nThe source code failed some checks. Please check the error message above.\n")
  }
}
check_all(Sys.getenv("PROTOCOL_CODE"))  
