# CMake generated Testfile for 
# Source directory: /home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner
# Build directory: /home/emprise/wholearm_ws/controller_ws/build/aikido/tests/planner
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_SnapPlanner "test_SnapPlanner")
set_tests_properties(test_SnapPlanner PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner/CMakeLists.txt;6;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner/CMakeLists.txt;0;")
add_test(test_DartPlanners "test_DartPlanners")
set_tests_properties(test_DartPlanners PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner/CMakeLists.txt;13;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner/CMakeLists.txt;0;")
add_test(test_World "test_World")
set_tests_properties(test_World PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner/CMakeLists.txt;20;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/planner/CMakeLists.txt;0;")
subdirs("parabolic")
subdirs("ompl")
subdirs("vectorfield")
subdirs("kunzretimer")
