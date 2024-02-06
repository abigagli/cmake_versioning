# execute_process( COMMAND git describe --abbrev=7 --dirty --always --all --long
# OUTPUT_VARIABLE CURRENT_GIT_DESCRIBE OUTPUT_STRIP_TRAILING_WHITESPACE)

set(DEPLOYED_MAJOR 1)
set(DEPLOYED_MINOR 0)

set(VERSION_FILE "next_deploy_version.txt")

if(EXISTS ${VERSION_FILE})
  file(READ ${VERSION_FILE} content)
  string(STRIP "${content}" content)
  list(GET content 0 DEPLOYED_MAJOR)
  list(GET content 1 DEPLOYED_MINOR)
endif()

message(STATUS "CURRENT DEPLOY VERSION: ${DEPLOYED_MAJOR}.${DEPLOYED_MINOR}")
configure_file(${VERSION_TEMPLATE_FILE} ${VERSION_SOURCE_FILE} @ONLY)

math(EXPR DEPLOYED_MINOR "${DEPLOYED_MINOR} + 1")
file(WRITE ${VERSION_FILE} "${DEPLOYED_MAJOR};${DEPLOYED_MINOR}")
