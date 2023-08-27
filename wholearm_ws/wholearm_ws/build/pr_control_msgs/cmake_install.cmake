# Install script for directory: /home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/emprise/wholearm_ws/wholearm_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
        file(MAKE_DIRECTORY "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}")
      endif()
      if (NOT EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin")
        file(WRITE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/.catkin" "")
      endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/emprise/wholearm_ws/wholearm_ws/install/_setup_util.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/emprise/wholearm_ws/wholearm_ws/install" TYPE PROGRAM FILES "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/_setup_util.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/emprise/wholearm_ws/wholearm_ws/install/env.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/emprise/wholearm_ws/wholearm_ws/install" TYPE PROGRAM FILES "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/env.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/emprise/wholearm_ws/wholearm_ws/install/setup.bash;/home/emprise/wholearm_ws/wholearm_ws/install/local_setup.bash")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/emprise/wholearm_ws/wholearm_ws/install" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/setup.bash"
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/local_setup.bash"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/emprise/wholearm_ws/wholearm_ws/install/setup.sh;/home/emprise/wholearm_ws/wholearm_ws/install/local_setup.sh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/emprise/wholearm_ws/wholearm_ws/install" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/setup.sh"
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/local_setup.sh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/emprise/wholearm_ws/wholearm_ws/install/setup.zsh;/home/emprise/wholearm_ws/wholearm_ws/install/local_setup.zsh")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/emprise/wholearm_ws/wholearm_ws/install" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/setup.zsh"
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/local_setup.zsh"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/emprise/wholearm_ws/wholearm_ws/install/.rosinstall")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/emprise/wholearm_ws/wholearm_ws/install" TYPE FILE FILES "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/.rosinstall")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/action" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs/action/SetForceTorqueThreshold.action"
    "/home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs/action/SetPosition.action"
    "/home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs/action/Trigger.action"
    "/home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs/action/JointGroupCommand.action"
    "/home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs/action/JointModeCommand.action"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/msg" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdAction.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdActionGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdActionResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdActionFeedback.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetForceTorqueThresholdFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/msg" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionAction.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionActionGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionActionResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionActionFeedback.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/SetPositionFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/msg" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerAction.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerActionGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerActionResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerActionFeedback.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/TriggerFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/msg" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandAction.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandActionGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandActionResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandActionFeedback.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointGroupCommandFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/msg" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandAction.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandActionGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandActionResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandActionFeedback.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandGoal.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandResult.msg"
    "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/pr_control_msgs/msg/JointModeCommandFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/cmake" TYPE FILE FILES "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/pr_control_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/include/pr_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/roseus/ros/pr_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/common-lisp/ros/pr_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/share/gennodejs/ros/pr_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/lib/python3/dist-packages/pr_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/emprise/wholearm_ws/wholearm_ws/devel/.private/pr_control_msgs/lib/python3/dist-packages/pr_control_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/pr_control_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/cmake" TYPE FILE FILES "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/pr_control_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs/cmake" TYPE FILE FILES
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/pr_control_msgsConfig.cmake"
    "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/catkin_generated/installspace/pr_control_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/pr_control_msgs" TYPE FILE FILES "/home/emprise/wholearm_ws/wholearm_ws/src/pr_control_msgs/package.xml")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/gtest/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/emprise/wholearm_ws/wholearm_ws/build/pr_control_msgs/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
