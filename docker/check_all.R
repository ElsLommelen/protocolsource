# bundled checks for protocols

check_all <- function(protocol_code) {
  sapply(protocol_code, protocolhelper::check_frontmatter)
  #sapply(protocolcode, protocolhelper::check_structure)
  return(invisible(protocol_code))
}
