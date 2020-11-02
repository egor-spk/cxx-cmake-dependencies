# cxx-cmake-dependencies

This repository contains cmake files that help you add dependencies in your C++ project.
Enough include one of the files in your CMakefile.txt:
```cmake
include(path/to/dependecy.cmake)
```
and add library for yout target:
```cmake
target_link_libraries(TARGET <PRIVATE|PUBLIC|INTERFACE> DEPENDENCY)
```

Example:
```cmake
add_executable(console main.cpp)
include(Spdlog.cmake)
target_link_library(console PRIVATE spdlog::spdlog)
```