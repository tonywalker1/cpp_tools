#!/bin/bash
#
# MIT License
#
# Copyright (c) 2018-2021 Tony Walker
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

REPO="https://github.com/catchorg/Catch2.git"
BRANCH="v2.x"
SRC_DIR="/usr/local/src/catch2"
CMAKE_ARGS="-DCMAKE_BUILD_TYPE=Release"
MAKE_ARGS="-j"

echo "***********************"
echo "*** Building Catch2 ***"
echo "***********************"

if [ ! -d "$SRC_DIR" ]
then
    echo "* Creating the source directory"
    sudo mkdir -p $SRC_DIR
fi
pushd "$SRC_DIR"


if [ ! -d "$SRC_DIR/.git" ]
then
    echo "* Cloning the repo"
    sudo git clone -b "$BRANCH" "$REPO" "$SRC_DIR"
else
    echo "* Pulling changes"
    sudo git pull --ff-only
fi


if [ ! -d "$SRC_DIR/build" ]
then
    echo "* Creating the build dir"
    sudo mkdir "build"
fi
cd build


echo "* Building..."
sudo cmake $CMAKE_ARGS ..
sudo make $MAKE_ARGS


echo "* Removing previous versions"
sudo rm -rf /usr/local/lib/cmake/Catch2
sudo rm -rf /usr/local/lib/libCatch2*
sudo rm -rf /usr/local/include/catch2
sudo rm -rf /usr/local/share/doc/Catch2
sudo rm -rf /usr/local/share/Catch2
sudo rm -rf /usr/local/share/pkgconfig/catch2.pc

echo "* Installing"
sudo make install

# clean-up
popd
