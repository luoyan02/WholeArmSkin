#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "libada" for configuration ""
set_property(TARGET libada APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(libada PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libada.so"
  IMPORTED_SONAME_NOCONFIG "libada.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS libada )
list(APPEND _IMPORT_CHECK_FILES_FOR_libada "${_IMPORT_PREFIX}/lib/libada.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
