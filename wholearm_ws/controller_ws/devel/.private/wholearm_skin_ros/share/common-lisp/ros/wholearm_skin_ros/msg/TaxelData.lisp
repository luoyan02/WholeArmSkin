; Auto-generated. Do not edit!


(cl:in-package wholearm_skin_ros-msg)


;//! \htmlinclude TaxelData.msg.html

(cl:defclass <TaxelData> (roslisp-msg-protocol:ros-message)
  ((cdc
    :reader cdc
    :initarg :cdc
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header)))
)

(cl:defclass TaxelData (<TaxelData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TaxelData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TaxelData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name wholearm_skin_ros-msg:<TaxelData> is deprecated: use wholearm_skin_ros-msg:TaxelData instead.")))

(cl:ensure-generic-function 'cdc-val :lambda-list '(m))
(cl:defmethod cdc-val ((m <TaxelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader wholearm_skin_ros-msg:cdc-val is deprecated.  Use wholearm_skin_ros-msg:cdc instead.")
  (cdc m))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TaxelData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader wholearm_skin_ros-msg:header-val is deprecated.  Use wholearm_skin_ros-msg:header instead.")
  (header m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TaxelData>) ostream)
  "Serializes a message object of type '<TaxelData>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'cdc))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream))
   (cl:slot-value msg 'cdc))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TaxelData>) istream)
  "Deserializes a message object of type '<TaxelData>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'cdc) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'cdc)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TaxelData>)))
  "Returns string type for a message object of type '<TaxelData>"
  "wholearm_skin_ros/TaxelData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TaxelData)))
  "Returns string type for a message object of type 'TaxelData"
  "wholearm_skin_ros/TaxelData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TaxelData>)))
  "Returns md5sum for a message object of type '<TaxelData>"
  "95e464596080dceb6079e99ff13a7f95")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TaxelData)))
  "Returns md5sum for a message object of type 'TaxelData"
  "95e464596080dceb6079e99ff13a7f95")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TaxelData>)))
  "Returns full string definition for message of type '<TaxelData>"
  (cl:format cl:nil "uint16[] cdc~%Header header~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TaxelData)))
  "Returns full string definition for message of type 'TaxelData"
  (cl:format cl:nil "uint16[] cdc~%Header header~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TaxelData>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'cdc) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 2)))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TaxelData>))
  "Converts a ROS message object to a list"
  (cl:list 'TaxelData
    (cl:cons ':cdc (cdc msg))
    (cl:cons ':header (header msg))
))
