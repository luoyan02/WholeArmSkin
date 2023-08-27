#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_rviz" for configuration ""
set_property(TARGET aikido_rviz APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_rviz PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_rviz.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_rviz.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_rviz )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_rviz "${_IMPORT_PREFIX}/lib/libaikido_rviz.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
