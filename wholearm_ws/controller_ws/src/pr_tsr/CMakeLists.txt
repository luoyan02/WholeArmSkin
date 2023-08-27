cmake_minimum_required(VERSION 2.8.12)
project(pr_tsr)
set(library_VERSION 0.1.0)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")


#================================================================================
# Dependencies
#

find_package(DART REQUIRED)
include_directories(${DART_INCLUDE_DIRS})

find_package(aikido REQUIRED COMPONENTS
  constraint)
include_directories(${aikido_INCLUDE_DIRS})


#================================================================================
# Library
#

add_library(pr_tsr STATIC
  include/pr_tsr/block_bin.hpp
  include/pr_tsr/block.hpp
  include/pr_tsr/food_item.hpp
  include/pr_tsr/fuze.hpp
  include/pr_tsr/plate.hpp
  include/pr_tsr/glass.hpp
  include/pr_tsr/table.hpp
  include/pr_tsr/valve.hpp)
set_target_properties(pr_tsr PROPERTIES LINKER_LANGUAGE CXX)

target_include_directories(pr_tsr PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
  $<INSTALL_INTERFACE:include>
  PRIVATE src)
set_property(TARGET pr_tsr PROPERTY VERSION ${library_VERSION})

target_link_libraries(pr_tsr
  ${DART_LIBRARIES}
  ${aikido_LIBRARIES})


#================================================================================
# Installation
#

install(TARGETS pr_tsr EXPORT pr_tsrConfig
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin)
install(DIRECTORY include/ DESTINATION include)

# This makes the project importable from the install directory
install(EXPORT pr_tsrConfig DESTINATION share/pr_tsr/cmake)

# This makes the project importable from the build directory
export(TARGETS pr_tsr FILE pr_tsrConfig.cmake)

# Install the package.xml file (to satisfy REP-136).
install(FILES "package.xml"
  DESTINATION "share/pr_tsr")


#================================================================================
# Formatting
#

find_program(CLANG_FORMAT_EXECUTABLE NAMES clang-format-6.0)

if(CLANG_FORMAT_EXECUTABLE)
  message(STATUS "Found clang-format.")

  file(GLOB_RECURSE ALL_SOURCE_FILES
    LIST_DIRECTORIES false
    include/*.h include/*.hpp src/*.c src/*.cpp tests/*.cpp tests/*.hpp)
  list(LENGTH ALL_SOURCE_FILES NUM_SOURCE_FILES)

  add_custom_target(format
    COMMAND ${CMAKE_COMMAND} -E echo "Formatting ${NUM_SOURCE_FILES} files..."
    COMMAND ${CLANG_FORMAT_EXECUTABLE} -style=file -i ${ALL_SOURCE_FILES}
    COMMAND ${CMAKE_COMMAND} -E echo "Done."
    DEPENDS ${CLANG_FORMAT_EXECUTABLE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})

  add_custom_target(check-format
    COMMAND ${CMAKE_COMMAND} -E echo "Checking code style of"
            "${NUM_SOURCE_FILES} files... "
    COMMAND ${CMAKE_SOURCE_DIR}/tools/check_format.sh
            ${CLANG_FORMAT_EXECUTABLE} ${ALL_SOURCE_FILES}
    COMMAND ${CMAKE_COMMAND} -E echo "Done."
    DEPENDS ${CLANG_FORMAT_EXECUTABLE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
else()
  message(STATUS "Looking for clang-format - NOT found, please install "
      "clang-format to enable automatic code formatting.")
endif()
