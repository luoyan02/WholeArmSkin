#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_constraint" for configuration ""
set_property(TARGET aikido_constraint APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_constraint PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_constraint.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_constraint.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_constraint )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_constraint "${_IMPORT_PREFIX}/lib/libaikido_constraint.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
