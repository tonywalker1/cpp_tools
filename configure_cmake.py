#!/usr/bin/env python3
#
# MIT License
#
# Copyright (c) 2018-2020 Tony Walker
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

"""Simplify running CMake to generate build scripts for the given source.

Commandlines for CMake can be lengthy. This script simplifies running CMake
for a few common options.
"""

def parse_program_args():
    """Parse commandline arguments to the program."""
    parser = argparse.ArgumentParser(
        description="Tell CMake how to build the given source code."
    )
    parser.add_argument("path",
        help="location of source code"
    )
    parser.add_argument("-c",
        help="select the C/C++ compiler",
        choices=["gcc","clang"],
        default="gcc"
    )
    parser.add_argument("-m",
        help="select the build mode",
        choices=["release","debug"],
        default="release"
    )
    parser.add_argument("-s",
        help="add standard compile flags: -Wall -Wextra -Wpedantic",
        action="store_true"
    )
    parser.add_argument("-v",
        help="enable verbose CMake output",
        action="store_true"
    )
    return parser.parse_args()


def build_cmake_command(args):
    """Build the command to run CMake."""
    # set the compiler
    if args.c == "clang":
        compiler = "export CC=/usr/bin/clang;export CXX=/usr/bin/clang++;"
    else:
        compiler = "export CC=/usr/bin/gcc;export CXX=/usr/bin/g++;"

    # set the build mode
    if args.m == "debug":
        mode = "-DCMAKE_BUILD_TYPE=Debug"
    else:
        mode = "-DCMAKE_BUILD_TYPE=Release"

    # set the standard flags
    if args.s:
        flags = '-DCMAKE_CXX_FLAGS="-Wall -Wextra -Wpedantic"'
    else:
        flags = ''

    # set verbose make
    if args.v:
        verbose = "-DCMAKE_VERBOSE_MAKEFILE=TRUE"
    else:
        verbose = "-DCMAKE_VERBOSE_MAKEFILE=FALSE"

    # enable clang-tidy, etc. compile database
    cdb = '-DCMAKE_EXPORT_COMPILE_COMMANDS=ON'

    command = (compiler +
        "cmake "
            + mode + " "
            + verbose + " "
            + flags + " "
            + cdb + " "
            + args.path)
    return command


if __name__ == "__main__":
    import argparse
    import subprocess
    import sys

    # Use the program arguments to run CMake to generate build files for the
    # given source code.
    args = parse_program_args()
    command = build_cmake_command(args)
    result = subprocess.run([command], shell=True);
    sys.exit(result.returncode)
