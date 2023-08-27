; Auto-generated. Do not edit!


(cl:in-package pr_control_msgs-msg)


;//! \htmlinclude SetForceTorqueThresholdGoal.msg.html

(cl:defclass <SetForceTorqueThresholdGoal> (roslisp-msg-protocol:ros-message)
  ((force_threshold
    :reader force_threshold
    :initarg :force_threshold
    :type cl:float
    :initform 0.0)
   (torque_threshold
    :reader torque_threshold
    :initarg :torque_threshold
    :type cl:float
    :initform 0.0)
   (retare
    :reader retare
    :initarg :retare
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SetForceTorqueThresholdGoal (<SetForceTorqueThresholdGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SetForceTorqueThresholdGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SetForceTorqueThresholdGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pr_control_msgs-msg:<SetForceTorqueThresholdGoal> is deprecated: use pr_control_msgs-msg:SetForceTorqueThresholdGoal instead.")))

(cl:ensure-generic-function 'force_threshold-val :lambda-list '(m))
(cl:defmethod force_threshold-val ((m <SetForceTorqueThresholdGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pr_control_msgs-msg:force_threshold-val is deprecated.  Use pr_control_msgs-msg:force_threshold instead.")
  (force_threshold m))

(cl:ensure-generic-function 'torque_threshold-val :lambda-list '(m))
(cl:defmethod torque_threshold-val ((m <SetForceTorqueThresholdGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pr_control_msgs-msg:torque_threshold-val is deprecated.  Use pr_control_msgs-msg:torque_threshold instead.")
  (torque_threshold m))

(cl:ensure-generic-function 'retare-val :lambda-list '(m))
(cl:defmethod retare-val ((m <SetForceTorqueThresholdGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pr_control_msgs-msg:retare-val is deprecated.  Use pr_control_msgs-msg:retare instead.")
  (retare m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SetForceTorqueThresholdGoal>) ostream)
  "Serializes a message object of type '<SetForceTorqueThresholdGoal>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'force_threshold))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'torque_threshold))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'retare) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SetForceTorqueThresholdGoal>) istream)
  "Deserializes a message object of type '<SetForceTorqueThresholdGoal>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'force_threshold) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'torque_threshold) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:slot-value msg 'retare) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SetForceTorqueThresholdGoal>)))
  "Returns string type for a message object of type '<SetForceTorqueThresholdGoal>"
  "pr_control_msgs/SetForceTorqueThresholdGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SetForceTorqueThresholdGoal)))
  "Returns string type for a message object of type 'SetForceTorqueThresholdGoal"
  "pr_control_msgs/SetForceTorqueThresholdGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SetForceTorqueThresholdGoal>)))
  "Returns md5sum for a message object of type '<SetForceTorqueThresholdGoal>"
  "e5d09cefad81aea029dbb143ca87e1e5")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SetForceTorqueThresholdGoal)))
  "Returns md5sum for a message object of type 'SetForceTorqueThresholdGoal"
  "e5d09cefad81aea029dbb143ca87e1e5")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SetForceTorqueThresholdGoal>)))
  "Returns full string definition for message of type '<SetForceTorqueThresholdGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%float64 force_threshold~%float64 torque_threshold~%bool retare~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SetForceTorqueThresholdGoal)))
  "Returns full string definition for message of type 'SetForceTorqueThresholdGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%float64 force_threshold~%float64 torque_threshold~%bool retare~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SetForceTorqueThresholdGoal>))
  (cl:+ 0
     8
     8
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SetForceTorqueThresholdGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'SetForceTorqueThresholdGoal
    (cl:cons ':force_threshold (force_threshold msg))
    (cl:cons ':torque_threshold (torque_threshold msg))
    (cl:cons ':retare (retare msg))
))
