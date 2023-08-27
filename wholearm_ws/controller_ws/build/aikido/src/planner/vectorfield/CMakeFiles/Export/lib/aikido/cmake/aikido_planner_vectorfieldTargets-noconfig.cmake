#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_planner_vectorfield" for configuration ""
set_property(TARGET aikido_planner_vectorfield APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_planner_vectorfield PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_planner_vectorfield.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_planner_vectorfield.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_planner_vectorfield )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_planner_vectorfield "${_IMPORT_PREFIX}/lib/libaikido_planner_vectorfield.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
