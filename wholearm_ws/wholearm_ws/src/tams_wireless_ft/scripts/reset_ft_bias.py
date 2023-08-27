#! /usr/bin/env python

import actionlib
import rospy
from pr_control_msgs.msg import (TriggerAction, TriggerActionFeedback,
                                 TriggerResult)
from std_srvs.srv import Empty


class ResetBiasActionServer(object):
    # create messages that are used to publish feedback/result
    _result = TriggerResult()

    def __init__(self):
        self._action_name = "/forque/bias_controller/trigger"
        self._as = actionlib.SimpleActionServer(
            self._action_name, TriggerAction, execute_cb=self.execute_reset_cb, auto_start=False)
        self._as.start()

    def execute_reset_cb(self, goal):
        r = rospy.Rate(1)
        success = True

        rospy.wait_for_service('wireless_ft/reset_bias')
        try:
            reset_bias = rospy.ServiceProxy(
                'wireless_ft/reset_bias', Empty)
            resp = reset_bias()
        except rospy.ServiceException as e:
            success = False
            print("Service call failed: %s" % e)

        # self._result.success = success
        if success:
            self._result.message = "Reset bias completed."
        else:
            self._result.message = "Reset bias failed. Unable to reach wireless_ft/reset_bias service"
        self._as.set_succeeded(self._result)


if __name__ == '__main__':
    rospy.init_node('reset_ft_bias')
    server = ResetBiasActionServer()
    rospy.spin()
