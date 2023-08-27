; Auto-generated. Do not edit!


(cl:in-package pr_control_msgs-msg)


;//! \htmlinclude JointGroupCommandResult.msg.html

(cl:defclass <JointGroupCommandResult> (roslisp-msg-protocol:ros-message)
  ((error_code
    :reader error_code
    :initarg :error_code
    :type cl:integer
    :initform 0)
   (error_string
    :reader error_string
    :initarg :error_string
    :type cl:string
    :initform ""))
)

(cl:defclass JointGroupCommandResult (<JointGroupCommandResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <JointGroupCommandResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'JointGroupCommandResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name pr_control_msgs-msg:<JointGroupCommandResult> is deprecated: use pr_control_msgs-msg:JointGroupCommandResult instead.")))

(cl:ensure-generic-function 'error_code-val :lambda-list '(m))
(cl:defmethod error_code-val ((m <JointGroupCommandResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pr_control_msgs-msg:error_code-val is deprecated.  Use pr_control_msgs-msg:error_code instead.")
  (error_code m))

(cl:ensure-generic-function 'error_string-val :lambda-list '(m))
(cl:defmethod error_string-val ((m <JointGroupCommandResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader pr_control_msgs-msg:error_string-val is deprecated.  Use pr_control_msgs-msg:error_string instead.")
  (error_string m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<JointGroupCommandResult>)))
    "Constants for message type '<JointGroupCommandResult>"
  '((:SUCCESSFUL . 0)
    (:INVALID_GOAL . -1)
    (:INVALID_JOINTS . -2)
    (:OLD_HEADER_TIMESTAMP . -3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'JointGroupCommandResult)))
    "Constants for message type 'JointGroupCommandResult"
  '((:SUCCESSFUL . 0)
    (:INVALID_GOAL . -1)
    (:INVALID_JOINTS . -2)
    (:OLD_HEADER_TIMESTAMP . -3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <JointGroupCommandResult>) ostream)
  "Serializes a message object of type '<JointGroupCommandResult>"
  (cl:let* ((signed (cl:slot-value msg 'error_code)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'error_string))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'error_string))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <JointGroupCommandResult>) istream)
  "Deserializes a message object of type '<JointGroupCommandResult>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_code) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'error_string) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'error_string) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<JointGroupCommandResult>)))
  "Returns string type for a message object of type '<JointGroupCommandResult>"
  "pr_control_msgs/JointGroupCommandResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'JointGroupCommandResult)))
  "Returns string type for a message object of type 'JointGroupCommandResult"
  "pr_control_msgs/JointGroupCommandResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<JointGroupCommandResult>)))
  "Returns md5sum for a message object of type '<JointGroupCommandResult>"
  "163c90cc66958823fc0b619077c84273")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'JointGroupCommandResult)))
  "Returns md5sum for a message object of type 'JointGroupCommandResult"
  "163c90cc66958823fc0b619077c84273")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<JointGroupCommandResult>)))
  "Returns full string definition for message of type '<JointGroupCommandResult>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%int32 error_code~%int32 SUCCESSFUL = 0~%int32 INVALID_GOAL = -1~%int32 INVALID_JOINTS = -2~%int32 OLD_HEADER_TIMESTAMP = -3~%~%# Human readable description of the error code. Contains complementary~%# information that is especially useful when execution fails, for instance:~%# - INVALID_GOAL: The reason for the invalid goal (e.g., the requested~%#   command violates the controller limits).~%# - INVALID_JOINTS: The mismatch between the expected controller joints~%#   and those provided in the goal.~%string error_string~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'JointGroupCommandResult)))
  "Returns full string definition for message of type 'JointGroupCommandResult"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%int32 error_code~%int32 SUCCESSFUL = 0~%int32 INVALID_GOAL = -1~%int32 INVALID_JOINTS = -2~%int32 OLD_HEADER_TIMESTAMP = -3~%~%# Human readable description of the error code. Contains complementary~%# information that is especially useful when execution fails, for instance:~%# - INVALID_GOAL: The reason for the invalid goal (e.g., the requested~%#   command violates the controller limits).~%# - INVALID_JOINTS: The mismatch between the expected controller joints~%#   and those provided in the goal.~%string error_string~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <JointGroupCommandResult>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'error_string))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <JointGroupCommandResult>))
  "Converts a ROS message object to a list"
  (cl:list 'JointGroupCommandResult
    (cl:cons ':error_code (error_code msg))
    (cl:cons ':error_string (error_string msg))
))
