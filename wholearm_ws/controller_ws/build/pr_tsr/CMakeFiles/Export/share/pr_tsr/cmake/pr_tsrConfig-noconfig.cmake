#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "pr_tsr" for configuration ""
set_property(TARGET pr_tsr APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(pr_tsr PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpr_tsr.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS pr_tsr )
list(APPEND _IMPORT_CHECK_FILES_FOR_pr_tsr "${_IMPORT_PREFIX}/lib/libpr_tsr.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
