; Auto-generated. Do not edit!


(cl:in-package yui_bathing-srv)


;//! \htmlinclude Perception-request.msg.html

(cl:defclass <Perception-request> (roslisp-msg-protocol:ros-message)
  ((segment
    :reader segment
    :initarg :segment
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Perception-request (<Perception-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Perception-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Perception-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name yui_bathing-srv:<Perception-request> is deprecated: use yui_bathing-srv:Perception-request instead.")))

(cl:ensure-generic-function 'segment-val :lambda-list '(m))
(cl:defmethod segment-val ((m <Perception-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader yui_bathing-srv:segment-val is deprecated.  Use yui_bathing-srv:segment instead.")
  (segment m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Perception-request>) ostream)
  "Serializes a message object of type '<Perception-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'segment) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Perception-request>) istream)
  "Deserializes a message object of type '<Perception-request>"
    (cl:setf (cl:slot-value msg 'segment) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Perception-request>)))
  "Returns string type for a service object of type '<Perception-request>"
  "yui_bathing/PerceptionRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Perception-request)))
  "Returns string type for a service object of type 'Perception-request"
  "yui_bathing/PerceptionRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Perception-request>)))
  "Returns md5sum for a message object of type '<Perception-request>"
  "404b3b67dc1dc68f07af2a6c2cd600c0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Perception-request)))
  "Returns md5sum for a message object of type 'Perception-request"
  "404b3b67dc1dc68f07af2a6c2cd600c0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Perception-request>)))
  "Returns full string definition for message of type '<Perception-request>"
  (cl:format cl:nil "bool segment~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Perception-request)))
  "Returns full string definition for message of type 'Perception-request"
  (cl:format cl:nil "bool segment~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Perception-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Perception-request>))
  "Converts a ROS message object to a list"
  (cl:list 'Perception-request
    (cl:cons ':segment (segment msg))
))
;//! \htmlinclude Perception-response.msg.html

(cl:defclass <Perception-response> (roslisp-msg-protocol:ros-message)
  ((mask
    :reader mask
    :initarg :mask
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass Perception-response (<Perception-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Perception-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Perception-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name yui_bathing-srv:<Perception-response> is deprecated: use yui_bathing-srv:Perception-response instead.")))

(cl:ensure-generic-function 'mask-val :lambda-list '(m))
(cl:defmethod mask-val ((m <Perception-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader yui_bathing-srv:mask-val is deprecated.  Use yui_bathing-srv:mask instead.")
  (mask m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Perception-response>) ostream)
  "Serializes a message object of type '<Perception-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mask) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Perception-response>) istream)
  "Deserializes a message object of type '<Perception-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mask) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Perception-response>)))
  "Returns string type for a service object of type '<Perception-response>"
  "yui_bathing/PerceptionResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Perception-response)))
  "Returns string type for a service object of type 'Perception-response"
  "yui_bathing/PerceptionResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Perception-response>)))
  "Returns md5sum for a message object of type '<Perception-response>"
  "404b3b67dc1dc68f07af2a6c2cd600c0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Perception-response)))
  "Returns md5sum for a message object of type 'Perception-response"
  "404b3b67dc1dc68f07af2a6c2cd600c0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Perception-response>)))
  "Returns full string definition for message of type '<Perception-response>"
  (cl:format cl:nil "sensor_msgs/Image mask~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Perception-response)))
  "Returns full string definition for message of type 'Perception-response"
  (cl:format cl:nil "sensor_msgs/Image mask~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Perception-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mask))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Perception-response>))
  "Converts a ROS message object to a list"
  (cl:list 'Perception-response
    (cl:cons ':mask (mask msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'Perception)))
  'Perception-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'Perception)))
  'Perception-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Perception)))
  "Returns string type for a service object of type '<Perception>"
  "yui_bathing/Perception")