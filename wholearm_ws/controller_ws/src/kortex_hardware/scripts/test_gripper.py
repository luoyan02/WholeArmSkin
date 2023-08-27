#! /usr/bin/env python

import sys
import rospy
import actionlib
import pr_control_msgs.msg as msg

def jointcommand_client(value, timeout):
    # Quit
    if value == "q" or timeout < 0:
        return None

    client = actionlib.SimpleActionClient('/hand_position_controller/joint_group_command', msg.JointGroupCommandAction)

    print("Waiting for action server...")

    client.wait_for_server()

    print('Action server found!')

    goal = msg.JointGroupCommandGoal()
    goal.joint_names = ["finger_joint"]
    goal.command.positions = [value]
    # goal.command.velocities = [value]
    goal.command.time_from_start.secs = timeout

    client.send_goal(goal)

    client.wait_for_result()

    return client.get_result()


if __name__ == '__main__':
    try:
        # Initializes a rospy node so that the SimpleActionClient can
        # publish and subscribe over ROS.
        rospy.init_node('jointgroup_test_py')
        while True:
            val = input("Command: ")
            time = input("Timeout (s): ")
            print ("Input val: ", float(val))
            result = jointcommand_client(float(val), int(time))
            if result is None:
                print("Exiting...")
                break
            print("Result:", result.error_string)
    except rospy.ROSInterruptException:
        print("program interrupted before completion", file=sys.stderr)