#!/bin/sh
if [ $(id -u) = $(id -u root) ]; then
	echo "Root user"
else
	SUDO=sudo
fi
$SUDO apt update && \
$SUDO apt install -y \
	 wget \
	 mercurial \
	 software-properties-common \
&& \
$SUDO sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
$SUDO apt-key adv --keyserver hkp://ipv4.pool.sks-keyservers.net:80 --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
$SUDO sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list' && \
wget http://packages.osrfoundation.org/gazebo.key -O - | $SUDO apt-key add - && \
$SUDO apt update && \
$SUDO apt install -y \
	python3-vcstool \
	python3-colcon-common-extensions \
	g++-8 \
	gcc-8 \
	cmake \
	freeglut3-dev \
	libavcodec-dev \
	libavdevice-dev \
	libavformat-dev \
	libavutil-dev \
	libdart6-collision-ode-dev \
	libdart6-dev \
	libdart6-utils-urdf-dev \
	libfreeimage-dev \
	libgflags-dev \
	libglew-dev \
	libgts-dev \
	libogre-1.9-dev \
	libogre-2.1-dev \
	libprotobuf-dev \
	libprotobuf-dev \
	libprotoc-dev \
	libqt5core5a \
	libswscale-dev \
	libtinyxml2-dev \
	libtinyxml-dev \
	pkg-config \
	protobuf-compiler \
	python \
	qml-module-qt-labs-folderlistmodel \
	qml-module-qt-labs-settings \
	qml-module-qtquick2 \
	qml-module-qtquick-controls \
	qml-module-qtquick-controls2 \
	qml-module-qtquick-dialogs \
	qml-module-qtquick-layouts \
	qml-module-qtqml-models2 \
	qtbase5-dev \
	qtdeclarative5-dev \
	qtquickcontrols2-5-dev \
	ruby \
	ruby-ronn \
	uuid-dev \
	libzip-dev \
	libjsoncpp-dev \
	libcurl4-openssl-dev \
	libyaml-dev \
	libzmq3-dev \
	libsqlite3-dev \
	libwebsockets-dev \
	swig \
	ruby-dev \
&& \
$SUDO update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 800 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
mkdir -p ign_ws/src && \
cd ign_ws/src && \
wget https://bitbucket.org/osrf/gazebodistro/raw/default/collection-blueprint.yaml && \
vcs import < collection-blueprint.yaml && \
cd .. && \
colcon build --merge-install
