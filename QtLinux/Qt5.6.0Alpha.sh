#!/bin/bash

CURRENTPATH=$PWD

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential
sudo apt-get install -y python
sudo apt-get install -y perl

tar xvfz qt-everywhere-enterprise-src-5.6.0-alpha.tar.gz
cd qt-everywhere-enterprise-src-5.6.0-alpha

echo "Configuring Qt"
./configure -prefix $HOME/StaticQt5.6.0Alpha -confirm-license -qt-xcb -nomake examples -nomake tests

echo "Compiling Qt"
rm -rf $HOME/Qt5.6.0Alpha
make -j4
make install

cd $CURRENTPATH
rm -rf qt-everywhere-enterprise-src-5.6.0-alpha

echo "Done! The compiled Qt is installed at $HOME/Qt5.6.0Alpha"
