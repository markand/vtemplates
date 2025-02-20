#
# cmake.mk -- CMake utilities
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

#
# CMake utilities
# ===============
#
# This file contains CMake utilities.
#
# Function-like macros
# --------------------
#
# ### cmake-expand-env(variable)
#
# Expand a shell like variable into the CMake syntax suitable for CMake Presets
# JSON schema.
#
# Example: if variable contains ${HOME}/foo/bar it is converted to
# $env{HOME}/foo/bar.
#
# ### cmake-concat-path(nl-list)
#
# Concatenate the NL separated list of directories and expand their environment
# variables. Also append PATH to the end.
#
# Example:
#
# $${HOME}/bin becomes $env{HOME}/bin;$penv{PATH} (or : on Unix)
#
# Predefined targets
# ------------------
#
# ### cmake-boilerplate
#
# Create a CMakeLists.txt, main.c and a tasks.json file suitable for most use
# with toplevel macros defined.
#
# Predefined variables
# --------------------
#
# ### CMAKE_DIR
#
# Set to the location of CMake template files.
#

.ONESHELL:

include $(TOP)/config.mk

CMAKE_DIR := $(TOP)/cmake

.PHONY: cmake-boilerplate
cmake-boilerplate:
	mkdir -p $(DISTDIR)/.vscode
	sed < $(CMAKE_DIR)/CMakeLists.txt > $(DISTDIR)/CMakeLists.txt \
		-e 's,@CMAKE_MINIMUM_MAJOR@,$(CMAKE_MINIMUM_MAJOR),g' \
		-e 's,@CMAKE_MINIMUM_MINOR@,$(CMAKE_MINIMUM_MINOR),g' \
		-e 's,@CMAKE_MINIMUM_PATCH@,$(CMAKE_MINIMUM_PATCH),g'
	cp $(CMAKE_DIR)/main.c $(DISTDIR)
	cp $(CMAKE_DIR)/tasks.json $(DISTDIR)/.vscode

define cmake-expand-env =
$(shell printf '$1' | sed 's,\$${,$$env{,g')
endef

define cmake-concat-path =
$(call cmake-expand-env,$(call vt-concat-path,$1))$(VT_SEP)$$penv{PATH}
endef

include $(TOP)/mk/utils.mk
