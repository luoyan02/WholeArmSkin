#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_planner_parabolic" for configuration ""
set_property(TARGET aikido_planner_parabolic APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_planner_parabolic PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_planner_parabolic.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_planner_parabolic.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_planner_parabolic )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_planner_parabolic "${_IMPORT_PREFIX}/lib/libaikido_planner_parabolic.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
