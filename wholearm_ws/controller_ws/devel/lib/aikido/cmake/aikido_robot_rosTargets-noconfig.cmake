#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "aikido_robot_ros" for configuration ""
set_property(TARGET aikido_robot_ros APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(aikido_robot_ros PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libaikido_robot_ros.so"
  IMPORTED_SONAME_NOCONFIG "libaikido_robot_ros.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS aikido_robot_ros )
list(APPEND _IMPORT_CHECK_FILES_FOR_aikido_robot_ros "${_IMPORT_PREFIX}/lib/libaikido_robot_ros.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
