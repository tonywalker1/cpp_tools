# cpp_tools

Useful tools for configuring build environments, clang-format, clang-tidy, etc

NOTE: I have shifted my development to Rust. I will leave this project here, but unmaintained.

# Contents

**.clang-format** - My favorite clang-format configuration.

**.clang-tidy** - My favorite clang-tidy configuration.

**configure_cmake.py** - Commandlines for CMake can be lengthy. This script
simplifies running CMake for a few common options.

**install_atom** - Download and install the Atom text editor (deb package).

**install_catch2.sh** - Clone, build, and install the latest version of Catch2.

**install_date.sh** - Clone, build, and install Howard Hinnant's date/timezone
library (accepted for C++20 but not implemented yet in GCC/Clang).

# Usage

See the the code for documentation and examples.

# Installing

```shell
cd <development_directory>
git clone https://github.com/tonywalker1/cpp_tools.git
cd cpp_tools
sudo make install
```
NOTE: Does not install .clang-format or .clang-tidy. You should copy those into
your projects manually as needed.

# Helping

I would love suggestions, fixes, documentation, examples, and other
contributions. Feel free to discuss additions/contributions with me.
