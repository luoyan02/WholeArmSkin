;; Auto-generated. Do not edit!


(when (boundp 'wholearm_skin_ros::TaxelData)
  (if (not (find-package "WHOLEARM_SKIN_ROS"))
    (make-package "WHOLEARM_SKIN_ROS"))
  (shadow 'TaxelData (find-package "WHOLEARM_SKIN_ROS")))
(unless (find-package "WHOLEARM_SKIN_ROS::TAXELDATA")
  (make-package "WHOLEARM_SKIN_ROS::TAXELDATA"))

(in-package "ROS")
;;//! \htmlinclude TaxelData.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass wholearm_skin_ros::TaxelData
  :super ros::object
  :slots (_cdc _header ))

(defmethod wholearm_skin_ros::TaxelData
  (:init
   (&key
    ((:cdc __cdc) (make-array 0 :initial-element 0 :element-type :integer))
    ((:header __header) (instance std_msgs::Header :init))
    )
   (send-super :init)
   (setq _cdc __cdc)
   (setq _header __header)
   self)
  (:cdc
   (&optional __cdc)
   (if __cdc (setq _cdc __cdc)) _cdc)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:serialization-length
   ()
   (+
    ;; uint16[] _cdc
    (* 2    (length _cdc)) 4
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint16[] _cdc
     (write-long (length _cdc) s)
     (dotimes (i (length _cdc))
       (write-word (elt _cdc i) s)
       )
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint16[] _cdc
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _cdc (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _cdc i) (sys::peek buf ptr- :short)) (incf ptr- 2)
     ))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;;
   self)
  )

(setf (get wholearm_skin_ros::TaxelData :md5sum-) "95e464596080dceb6079e99ff13a7f95")
(setf (get wholearm_skin_ros::TaxelData :datatype-) "wholearm_skin_ros/TaxelData")
(setf (get wholearm_skin_ros::TaxelData :definition-)
      "uint16[] cdc
Header header

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



(provide :wholearm_skin_ros/TaxelData "95e464596080dceb6079e99ff13a7f95")


