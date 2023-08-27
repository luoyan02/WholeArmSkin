# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "actionlib;actionlib_msgs;controller_interface;pr_control_msgs;pr_hardware_interfaces;realtime_tools".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-ltrigger_controller".split(';') if "-ltrigger_controller" != "" else []
PROJECT_NAME = "trigger_controller"
PROJECT_SPACE_DIR = "/home/emprise/wholearm_ws/controller_ws/install"
PROJECT_VERSION = "0.0.0"
