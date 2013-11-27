arch=$(uname -m)
if [ "$arch" == "i686" -o "$arch" == "i386" -o "$arch" == "i486" -o "$arch" == "i586" ]; then
flag=1
else
flag=0
fi
echo "Installazione OpenCV 2.4.7"
mkdir OpenCV
cd OpenCV
echo "------------------ Removing any pre-installed ffmpeg and x264 ------------------"
sudo apt-get remove ffmpeg x264 libx264-dev
echo "------------------ Installing Dependenices ------------------"
sudo apt-get install libopencv-dev
sudo apt-get install build-essential checkinstall cmake pkg-config yasm
sudo apt-get install libtiff4-dev libjpeg-dev libjasper-dev
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev
sudo apt-get install python-dev python-numpy
sudo apt-get install libtbb-dev
sudo apt-get install libqt4-dev libgtk2.0-dev
sudo apt-get install libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev
echo "------------------ Downloading x264 ------------------"
wget ftp://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-20131119-2245-stable.tar.bz2
tar -xvf x264-snapshot-20131119-2245-stable.tar.bz2
cd x264-snapshot-20131119-2245-stable/
echo "------------------ Installing x264 ------------------"
if [ $flag -eq 1 ]; then
./configure --enable-static
else
./configure --enable-shared --enable-pic
fi
make
sudo make install
cd ..
echo "------------------ Downloading ffmpeg ------------------"
wget http://ffmpeg.org/releases/ffmpeg-2.1.1.tar.gz  
echo "------------------ Installing ffmpeg ------------------"
tar -xvf ffmpeg-2.1.1.tar.gz  
cd ffmpeg-2.1.1/
if [ $flag -eq 1 ]; then
./configure --enable-gpl --enable-libfaac --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid --enable-nonfree --enable-postproc --enable-version3 --enable-x11grab
else
./configure --enable-gpl --enable-libfaac --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid --enable-nonfree --enable-postproc --enable-version3 --enable-x11grab --enable-shared
fi
make
sudo make install
cd ..
echo "------------------ Downloading v4l ------------------"
wget http://www.linuxtv.org/downloads/v4l-utils/v4l-utils-1.0.0.tar.bz2
echo "------------------ Installing v4l ------------------"
tar -xvf v4l-utils-1.0.0.tar.bz2
cd v4l-utils-1.0.0/
make
sudo make install
cd ..
echo "Installazione OpenCV 2.4.5"
mkdir OpenCV
cd OpenCV
echo "------------------ Download OpenCV 2.4.5 ------------------"
wget -O OpenCV-2.4.7.tar.gz http://downloads.sourceforge.net/project/opencvlibrary/opencv-unix/2.4.7/opencv-2.4.7.tar.gz
echo "------------------ Installazione OpenCV 2.4.5 ------------------"
tar -xvf OpenCV-2.4.7.tar.gz
cd opencv-2.4.7
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D WITH_CUDA=OFF ..
make
sudo make install
sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
sudo ldconfig
echo "OpenCV 2.4.5 pronte all'utilizzo"
