# Bed Bathing Planning Module

This is the planning module for the bed bathing activity.

The sequence of actions is as follows:
 - Go to home position (planToConfiguration)
 - Localize elbow joint and go to an offset position above the elbow joint for the right limb of the person (planToTSR)
 - Read RGBDT sensor data. Make a service request to the segmentation module and obtain the mask (segmentArm)
 - Use the mask to generate a wiping primitive object (generatePrimitive) (interace with python primitives using requests)
 - Follow the primitive using a compliant controller (followPrimitive) (interace with python primitives using requests)
 - Return to offset position above elbow joint (planToTSR)
 - Check for completion by querying the segmentation model again (checkCompletion)
 - Repeat if mask is not empty (contains wet or soap)
 - Go to home position (planToConfiguration) otherwise

## TODOs

- [ ] Setup behavior tree for bed bathing similar to ada_feeding

