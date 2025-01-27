#
# GNUmakefile -- subdirectory for CMake Windows MinGW64+GDB
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

TOP             = ../..
DISTDIR         = $(TOP)/dist/cmake/windows-mingw64

.PHONY: all
all: cmake-boilerplate
	sed < CMakeUserPresets.json > $(DISTDIR)/CMakeUserPresets.json \
		-e 's,@CMAKE_GENERATOR@,$(CMAKE_GENERATOR),g' \
		-e 's,@CMAKE_MINIMUM_MAJOR@,$(CMAKE_MINIMUM_MAJOR),g' \
		-e 's,@CMAKE_MINIMUM_MINOR@,$(CMAKE_MINIMUM_MINOR),g' \
		-e 's,@CMAKE_MINIMUM_PATCH@,$(CMAKE_MINIMUM_PATCH),g' \
		-e 's,@MINGW64_GCC@,$(MINGW64_GCC),g' \
		-e 's,@MINGW64_GXX@,$(MINGW64_GXX),g' \
		-e 's,@MINGW64_PATH@,$(call cmake-concat-path,$(MINGW64_PATH)),g'
	mkdir -p $(DISTDIR)/.vscode
	sed < launch.json > $(DISTDIR)/.vscode/launch.json \
		-e 's,@MINGW64_GDB@,$(MINGW64_GDB),g' \
		-e 's,@MINGW64_PATH@,$(call vscode-concat-path,$(MINGW64_PATH)),g'

include $(TOP)/mk/cmake.mk
