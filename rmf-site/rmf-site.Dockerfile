ARG BUILDER_NS="open-rmf/rmf_deployment_template"

FROM $BUILDER_NS/rmf

COPY mysite_maps /opt/rmf/src/mysite_maps

SHELL ["bash", "-c"]

WORKDIR /opt/rmf

RUN pip3 install nudged
RUN . /opt/ros/$ROS_DISTRO/setup.sh \
  && /ros_entrypoint.sh \
  && colcon build --cmake-args -DCMAKE_BUILD_TYPE=Release \
  --packages-select mysite_maps

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
