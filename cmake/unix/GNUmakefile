#
# GNUmakefile -- subdirectory for CMake common UNIX clang/gcc + lldb
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
DISTDIR         = $(TOP)/dist/cmake/unix

.PHONY: all
all:
	mkdir -p $(DISTDIR)
	cp CMakeLists.txt $(DISTDIR)
	sed < CMakeUserPresets.json > $(DISTDIR)/CMakeUserPresets.json \
		-e 's,@CMAKE_GENERATOR@,$(CMAKE_GENERATOR),g'
	cp main.c $(DISTDIR)
	mkdir -p $(DISTDIR)/.vscode
	cp launch.json $(DISTDIR)/.vscode
	cp tasks.json $(DISTDIR)/.vscode

include $(TOP)/config.mk
