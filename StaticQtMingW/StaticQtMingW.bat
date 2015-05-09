set SSL_CERT_FILE=C:\Ruby22\cacert.pem
set PATH=C:\Windows;C:\Windows\System32;C:\Perl\bin;C:\Python34;C:\Ruby22\bin;C:\mingw32\bin;C:\gles_sdk\x86;
set INCLUDE=C:\gles_sdk\include;%INCLUDE%
set LIB=C:\gles_sdk\x86;%LIB%

ruby InstallDependancy.rb

cd qt-everywhere-opensource-src-5.4.1
echo "Configuring Qt"
call configure.bat -prefix c:\Qt\StaticQtMingW -debug-and-release -static -opensource -confirm-license -nomake examples -no-compile-examples -opengl desktop -platform win32-g++ -no-icu -skip qtwebkit -skip qtwebkit-examples -nomake tests -nomake tools -no-angle -strip
echo "Compiling Qt"
mingw32-make -j2 && mingw32-make install


echo "Done! The compiled static Qt is installed at c:/Qt/StaticQtMingW"
pause
