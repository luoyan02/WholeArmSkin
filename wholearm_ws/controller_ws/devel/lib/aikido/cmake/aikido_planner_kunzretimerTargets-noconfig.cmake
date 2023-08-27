#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_planner_kunzretimer" for configuration ""
set_property(TARGET aikido_planner_kunzretimer APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_planner_kunzretimer PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_planner_kunzretimer.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_planner_kunzretimer.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_planner_kunzretimer )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_planner_kunzretimer "${_IMPORT_PREFIX}/lib/libaikido_planner_kunzretimer.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
