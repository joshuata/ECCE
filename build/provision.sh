#!/usr/bin/env bash
## Provision an Ubuntu machine for C++ development.
##
apt-get update
# apt-get install -y lubuntu-desktop
apt-get install -y build-essential gfortran cmake ccache tmux gdb gdbserver openjdk-8-jdk \
    python-dev libgtk2.0-dev freeglut3-dev \
    libjpeg-dev libtiff-dev
