#ifndef PR_TSR_PLATE_HPP
#define PR_TSR_PLATE_HPP

#include <Eigen/Core>
#include <aikido/constraint/dart/TSR.hpp>
#include <dart/math/math.hpp>

namespace pr_tsr {

/// The default plate tsr allows you to view the whole
/// plate from a point above
inline aikido::constraint::dart::TSR getDefaultPlateTSR()
{
  using Eigen::Isometry3d;
  aikido::constraint::dart::TSR tsr;

  // Transform w.r.t root
  tsr.mT0_w = Eigen::Isometry3d::Identity();

  // Transform between end effector and w
  double vertical_offset = 0.15;

  Isometry3d Tw_e = tsr.mT0_w;
  Tw_e.translation() = Eigen::Vector3d{0, 0, vertical_offset};
  tsr.mTw_e = Tw_e;

  // Rotation around object
  Eigen::MatrixXd Bw = Eigen::Matrix<double, 6, 2>::Zero();
  Bw(5, 0) = -M_PI;
  Bw(5, 1) = M_PI;
  tsr.mBw = Bw;

  return tsr;
}
} // namespace pr_tsr
#endif // PR_TSR_PLATE_HPP
