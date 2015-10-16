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
./configure -opensource -confirm-license -release -xplatform linux-arm-gnueabi-g++ -no-c++11 -qreal float -no-pch -no-xcb -nomake examples -prefix $HOME/Qtfs

echo "Compiling Qt"
make -j4 && make install

cd ..
rm -rdf qt-everywhere-opensource-src-5.3.2
rm qt-everywhere-opensource-src-5.3.2.tar.gz

sudo rm -rdf $HOME/Qtfs

echo "Done! The compiled Qt is installed at $HOME/Qtfs"
pause
