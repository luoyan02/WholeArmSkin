#ifndef PR_TSR_TABLE_HPP
#define PR_TSR_TABLE_HPP

#include <Eigen/Core>
#include <aikido/constraint/dart/TSR.hpp>
#include <dart/math/math.hpp>

namespace pr_tsr {

/// This creates a TSR that allows you to sample poses on the table.
/// The sampled poses will have z-axis point up, normal to the table top.
/// The xy-plane of the sampled of the sample poses will be parallel to the
/// table surface.
///
/// The samples from this TSR should be used to find points for object
/// placement. They are directly on the table, and thus not suitable as an
/// end-effector pose. Grasp specific calculations are necessary to find a
/// suitable end-effector pose.
inline aikido::constraint::dart::TSR getDefaultTableTSR()
{
  using Eigen::Isometry3d;
  aikido::constraint::dart::TSR tsr;

  // Transform w.r.t root
  tsr.mT0_w = Eigen::Isometry3d::Identity();

  // Transform between end effector and w
  Isometry3d Tw_e = tsr.mT0_w;
  Tw_e.translation() = Eigen::Vector3d{0, 0, 0.75};
  // The frame is set on the table such that the y-axis is normal to the table
  // surface
  Eigen::Matrix3d rot;
  // clang-format off
  rot << 1, 0, 0,
         0, 1, 0,
         0, 0, 1;
  // clang-format on
  Tw_e.linear() = rot;
  tsr.mTw_e = Tw_e;

  // Bw
  Eigen::MatrixXd Bw = Eigen::Matrix<double, 6, 2>::Zero();
  double padding = 0.0;
  // move along x and z directios to get any point on table
  Bw(0, 0) = -0.93 + padding;
  Bw(0, 1) = 0.93 - padding;
  Bw(1, 0) = -0.38 + padding;
  Bw(1, 1) = 0.38 - padding;
  // allow any rotation around y - which is the axis normal to the table top
  Bw(5, 0) = -M_PI;
  Bw(5, 1) = M_PI;
  tsr.mBw = Bw;

  return tsr;
}
} // namespace pr_tsr
#endif // PR_TSR_TABLE_HPP
