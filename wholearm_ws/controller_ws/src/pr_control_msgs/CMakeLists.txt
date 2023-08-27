cmake_minimum_required(VERSION 3.0.0)
project(pr_control_msgs VERSION 0.0.0)

find_package(catkin REQUIRED COMPONENTS
  actionlib_msgs
  sensor_msgs
  std_msgs
  trajectory_msgs
)

add_action_files(
  DIRECTORY action
  FILES
    SetForceTorqueThreshold.action
    SetPosition.action
    Trigger.action
    JointGroupCommand.action
    JointModeCommand.action
)

generate_messages(DEPENDENCIES
  actionlib_msgs
  sensor_msgs
  std_msgs
  trajectory_msgs
)

catkin_package(
  CATKIN_DEPENDS
    actionlib_msgs
    sensor_msgs
    std_msgs
    trajectory_msgs
)
