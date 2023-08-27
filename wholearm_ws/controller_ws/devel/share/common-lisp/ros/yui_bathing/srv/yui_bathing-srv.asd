
(cl:in-package :asdf)

(defsystem "yui_bathing-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :sensor_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "PatchProcessor" :depends-on ("_package_PatchProcessor"))
    (:file "_package_PatchProcessor" :depends-on ("_package"))
    (:file "Perception" :depends-on ("_package_Perception"))
    (:file "_package_Perception" :depends-on ("_package"))
  ))