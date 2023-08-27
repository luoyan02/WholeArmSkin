#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_statespace" for configuration ""
set_property(TARGET aikido_statespace APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_statespace PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_statespace.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_statespace.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_statespace )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_statespace "${_IMPORT_PREFIX}/lib/libaikido_statespace.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
