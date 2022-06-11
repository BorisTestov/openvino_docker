FROM ubuntu:20.04

ENV TZ=Europe/Moscow
ENV openvinoVersion=2021.4.2
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt update && \
apt install -y git libusb-1.0-0-dev && \
apt-get clean autoclean && \
apt-get autoremove --yes && \
rm -rf /var/lib/{apt,dpkg,cache,log}

RUN git clone --branch ${openvinoVersion} --single-branch https://github.com/openvinotoolkit/openvino.git /opt/intel/openvino && \
cd /opt/intel/openvino && \
git submodule init && git submodule update --recursive && \
cd /opt/intel/openvino/scripts/install_dependencies && \
chmod +x ./install_openvino_dependencies.sh && ./install_openvino_dependencies.sh -y && \
apt-get clean autoclean && \
apt-get autoremove --yes && \
rm -rf /var/lib/{apt,dpkg,cache,log} && \
mkdir -p /opt/intel/openvino/build && cd /opt/intel/openvino/build && \
cmake -D CMAKE_BUILD_TYPE=Release .. && make
