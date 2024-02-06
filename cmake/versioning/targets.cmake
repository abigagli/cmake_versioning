add_custom_target(
  _generate_git_sha
  COMMAND
    ${CMAKE_COMMAND}
    -DVERSION_TEMPLATE_FILE=${CMAKE_CURRENT_LIST_DIR}/version_git_only.c.in
    -DVERSION_SOURCE_FILE=version_git_only.c -P
    ${CMAKE_CURRENT_LIST_DIR}/git_sha.cmake
  BYPRODUCTS version_git_only.c)

add_custom_target(
  _generate_deploy_version
  COMMAND
    ${CMAKE_COMMAND}
    -DVERSION_TEMPLATE_FILE=${CMAKE_CURRENT_LIST_DIR}/version_deploy.c.in
    -DVERSION_SOURCE_FILE=version_deploy.c -P
    ${CMAKE_CURRENT_LIST_DIR}/deploy_version.cmake
  BYPRODUCTS version_deploy.c)

macro(ADD_DEPLOY_TARGET_FOR target_name image_basename images_folder)
  add_custom_target(
    deploy_${target_name}
    COMMAND
      ${CMAKE_SOURCE_DIR}/scripts/deploy_with_crc_and_version.sh
      # ${images_folder} $<TARGET_FILE_DIR:${target_name}>/${target_name}.bin
      ${images_folder} $<TARGET_FILE:${target_name}> ${image_basename}
      ${CMAKE_BINARY_DIR}/next_deploy_version.txt
    DEPENDS ${target_name})
endmacro()