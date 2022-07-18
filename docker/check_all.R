# bundled checks for protocols
library(protocolhelper)
check_all <- function(protocol_code) {
  sapply(protocol_code, protocolhelper::check_frontmatter)
  sapply(protocol_code, protocolhelper::check_structure)
  #return(invisible(protocol_code))
}
check_all(Sys.getenv("PROTOCOL_CODE"))
