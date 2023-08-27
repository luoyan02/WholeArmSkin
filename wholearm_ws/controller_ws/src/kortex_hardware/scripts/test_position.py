#! /usr/bin/env python

import sys
import rospy
import actionlib
import pr_control_msgs.msg as msg

def jointcommand_client(positions, timeout):
    # Quit
    if timeout < 0:
        return None

    client = actionlib.SimpleActionClient('/compliant_controller/joint_group_command', msg.JointGroupCommandAction)

    print("Waiting for action server...")

    client.wait_for_server()

    print('Action server found!')

    goal = msg.JointGroupCommandGoal()
    goal.joint_names = ["joint_1", "joint_2", "joint_3", "joint_4", "joint_5", "joint_6", "joint_7"]
    goal.command.positions = positions
    goal.command.velocities = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.01]
    goal.command.time_from_start.secs = timeout

    client.send_goal(goal)

    client.wait_for_result()

    return client.get_result()


if __name__ == '__main__':
    try:
        # Initializes a rospy node so that the SimpleActionClient can
        # publish and subscribe over ROS.
        rospy.init_node('jointgroup_test_py')
        positions = [0.0017557061135402012, 0.24578663240234364, 3.1354431483166914, 4.026839650473146, 6.275645898133572, 0.9843345657716588, 1.7085074546565124]
        # 0.003 0.24 3.18 4.04 6.28 9.9103e-01 1.8368e+00
        while True:
            print ("Current position: ", )
            val = input("Command: ")
            dof = input("DOF: ")
            time = input("Timeout (s): ")
            positions[int(dof) - 1] = float(val)
            result = jointcommand_client(positions, int(time))
            if result is None:
                print("Exiting...")
                break
            print("Result:", result.error_string)
    except rospy.ROSInterruptException:
        print("program interrupted before completion", file=sys.stderr)