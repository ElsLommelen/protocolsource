# bundled checks for protocols
library(protocolhelper)
protocol_code <- Sys.getenv("PROTOCOL_CODE")
fail <- FALSE
tryCatch(
  protocolhelper::check_frontmatter(protocol_code),
  error = function(e) e,
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
