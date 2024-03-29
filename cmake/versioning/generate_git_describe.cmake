execute_process(
  COMMAND git describe --abbrev=7 --dirty --always --all --long
  OUTPUT_VARIABLE CURRENT_GIT_DESCRIBE
  OUTPUT_STRIP_TRAILING_WHITESPACE)

message(STATUS "CURRENT GIT DESCRIBE: ${CURRENT_GIT_DESCRIBE}")
configure_file(${VERSION_TEMPLATE_FILE} ${VERSION_SOURCE_FILE})
