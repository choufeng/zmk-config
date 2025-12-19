cmake_minimum_required(VERSION 3.13.1)
find_package(Zephyr REQUIRED HINTS $ENV{ZEPHYR_BASE})
project(corne_romac)

zephyr_include_directories(.)
<<<<<<< HEAD
zephyr_library_sources(corne_romac.keymap)
=======
zephyr_library_sources(corne_romac.keymap)

# 添加shield配置支持
set(SHIELD_SOURCES "")
>>>>>>> d28344a (Add GitHub Actions workflow for ZMK builds)
