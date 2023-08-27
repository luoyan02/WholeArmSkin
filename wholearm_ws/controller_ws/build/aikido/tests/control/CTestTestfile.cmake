# CMake generated Testfile for 
# Source directory: /home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control
# Build directory: /home/emprise/wholearm_ws/controller_ws/build/aikido/tests/control
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_ControlExecutor "test_ControlExecutor")
set_tests_properties(test_ControlExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;1;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_InstantaneousTrajectoryExecutor "test_InstantaneousTrajectoryExecutor")
set_tests_properties(test_InstantaneousTrajectoryExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;6;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_JacobianExecutor "test_JacobianExecutor")
set_tests_properties(test_JacobianExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;11;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_KinematicSimulationTrajectoryExecutor "test_KinematicSimulationTrajectoryExecutor")
set_tests_properties(test_KinematicSimulationTrajectoryExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;16;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_KinematicSimulationPositionExecutor "test_KinematicSimulationPositionExecutor")
set_tests_properties(test_KinematicSimulationPositionExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;21;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_KinematicSimulationVelocityExecutor "test_KinematicSimulationVelocityExecutor")
set_tests_properties(test_KinematicSimulationVelocityExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;26;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_QueuedTrajectoryExecutor "test_QueuedTrajectoryExecutor")
set_tests_properties(test_QueuedTrajectoryExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;31;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
add_test(test_VisualServoingVelocityExecutor "test_VisualServoingVelocityExecutor")
set_tests_properties(test_VisualServoingVelocityExecutor PROPERTIES  _BACKTRACE_TRIPLES "/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/CMakeLists.txt;11;add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;36;aikido_add_test;/home/emprise/wholearm_ws/controller_ws/src/aikido/tests/control/CMakeLists.txt;0;")
subdirs("ros")
