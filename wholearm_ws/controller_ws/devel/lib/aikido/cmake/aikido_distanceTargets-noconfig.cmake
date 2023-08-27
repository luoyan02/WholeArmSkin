#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_distance" for configuration ""
set_property(TARGET aikido_distance APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_distance PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_distance.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_distance.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_distance )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_distance "${_IMPORT_PREFIX}/lib/libaikido_distance.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
