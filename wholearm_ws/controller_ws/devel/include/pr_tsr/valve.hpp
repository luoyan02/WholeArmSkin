#ifndef PR_TSR_VALVE_HPP
#define PR_TSR_VALVE_HPP

#include <Eigen/Core>
#include <aikido/constraint/dart/TSR.hpp>
#include <dart/math/math.hpp>

namespace pr_tsr {
inline aikido::constraint::dart::TSR getDefaultValveTSR()
{
  using Eigen::Isometry3d;
  aikido::constraint::dart::TSR tsr;

  // transform of the wheel joint from the valve root body
  // copied out of valve_turning/valve.hpp
  Eigen::Isometry3d wheel_jnt_tf{Eigen::Isometry3d::Identity()};
  wheel_jnt_tf.linear()
      = dart::math::eulerXYZToMatrix(Eigen::Vector3d(M_PI / 2, 0, 0));
  wheel_jnt_tf.translation() = Eigen::Vector3d{.095, 0, .1};

  // transform to a more useful w frame
  Isometry3d T0_w = wheel_jnt_tf;
  T0_w.translation() += Eigen::Vector3d{0, -.038, 0};
  tsr.mT0_w = T0_w;

  // "surface identity" e frame as described in README.md
  Isometry3d Tw_e = Isometry3d::Identity();
  Tw_e.translation() = Eigen::Vector3d{-.085, 0, 0};
  tsr.mTw_e = Tw_e;

  // rotation around the center access, since it's a wheel
  Eigen::MatrixXd Bw = Eigen::Matrix<double, 6, 2>::Zero();
  Bw(5, 1) = 2 * M_PI;
  tsr.mBw = Bw;

  return tsr;
};
} // namespace pr_tsr
#endif // PR_TSR_VALVE_HPP
