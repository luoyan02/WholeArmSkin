;; Auto-generated. Do not edit!


(when (boundp 'yui_bathing::Perception)
  (if (not (find-package "YUI_BATHING"))
    (make-package "YUI_BATHING"))
  (shadow 'Perception (find-package "YUI_BATHING")))
(unless (find-package "YUI_BATHING::PERCEPTION")
  (make-package "YUI_BATHING::PERCEPTION"))
(unless (find-package "YUI_BATHING::PERCEPTIONREQUEST")
  (make-package "YUI_BATHING::PERCEPTIONREQUEST"))
(unless (find-package "YUI_BATHING::PERCEPTIONRESPONSE")
  (make-package "YUI_BATHING::PERCEPTIONRESPONSE"))

(in-package "ROS")



(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass yui_bathing::PerceptionRequest
  :super ros::object
  :slots (_segment ))

(defmethod yui_bathing::PerceptionRequest
  (:init
   (&key
    ((:segment __segment) nil)
    )
   (send-super :init)
   (setq _segment __segment)
   self)
  (:segment
   (&optional (__segment :null))
   (if (not (eq __segment :null)) (setq _segment __segment)) _segment)
  (:serialization-length
   ()
   (+
    ;; bool _segment
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _segment
       (if _segment (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _segment
     (setq _segment (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass yui_bathing::PerceptionResponse
  :super ros::object
  :slots (_mask ))

(defmethod yui_bathing::PerceptionResponse
  (:init
   (&key
    ((:mask __mask) (instance sensor_msgs::Image :init))
    )
   (send-super :init)
   (setq _mask __mask)
   self)
  (:mask
   (&rest __mask)
   (if (keywordp (car __mask))
       (send* _mask __mask)
     (progn
       (if __mask (setq _mask (car __mask)))
       _mask)))
  (:serialization-length
   ()
   (+
    ;; sensor_msgs/Image _mask
    (send _mask :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; sensor_msgs/Image _mask
       (send _mask :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; sensor_msgs/Image _mask
     (send _mask :deserialize buf ptr-) (incf ptr- (send _mask :serialization-length))
   ;;
   self)
  )

(defclass yui_bathing::Perception
  :super ros::object
  :slots ())

(setf (get yui_bathing::Perception :md5sum-) "404b3b67dc1dc68f07af2a6c2cd600c0")
(setf (get yui_bathing::Perception :datatype-) "yui_bathing/Perception")
(setf (get yui_bathing::Perception :request) yui_bathing::PerceptionRequest)
(setf (get yui_bathing::Perception :response) yui_bathing::PerceptionResponse)

(defmethod yui_bathing::PerceptionRequest
  (:response () (instance yui_bathing::PerceptionResponse :init)))

(setf (get yui_bathing::PerceptionRequest :md5sum-) "404b3b67dc1dc68f07af2a6c2cd600c0")
(setf (get yui_bathing::PerceptionRequest :datatype-) "yui_bathing/PerceptionRequest")
(setf (get yui_bathing::PerceptionRequest :definition-)
      "bool segment
---
sensor_msgs/Image mask

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

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

(setf (get yui_bathing::PerceptionResponse :md5sum-) "404b3b67dc1dc68f07af2a6c2cd600c0")
(setf (get yui_bathing::PerceptionResponse :datatype-) "yui_bathing/PerceptionResponse")
(setf (get yui_bathing::PerceptionResponse :definition-)
      "bool segment
---
sensor_msgs/Image mask

================================================================================
MSG: sensor_msgs/Image
# This message contains an uncompressed image
# (0, 0) is at top-left corner of image
#

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image
                     # If the frame_id here and the frame_id of the CameraInfo
                     # message associated with the image conflict
                     # the behavior is undefined

uint32 height         # image height, that is, number of rows
uint32 width          # image width, that is, number of columns

# The legal values for encoding are in file src/image_encodings.cpp
# If you want to standardize a new string format, join
# ros-users@lists.sourceforge.net and send an email proposing a new encoding.

string encoding       # Encoding of pixels -- channel meaning, ordering, size
                      # taken from the list of strings in include/sensor_msgs/image_encodings.h

uint8 is_bigendian    # is this data bigendian?
uint32 step           # Full row length in bytes
uint8[] data          # actual matrix data, size is (step * rows)

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



(provide :yui_bathing/Perception "404b3b67dc1dc68f07af2a6c2cd600c0")


