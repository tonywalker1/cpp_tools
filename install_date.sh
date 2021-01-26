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

REPO="https://github.com/HowardHinnant/date.git"
SRC_DIR="/usr/local/src/date"
CMAKE_ARGS="-DUSE_SYSTEM_TZ_DB=ON -DBUILD_SHARED_LIBS=ON -DBUILD_TZ_LIB=ON -DCMAKE_CXX_STANDARD=17 -DCMAKE_BUILD_TYPE=Release"
MAKE_ARGS="-j"

echo "***********************"
echo "*** Building Date ***"
echo "***********************"

if [ ! -d "$SRC_DIR" ]
then
    echo "* Creating the source directory"
    mkdir -p $SRC_DIR
fi
pushd "$SRC_DIR"


if [ ! -d "$SRC_DIR/.git" ]
then
    echo "* Cloning the repo"
    git clone "$REPO" "$SRC_DIR"
else
    echo "* Pulling changes"
    git pull --ff-only
fi


if [ ! -d "$SRC_DIR/build" ]
then
    echo "* Creating the build dir"
    mkdir "build"
fi
cd build


echo "* Building..."
cmake $CMAKE_ARGS ..
make $MAKE_ARGS


echo "* Removing previous versions"
rm -rf /usr/local/lib/cmake/date
rm -rf /usr/local/lib/libdate*
rm -rf /usr/local/include/date

echo "* Installing"
make install

# clean-up
popd
