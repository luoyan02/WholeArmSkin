#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_planner_ompl" for configuration ""
set_property(TARGET aikido_planner_ompl APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_planner_ompl PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_planner_ompl.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_planner_ompl.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_planner_ompl )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_planner_ompl "${_IMPORT_PREFIX}/lib/libaikido_planner_ompl.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
