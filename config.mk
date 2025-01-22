#
# config.mk -- global configuration
#
# Copyright (c) 2025 David Demelier <markand@malikania.fr>
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

#
# Global generation options
# =========================
#
# Those options can be overriden to generate pre-defined templates with user
# specific defaults in a local file named `config.local.mk`.
#
# Because Make uses the same syntax for variables and environment variable, it
# is required to prepend the '$' sign twice when referencing environment
# variable and only the ${} syntax is allowed.
#
# Example: ZEPHYR_BASE = $${HOME}/zephyr-4.0.0/zephyrproject
#
# Note: not all settings support environment variable so use them sparingly.
#
# General
# -------
#
# ### WIN32
#
# Define this variable if building for Windows platform.
#
# MinGW
# -----
#
# Options towards MinGW (MinGW-64).
#
# ### MINGW64_PATH
#
# Root directory where MinGW-64 toolchain lives (e.g. C:/mingw64)
#
# Defaults: C:/mingw64
#
# ### MINGW64_GCC
#
# Path to gcc.exe.
#
# If relative, it should be present in the PATH which is usually the case at
# $(MINGW64_PATH)/bin will be prepended to all build systems.
#
# Defaults: gcc.exe
#
# ### MINGW64_GXX
#
# Similar to MINGW64_GCC but for g++.
#
# Defaults: g++.exe
#
# ### MINGW64_GDB
#
# Similar to MINGW64_GCC but for gdb.exe
#
# Defaults: gdb.exe
#
# CMake
# -----
#
# ### CMAKE_GENERATOR
#
# Preferred generator to use.
#
# Defaults: Ninja.
#
# ESP32
# -----
#
# ### ESP32_OPENOCD
#
# Path to the custom espressif openocd fork, we will assume that it is build
# with a prefix 'esp32-' to avoid conflict with upstream openocd.
#
# Zephyr
# ------
#
# ### ZEPHYR_BASE
#
# Path to Zephyr root directory.
#
# Defaults: $${HOME}/zephyrproject/zephyr
#
# ### ZEPHYR_SDK_INSTALL_DIR
#
# Path to the Zephyr SDK which contains toolchain.
#
# Defaults: $${HOME}/zephyr-sdk
#
# ### ZEPHYR_VENV
#
# Path to Zephyr python virtual environment.
#
# Defaults: $${HOME}/zephyrproject/.venv/bin     (Others)
# Defaults: $${HOME}/zephyrproject/.venv/Scripts (Windows)
#

CMAKE_GENERATOR ?= Ninja

ESP32_OPENOCD ?= esp32-openocd

OPENOCD ?= openocd

MINGW64_GCC ?= gcc.exe
MINGW64_GDB ?= gdb.exe
MINGW64_GXX ?= g++.exe
MINGW64_PATH ?= C:/mingw64

ZEPHYR_BASE ?= $${HOME}/zephyrproject/zephyr
ZEPHYR_SDK_INSTALL_DIR ?= $${HOME}/zephyr-sdk

ifeq ($(WIN32),1)
ZEPHYR_VENV ?= $${HOME}/zephyrproject/.venv/Scripts
else
ZEPHYR_VENV ?= $${HOME}/zephyrproject/.venv/bin
endif

-include $(TOP)/config.local.mk
