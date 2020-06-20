#!/bin/bash


echo -e "\033[35mУстановка ROS Melody on Ubuntu 18.4 Bionic\033[0m"

# install requirement packages
sudo apt-get -y update
sudo apt-get -y install git
#used for raspberry and others...
sudo apt-get -y install dirmngr

echo -ne "\033[32mУстанавливаем из исходников или через пакетный менеджер? (y - из исходников/n - через apt): \033[0m" && read arg
if [[ ${arg} == 'y' ]]; then
	# build ROS from source files
	# install required packages for build ROS
	sudo apt-get -y install python-rosdep
	sudo apt-get -y install python-rosinstall-generator 
	sudo apt-get -y install python-vcstool 
	sudo apt-get -y install python-rosinstall 
	sudo apt-get -y install build-essential
	# Initializing rosdep
	sudo rosdep init
	rosdep update

	# building the core ROS packages
	# create a catkin workspace
	mkdir ~/ros_catkin_ws
	cd ~/ros_catkin_ws
	# use vcstool to fetch the core packages (default variant - ROS, rqt, rviz, and robot-generic libraries)
	rosinstall_generator desktop --rosdistro melodic --deps --tar > melodic-desktop.rosinstall
	mkdir src
	sudo apt-get install python3-vcstool
	vcs import src < melodic-desktop.rosinstall
	# get all the required dependencies
	rosdep install --from-paths src --ignore-src --rosdistro melodic -y
	# building the catkin Workspace. Invoke catkin_make_isolated
	./src/catkin/bin/catkin_make_isolated --install -DCMAKE_BUILD_TYPE=Release
	# To utilize the things installed there simply source that file like so
	source ~/ros_catkin_ws/install_isolated/setup.bash

	echo -ne "\033[35mБудем запускать roscore? (y/n): \033[0m" && read ans
else
	# install on Ubuntu 18.4 Bionic using apt 
	# add required repo
	sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
	# use key
	sudo apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
	# update dependencies
	sudo apt-get update
	# install ros melodic desktop
	sudo apt install ros-melodic-desktop
	# env setup
	# ROS environment variables are automatically added to your bash session every time a new shell is launched
	source /opt/ros/melodic/setup.bash
	echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
	source ~/.bashrc
fi

echo -ne "\033[32mЗапустить roscore? (y/n): \033[0m" && read ans
if [[ ${ans} == 'y' ]]; then
	echo "Запуск roscore"
	roscore
else
	echo -e "\033[32mУстановка завершена\033[0m"
	echo "Для запуска используйте команду roscore"
fi
