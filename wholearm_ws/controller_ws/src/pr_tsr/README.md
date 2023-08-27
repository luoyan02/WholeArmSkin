## The Personal Robotics Task Space Region (TSR) Collection [![Build Status](https://travis-ci.com/personalrobotics/pr_tsr.svg?token=1MmAniN9fkMcwpRUTdFq&branch=master)](https://travis-ci.com/personalrobotics/pr_tsr)

This header-only library contains predefined [TSRs](https://dl.acm.org/citation.cfm?id=2046797) ([alt](https://www.ri.cmu.edu/publication_view.html?pub_id=6867)) for objects that may be manipulated with the [Aikido](https://github.com/personalrobotics/aikido) library.

All TSRs are specified according to the following convention:

1. The `T0_w` frame may be specified as convenient per the geometry and base frame of the object, and is the transform from the **root** of the object (i.e. its 0th `BodyNode` if a multi-body object) to the "TSR" frame *w*.
1. The `Tw_e` frame is specified to be the exact same orientation as `T0_w`, translated to the graspable surface of the object. It is expected that any user of the TSR will have to modify `mTw_e` with a second transformation after initialization to include the actual *w* to *e* (end-effector) transformation of their particular gripper. See [libherb](https://github.com/personalrobotics/libherb) for examples. [TODO link to specific source file]
