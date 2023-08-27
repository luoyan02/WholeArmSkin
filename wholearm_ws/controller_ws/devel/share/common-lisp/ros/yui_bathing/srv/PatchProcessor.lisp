; Auto-generated. Do not edit!


(cl:in-package yui_bathing-srv)


;//! \htmlinclude PatchProcessor-request.msg.html

(cl:defclass <PatchProcessor-request> (roslisp-msg-protocol:ros-message)
  ((mask
    :reader mask
    :initarg :mask
    :type sensor_msgs-msg:Image
    :initform (cl:make-instance 'sensor_msgs-msg:Image)))
)

(cl:defclass PatchProcessor-request (<PatchProcessor-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PatchProcessor-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PatchProcessor-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name yui_bathing-srv:<PatchProcessor-request> is deprecated: use yui_bathing-srv:PatchProcessor-request instead.")))

(cl:ensure-generic-function 'mask-val :lambda-list '(m))
(cl:defmethod mask-val ((m <PatchProcessor-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader yui_bathing-srv:mask-val is deprecated.  Use yui_bathing-srv:mask instead.")
  (mask m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PatchProcessor-request>) ostream)
  "Serializes a message object of type '<PatchProcessor-request>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'mask) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PatchProcessor-request>) istream)
  "Deserializes a message object of type '<PatchProcessor-request>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'mask) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PatchProcessor-request>)))
  "Returns string type for a service object of type '<PatchProcessor-request>"
  "yui_bathing/PatchProcessorRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PatchProcessor-request)))
  "Returns string type for a service object of type 'PatchProcessor-request"
  "yui_bathing/PatchProcessorRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PatchProcessor-request>)))
  "Returns md5sum for a message object of type '<PatchProcessor-request>"
  "925376cec6effbc61eea0d6363975189")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PatchProcessor-request)))
  "Returns md5sum for a message object of type 'PatchProcessor-request"
  "925376cec6effbc61eea0d6363975189")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PatchProcessor-request>)))
  "Returns full string definition for message of type '<PatchProcessor-request>"
  (cl:format cl:nil "sensor_msgs/Image mask~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PatchProcessor-request)))
  "Returns full string definition for message of type 'PatchProcessor-request"
  (cl:format cl:nil "sensor_msgs/Image mask~%~%================================================================================~%MSG: sensor_msgs/Image~%# This message contains an uncompressed image~%# (0, 0) is at top-left corner of image~%#~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%                     # If the frame_id here and the frame_id of the CameraInfo~%                     # message associated with the image conflict~%                     # the behavior is undefined~%~%uint32 height         # image height, that is, number of rows~%uint32 width          # image width, that is, number of columns~%~%# The legal values for encoding are in file src/image_encodings.cpp~%# If you want to standardize a new string format, join~%# ros-users@lists.sourceforge.net and send an email proposing a new encoding.~%~%string encoding       # Encoding of pixels -- channel meaning, ordering, size~%                      # taken from the list of strings in include/sensor_msgs/image_encodings.h~%~%uint8 is_bigendian    # is this data bigendian?~%uint32 step           # Full row length in bytes~%uint8[] data          # actual matrix data, size is (step * rows)~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PatchProcessor-request>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'mask))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PatchProcessor-request>))
  "Converts a ROS message object to a list"
  (cl:list 'PatchProcessor-request
    (cl:cons ':mask (mask msg))
))
;//! \htmlinclude PatchProcessor-response.msg.html

(cl:defclass <PatchProcessor-response> (roslisp-msg-protocol:ros-message)
  ((trajectory
    :reader trajectory
    :initarg :trajectory
    :type std_msgs-msg:Float32MultiArray
    :initform (cl:make-instance 'std_msgs-msg:Float32MultiArray)))
)

(cl:defclass PatchProcessor-response (<PatchProcessor-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PatchProcessor-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PatchProcessor-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name yui_bathing-srv:<PatchProcessor-response> is deprecated: use yui_bathing-srv:PatchProcessor-response instead.")))

(cl:ensure-generic-function 'trajectory-val :lambda-list '(m))
(cl:defmethod trajectory-val ((m <PatchProcessor-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader yui_bathing-srv:trajectory-val is deprecated.  Use yui_bathing-srv:trajectory instead.")
  (trajectory m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PatchProcessor-response>) ostream)
  "Serializes a message object of type '<PatchProcessor-response>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'trajectory) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PatchProcessor-response>) istream)
  "Deserializes a message object of type '<PatchProcessor-response>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'trajectory) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PatchProcessor-response>)))
  "Returns string type for a service object of type '<PatchProcessor-response>"
  "yui_bathing/PatchProcessorResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PatchProcessor-response)))
  "Returns string type for a service object of type 'PatchProcessor-response"
  "yui_bathing/PatchProcessorResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PatchProcessor-response>)))
  "Returns md5sum for a message object of type '<PatchProcessor-response>"
  "925376cec6effbc61eea0d6363975189")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PatchProcessor-response)))
  "Returns md5sum for a message object of type 'PatchProcessor-response"
  "925376cec6effbc61eea0d6363975189")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PatchProcessor-response>)))
  "Returns full string definition for message of type '<PatchProcessor-response>"
  (cl:format cl:nil "std_msgs/Float32MultiArray trajectory~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PatchProcessor-response)))
  "Returns full string definition for message of type 'PatchProcessor-response"
  (cl:format cl:nil "std_msgs/Float32MultiArray trajectory~%~%================================================================================~%MSG: std_msgs/Float32MultiArray~%# Please look at the MultiArrayLayout message definition for~%# documentation on all multiarrays.~%~%MultiArrayLayout  layout        # specification of data layout~%float32[]         data          # array of data~%~%~%================================================================================~%MSG: std_msgs/MultiArrayLayout~%# The multiarray declares a generic multi-dimensional array of a~%# particular data type.  Dimensions are ordered from outer most~%# to inner most.~%~%MultiArrayDimension[] dim # Array of dimension properties~%uint32 data_offset        # padding elements at front of data~%~%# Accessors should ALWAYS be written in terms of dimension stride~%# and specified outer-most dimension first.~%# ~%# multiarray(i,j,k) = data[data_offset + dim_stride[1]*i + dim_stride[2]*j + k]~%#~%# A standard, 3-channel 640x480 image with interleaved color channels~%# would be specified as:~%#~%# dim[0].label  = \"height\"~%# dim[0].size   = 480~%# dim[0].stride = 3*640*480 = 921600  (note dim[0] stride is just size of image)~%# dim[1].label  = \"width\"~%# dim[1].size   = 640~%# dim[1].stride = 3*640 = 1920~%# dim[2].label  = \"channel\"~%# dim[2].size   = 3~%# dim[2].stride = 3~%#~%# multiarray(i,j,k) refers to the ith row, jth column, and kth channel.~%~%================================================================================~%MSG: std_msgs/MultiArrayDimension~%string label   # label of given dimension~%uint32 size    # size of given dimension (in type units)~%uint32 stride  # stride of given dimension~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PatchProcessor-response>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'trajectory))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PatchProcessor-response>))
  "Converts a ROS message object to a list"
  (cl:list 'PatchProcessor-response
    (cl:cons ':trajectory (trajectory msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'PatchProcessor)))
  'PatchProcessor-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'PatchProcessor)))
  'PatchProcessor-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PatchProcessor)))
  "Returns string type for a service object of type '<PatchProcessor>"
  "yui_bathing/PatchProcessor")