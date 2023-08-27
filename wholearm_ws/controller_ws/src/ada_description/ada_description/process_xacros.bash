#!/bin/bash


xacro -o robots_urdf/ada.urdf robots/j2n6s200_standalone.xacro
xacro -o robots_urdf/ada_with_camera.urdf robots/j2n6s200_standalone.xacro with_camera:=true
xacro -o robots_urdf/ada_with_forque.urdf robots/j2n6s200_standalone.xacro with_forque:=true
xacro -o robots_urdf/ada_with_camera_forque.urdf robots/j2n6s200_standalone.xacro with_camera:=true with_forque:=true
