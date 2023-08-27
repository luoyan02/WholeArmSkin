#include "feeding/nodes.hpp"
/**
 * Nodes for interfacing with aikido::perception
 **/

#include <Eigen/Core>
#include <behaviortree_cpp/behavior_tree.h>
#include <functional>
#include <iostream>
#include <vector>

#include <libada/util.hpp>
// #include "std_msgs/Float32MultiArray.h"
#include <yui_bathing/PatchProcessor.h>
#include <yui_bathing/Perception.h>

using ada::util::getRosParam;

#include <yaml-cpp/exceptions.h>

namespace feeding
{
  namespace nodes
  {
    BT::NodeStatus RunSegmentationNode(BT::TreeNode &self)
    {
      auto name = self.getInput<std::string>("serviceName");
      if (!name)
        return BT::NodeStatus::FAILURE;
      std::cout << "Received service name: " << name.value() << std::endl;
      ros::NodeHandle n;
      ros::ServiceClient client = n.serviceClient<yui_bathing::Perception>(name.value());
      yui_bathing::Perception srv;
      srv.request.segment = true;
      if (client.call(srv))
      {
        ROS_INFO("Segmentation Service called");
        // log response of type sensor_msgs::Image
        sensor_msgs::Image image = srv.response.mask;
        // print image info
        std::cout << "Image height: " << image.height << std::endl;
        std::cout << "Image width: " << image.width << std::endl;
        std::cout << "Image encoding: " << image.encoding << std::endl;
        std::cout << "Image is_bigendian: " << image.is_bigendian << std::endl;
        std::cout << "Image step: " << image.step << std::endl;
        std::cout << "Image data size: " << image.data.size() << std::endl;
        self.setOutput<sensor_msgs::Image>("outputMask", image);
      }
      else
      {
        ROS_ERROR("Failed to call service for segmentation");
        return BT::NodeStatus::FAILURE;
      }
      return BT::NodeStatus::SUCCESS;
    }

    BT::NodeStatus RunPatchProcessor(BT::TreeNode &self)
    {
      auto name = self.getInput<std::string>("serviceName");
      auto mask = self.getInput<sensor_msgs::Image>("outputMask");
      if (!name)
        return BT::NodeStatus::FAILURE;
      std::cout << "Received service name: " << name.value() << std::endl;
      if (!mask)
      {
        std::cout << "No mask provided" << std::endl;
        return BT::NodeStatus::FAILURE;
      }
      ros::NodeHandle n;
      ros::ServiceClient client = n.serviceClient<yui_bathing::PatchProcessor>(name.value());
      yui_bathing::PatchProcessor srv;
      srv.request.mask = mask.value();
      if (client.call(srv))
      {
        ROS_INFO("Patch Processor Service called");
        // log response of type Float32MultiArray
        std_msgs::Float32MultiArray traj = srv.response.trajectory;
        // print trajectory info
        std::cout << "Trajectory size: " << traj.data.size() << std::endl;
      }
      else
      {
        ROS_ERROR("Failed to call service for patch processor");
        return BT::NodeStatus::FAILURE;
      }

      return BT::NodeStatus::SUCCESS;
    }

    /// Node registration
    static void registerNodes(BT::BehaviorTreeFactory &factory,
                              ros::NodeHandle & /*&nh */, ada::Ada &robot)
    {
      // Segmentation Service Interface
      factory.registerSimpleAction("RunSegmentationNode", RunSegmentationNode,
                                   {BT::InputPort<std::string>("serviceName"), BT::OutputPort<sensor_msgs::Image>("outputMask")});
      // Patch Processor Service Interface
      factory.registerSimpleAction("RunPatchProcessor", RunPatchProcessor,
                                   {BT::InputPort<std::string>("serviceName"), BT::InputPort<sensor_msgs::Image>("outputMask")});
    }
    static_block { feeding::registerNodeFn(&registerNodes); }
  }
}