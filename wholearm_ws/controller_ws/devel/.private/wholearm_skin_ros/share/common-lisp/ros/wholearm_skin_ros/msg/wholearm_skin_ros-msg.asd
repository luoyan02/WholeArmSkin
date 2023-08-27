
(cl:in-package :asdf)

(defsystem "wholearm_skin_ros-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :std_msgs-msg
)
  :components ((:file "_package")
    (:file "CalibratedDataArray" :depends-on ("_package_CalibratedDataArray"))
    (:file "_package_CalibratedDataArray" :depends-on ("_package"))
    (:file "Piezo" :depends-on ("_package_Piezo"))
    (:file "_package_Piezo" :depends-on ("_package"))
    (:file "TaxelData" :depends-on ("_package_TaxelData"))
    (:file "_package_TaxelData" :depends-on ("_package"))
  ))