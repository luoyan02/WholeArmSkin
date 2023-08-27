#ifndef PR_TSR_CAN_HPP
#define PR_TSR_CAN_HPP

#include <Eigen/Core>
#include <aikido/constraint/dart/TSR.hpp>
#include <dart/math/math.hpp>

namespace pr_tsr {
inline aikido::constraint::dart::TSR getDefaultCanTSR()
{
  using Eigen::Isometry3d;
  aikido::constraint::dart::TSR tsr;

  // Transform w.r.t root
  tsr.mT0_w = Eigen::Isometry3d::Identity();

  // Transform between end effector and w
  double can_height = 0.123;
  double can_radius = 0.033;
  double push_distance = 0.05;
  Isometry3d Tw_e = tsr.mT0_w;
  Tw_e.translation()
      = Eigen::Vector3d{can_radius + push_distance, 0, can_height / 2.0};
  Eigen::Matrix3d rot;
  // clang-format off
  rot << 0, 0, 1,
         1, 0, 0,
         0, 1, 0;
  // clang-format on
  Tw_e.linear() = rot;
  tsr.mTw_e = Tw_e;

  // Rotation around object
  Eigen::MatrixXd Bw = Eigen::Matrix<double, 6, 2>::Zero();
  double vertical_tolerance = 0.02;
  Bw(2, 0) = -vertical_tolerance;
  Bw(2, 1) = vertical_tolerance;
  Bw(5, 0) = -M_PI;
  Bw(5, 1) = M_PI;
  tsr.mBw = Bw;

  return tsr;
}
} // namespace pr_tsr
#endif // PR_TSR_CAN_HPP
