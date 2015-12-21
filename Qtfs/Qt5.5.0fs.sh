#!/bin/bash

CURRENTPATH=$PWD
ROOTFS_PATH=$PWD/rootfs

ROOTPATH="ROOTFS_PATH=$ROOTFS_PATH"

tar xvfz arm-gcc2014.tar.gz

cpp=$CURRENTPATH/arm-gcc2014/bin

export PATH=$cpp:$PATH

sudo tar xvfz rootfs_zy_opengl.tar.gz
sudo chgrp -hR $USER rootfs
sudo chown -hR $USER rootfs

sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential
sudo apt-get install -y python
sudo apt-get install -y perl
sudo apt-get install -y wget

tar xvfz qt-everywhere-enterprise-src-5.5.0.tar.gz
cd qt-everywhere-enterprise-src-5.5.0
cp ../qpdf.cpp qtbase/src/gui/painting/

rm -f qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf
sed '7c '"$ROOTPATH"'' ../qmake.conf > qtbase/mkspecs/devices/linux-imx6-g++/qmake.conf

echo "Configuring Qt"
./configure -release -opengl es2 -device imx6 -device-option CROSS_COMPILE=arm-none-linux-gnueabi- -prefix $HOME/QtImx6 -no-gcc-sysroot -no-openssl -qreal float -nomake examples -nomake tests -skip qtxmlpatterns -skip qtwebkit -no-icu -skip qtmultimedia

echo "Compiling Qt"
rm -rf $HOME/QtImx6
make -j4
make install

cd $CURRENTPATH
rm -rf qt-everywhere-enterprise-src-5.5.0
rm -rf arm-gcc2014
rm -rf rootfs

echo "Done! The compiled Qt is installed at $HOME/QtImx6"
