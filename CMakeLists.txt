cmake_minimum_required(VERSION 3.13.1)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(corne_romac)

zephyr_include_directories(.)
zephyr_library_sources(corne_romac.keymap)