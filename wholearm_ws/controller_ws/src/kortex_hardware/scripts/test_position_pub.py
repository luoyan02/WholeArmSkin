#! /usr/bin/env python

import sys
import rospy
import actionlib
from trajectory_msgs.msg import JointTrajectoryPoint


if __name__ == '__main__':
    try:
        # Initializes a rospy node so that the SimpleActionClient can
        # publish and subscribe over ROS.
        rospy.init_node('jointgroup_test_py')
        positions = [0.001, 0.26,  3.14, 3.98, 0.0001,  0.94, 1.57]
        cmd_pub = rospy.Publisher('/compliant_controller/command', JointTrajectoryPoint,
                queue_size=1)
        goal = JointTrajectoryPoint()
        while True:
            print ("Current position: ", )
            val = input("Command: ")
            dof = input("DOF: ")
            time = input("Timeout (s): ")
            timeout = float(time)
            positions[int(dof) - 1] = float(val)
            if timeout < 0:
                break

            
            # goal.joint_names = ["joint_1", "joint_2", "joint_3", "joint_4", "joint_5", "joint_6", "joint_7"]
            goal.positions = positions
            goal.velocities = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.02]
            goal.time_from_start = rospy.Duration(timeout)
            cmd_pub.publish(goal)
            # input("Press Enter to continue...")

    except rospy.ROSInterruptException:
        print("program interrupted before completion", file=sys.stderr)