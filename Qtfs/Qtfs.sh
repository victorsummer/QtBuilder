#!/bin/bash

echo "Type the cross compiler path:"

read ccp

export PATH=$ccp:$PATH

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential
sudo apt-get install -y python
sudo apt-get install -y perl
sudo apt-get install -y wget

wget http://mirror.bit.edu.cn/qtproject/official_releases/qt/5.3/5.3.2/single/qt-everywhere-opensource-src-5.3.2.tar.gz
tar xvfz qt-everywhere-opensource-src-5.3.2.tar.gz
cd qt-everywhere-opensource-src-5.3.2
cp ../qmake.conf qtbase/mkspecs/linux-arm-gnueabi-g++/

echo "Configuring Qt"
./configure -opensource -confirm-license -release -xplatform linux-arm-gnueabi-g++ -no-c++11 -qreal float -prefix /usr/local/Qt-5.3.2

echo "Compiling Qt"
sudo rm -rf /usr/local/Qt-5.3.2
make -j4
sudo make install

cd ..
rm -rf qt-everywhere-opensource-src-5.3.2
rm qt-everywhere-opensource-src-5.3.2.tar.gz

echo "Done! The compiled Qt is installed at /usr/local/Qt-5.3.2"
pause
