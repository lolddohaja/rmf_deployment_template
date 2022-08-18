# check command vcs exists
if ! command -v vcs >/dev/null 2>&1; then
    echo "vcs not found"
    echo "installing"
    sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
    sudo apt update
    sudo apt install python3-vcstool -y
else
    echo "vcs found"
fi

# check rmf-src folder exists
if [ ! -d "rmf-src" ]; then
  echo "rmf folder with needed .Dockerfiles not found"
  echo "Importing repos"
  mkdir rmf-src
  vcs import rmf-src < rmf/rmf.repos
else
    echo "rmf-src folder found"
fi
ROS_DISTRO="${ROS_DISTRO:-humble}"
docker build -f rmf/builder-rosdep.Dockerfile -t open-rmf/rmf_deployment_template/builder-rosdep .
docker build -f rmf/rmf.Dockerfile -t open-rmf/rmf_deployment_template/rmf .
docker tag open-rmf/rmf_deployment_template/rmf rmf
