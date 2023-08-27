#ifndef PR_TSR_BLOCK_BIN_HPP
#define PR_TSR_BLOCK_BIN_HPP

#include <Eigen/Core>
#include <aikido/constraint/dart/TSR.hpp>
#include <dart/math/math.hpp>

namespace pr_tsr {

/// This creates a TSR that allows you to sample poses on the tray.
/// The samples from this TSR should be used to find points for
/// object placement. They are directly on the tray, and thus not
/// suitable as an end-effector pose. Grasp specific calculations are
/// necessary to find a suitable end-effector pose.
///
/// @param robot The robot performing the grasp
/// @param tray The tray to sample poses on
/// @param manip The manipulator to perform the grasp, if None
///        the active manipulator on the robot is used
/// @param padding The amount of space around the edge to exclude
///        from sampling. If using this to place an object, this would
///        be the maximum radius of the object
/// @param handle_padding If true add extra padding along the edges
///        of the tray that have the handles to prevent choosing a pose
///        too near the handle of the tray
inline aikido::constraint::dart::TSR getDefaultBlockBinTSR()
{
  using Eigen::Isometry3d;
  aikido::constraint::dart::TSR tsr;

  // Transform w.r.t root
  tsr.mT0_w = Eigen::Isometry3d::Identity();

  // Transform between end effector and w
  Isometry3d Tw_e = tsr.mT0_w;
  double vertical_offset = 0.17;
  Tw_e.translation() = Eigen::Vector3d{0, 0, vertical_offset};
  tsr.mTw_e = Tw_e;

  // Bw
  Eigen::MatrixXd Bw = Eigen::Matrix<double, 6, 2>::Zero();
  double padding = 0.04;
  double xdim = std::max(0.085 - padding, 0.0);
  double ydim = std::max(0.135 - padding, 0.0);
  // move along x, y directions to get any point on tray
  Bw(0, 0) = -xdim;
  Bw(0, 1) = xdim;
  Bw(1, 0) = -ydim;
  Bw(1, 1) = ydim;
  Bw(2, 0) = -0.02;
  Bw(2, 1) = 0.04; // vertical movement
  // allow any rotation around z - which is the axis normal to the tray top
  Bw(5, 0) = -M_PI;
  Bw(5, 1) = M_PI;
  tsr.mBw = Bw;

  return tsr;
}
} // namespace pr_tsr
#endif // PR_TSR_BLOCK_BIN_HPP