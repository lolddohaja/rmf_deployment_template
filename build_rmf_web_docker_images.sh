#!/bin/bash
# Download https://github.com/open-rmf/rmf_deployment_template if needed folders does not exists?
ROS_DISTRO="${ROS_DISTRO:-humble}"
docker build -f rmf/builder-rosdep.Dockerfile -t open-rmf/rmf_deployment_template/builder-rosdep .
docker build -f rmf/rmf.Dockerfile -t open-rmf/rmf_deployment_template/rmf:latest .

# Check if folder for rmf_web_src exists 
mkdir rmf-web-src
git clone https://github.com/open-rmf/rmf-web rmf-web-src

docker build -f rmf-web/builder-rmf-web.Dockerfile -t open-rmf/rmf_deployment_template/rmf_web_builder .
