#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_common" for configuration ""
set_property(TARGET aikido_common APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_common PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_common.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_common.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_common )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_common "${_IMPORT_PREFIX}/lib/libaikido_common.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
