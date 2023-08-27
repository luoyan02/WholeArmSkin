;; Auto-generated. Do not edit!


(when (boundp 'pr_control_msgs::JointModeCommandGoal)
  (if (not (find-package "PR_CONTROL_MSGS"))
    (make-package "PR_CONTROL_MSGS"))
  (shadow 'JointModeCommandGoal (find-package "PR_CONTROL_MSGS")))
(unless (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL")
  (make-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))

(in-package "ROS")
;;//! \htmlinclude JointModeCommandGoal.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*BEGIN*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*BEGIN* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*BEGIN* -1)
(intern "*POSITION*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*POSITION* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*POSITION* 0)
(intern "*VELOCITY*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*VELOCITY* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*VELOCITY* 1)
(intern "*EFFORT*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*EFFORT* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*EFFORT* 2)
(intern "*NOMODE*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*NOMODE* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*NOMODE* 3)
(intern "*OTHER*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*OTHER* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*OTHER* 3)
(intern "*EMERGENCY_STOP*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*EMERGENCY_STOP* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*EMERGENCY_STOP* 4)
(intern "*SWITCHING*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*SWITCHING* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*SWITCHING* 5)
(intern "*ERROR*" (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(shadow '*ERROR* (find-package "PR_CONTROL_MSGS::JOINTMODECOMMANDGOAL"))
(defconstant pr_control_msgs::JointModeCommandGoal::*ERROR* 6)

(defun pr_control_msgs::JointModeCommandGoal-to-symbol (const)
  (cond
        ((= const -1) 'pr_control_msgs::JointModeCommandGoal::*BEGIN*)
        ((= const 0) 'pr_control_msgs::JointModeCommandGoal::*POSITION*)
        ((= const 1) 'pr_control_msgs::JointModeCommandGoal::*VELOCITY*)
        ((= const 2) 'pr_control_msgs::JointModeCommandGoal::*EFFORT*)
        ((= const 3) 'pr_control_msgs::JointModeCommandGoal::*NOMODE*)
        ((= const 3) 'pr_control_msgs::JointModeCommandGoal::*OTHER*)
        ((= const 4) 'pr_control_msgs::JointModeCommandGoal::*EMERGENCY_STOP*)
        ((= const 5) 'pr_control_msgs::JointModeCommandGoal::*SWITCHING*)
        ((= const 6) 'pr_control_msgs::JointModeCommandGoal::*ERROR*)
        (t nil)))

(defclass pr_control_msgs::JointModeCommandGoal
  :super ros::object
  :slots (_header _joint_names _modes ))

(defmethod pr_control_msgs::JointModeCommandGoal
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:joint_names __joint_names) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:modes __modes) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _header __header)
   (setq _joint_names __joint_names)
   (setq _modes __modes)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:joint_names
   (&optional __joint_names)
   (if __joint_names (setq _joint_names __joint_names)) _joint_names)
  (:modes
   (&optional __modes)
   (if __modes (setq _modes __modes)) _modes)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; string[] _joint_names
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _joint_names)) 4
    ;; int32[] _modes
    (* 4    (length _modes)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; string[] _joint_names
     (write-long (length _joint_names) s)
     (dolist (elem _joint_names)
       (write-long (length elem) s) (princ elem s)
       )
     ;; int32[] _modes
     (write-long (length _modes) s)
     (dotimes (i (length _modes))
       (write-long (elt _modes i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; string[] _joint_names
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _joint_names (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _joint_names i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; int32[] _modes
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _modes (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _modes i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get pr_control_msgs::JointModeCommandGoal :md5sum-) "d85807739613da1122af407e58165361")
(setf (get pr_control_msgs::JointModeCommandGoal :datatype-) "pr_control_msgs/JointModeCommandGoal")
(setf (get pr_control_msgs::JointModeCommandGoal :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
# Used in time-stamping the goal.
Header header

# Name list of the joints. You don't need to specify all joints of the
# robot. Joint names are case-sensitive.
string[] joint_names

# Mode command to the joints listed in joint_names.
# The order must be identical.
int32[] modes

int32 BEGIN          = -1
int32 POSITION       = 0
int32 VELOCITY       = 1
int32 EFFORT         = 2
int32 NOMODE         = 3
int32 OTHER          = 3
int32 EMERGENCY_STOP = 4
int32 SWITCHING      = 5
int32 ERROR          = 6

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :pr_control_msgs/JointModeCommandGoal "d85807739613da1122af407e58165361")


