# Autonomous Robotic Vehicle using SLAM

An autonomous robotic vehicle built with ROS2 that uses **Simultaneous Localization and Mapping (SLAM)** for real-time navigation and obstacle avoidance. The robot autonomously maps unknown environments, localizes itself within those maps, and navigates to goal positions.

## Features

- Real-time 2D SLAM using LiDAR sensor data
- Autonomous navigation with dynamic obstacle avoidance
- Custom ROS2 launch files for simulation and hardware deployment
- Configurable navigation parameters for different environments
- Gazebo simulation world for testing and development

## Architecture

```
Sensor Input (LiDAR/Camera)
        |
        v
+--------------------+
|  SLAM Algorithm    | -- Map Generation
|  (Cartographer)    |
+--------------------+
        |
        v
+--------------------+
|  Localization      | -- Pose Estimation
|  (AMCL)           |
+--------------------+
        |
        v
+--------------------+
|  Path Planning     | -- Nav2 Stack
|  (DWB Planner)    |
+--------------------+
        |
        v
    Motor Control
```

## Project Structure

```
├── CMakeLists.txt          # Build configuration
├── package.xml             # ROS2 package manifest
├── config/                 # Navigation and SLAM parameters
├── description/            # Robot URDF/Xacro model
├── launch/                 # ROS2 launch files
└── worlds/                 # Gazebo simulation environments
```

## Prerequisites

- Ubuntu 22.04
- ROS2 Humble
- Gazebo (Classic or Ignition)
- Nav2 Navigation Stack
- SLAM Toolbox / Cartographer

## Installation

```bash
# Clone into your ROS2 workspace
cd ~/ros2_ws/src
git clone https://github.com/SkullsEye/Autonomous-Robotic-Vechile.git

# Install dependencies
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y

# Build
colcon build --packages-select runs
source install/setup.bash
```

## Usage

```bash
# Launch simulation
ros2 launch runs simulation_launch.py

# Start SLAM mapping
ros2 launch runs slam_launch.py

# Run autonomous navigation
ros2 launch runs navigation_launch.py
```

## Tech Stack

- **ROS2 Humble** -- Middleware framework
- **Nav2** -- Autonomous navigation stack
- **SLAM Toolbox** -- Real-time SLAM
- **Gazebo** -- Physics simulation
- **Python 3 / C++** -- Node implementation

## Author

**Umar Bin Muzzafar**
B.Tech in Artificial Intelligence and Robotics, Dayananda Sagar University, Bangalore

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
