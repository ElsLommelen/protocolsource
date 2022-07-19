# bundled checks for protocols
library(protocolhelper)
protocol_code <- Sys.getenv("PROTOCOL_CODE")
  sapply(protocol_code, protocolhelper::check_frontmatter)
  sapply(protocol_code, protocolhelper::check_structure)
  #return(invisible(protocol_code))
