cmake_minimum_required(VERSION @CMAKE_MINIMUM_MAJOR@.@CMAKE_MINIMUM_MINOR@.@CMAKE_MINIMUM_PATCH@)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(hello)
target_sources(app PRIVATE main.c)
