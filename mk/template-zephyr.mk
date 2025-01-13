#
# template-zephyr.mk -- common definitions and rules for Zephyr development
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
# Predefined targets
#
# zephyr-boilerplate
# ------------------
#
# Copy some boilerplate files for a minimal buildable project.
#
# Includes:
#   - CMakeLists.txt
#   - main.c
#   - prj.conf
#
# zephyr-cmake-presets
# --------------------
#
# Generate a CMakeUserPresets.json file with predefined configuration presets.
#
# zephyr-tasks-pre
# ----------------
#
# Substitude the beginning of the .vscode/tasks.json with predefined defaults.
# Header file ends in the beginning of the `tasks` array meaning after this
# target it's possible to add custom tasks.
#
# zephyr-tasks-post
# -----------------
#
# Append end of .vscode/tasks.json.
#
# zephyr-tasks
# ------------
#
# Generate a .vscode/tasks.json suitable for most Zephyr targets.
#

.PHONY: zephyr-tasks-pre
zephyr-tasks-pre:
	mkdir -p $(DISTDIR)/.vscode
	sed < $(TOP)/zephyr/common/zephyr/.vscode/tasks.pre.json \
		> $(DISTDIR)/.vscode/tasks.json \
		-e 's,@PATH@,$(call build-path,$(call tasks-expand-env,$(ZEPHYR_VENV)) $${env:PATH}),g' \
		-e 's,@ZEPHYR_BASE@,$(call tasks-expand-env,$(ZEPHYR_BASE)),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call tasks-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'

.PHONY: zephyr-tasks-post
zephyr-tasks-post:
	cat $(TOP)/zephyr/common/zephyr/.vscode/tasks.post.json \
		>> $(DISTDIR)/.vscode/tasks.json

.PHONY: zephyr-tasks
zephyr-tasks: zephyr-tasks-pre zephyr-tasks-post

.PHONY: zephyr-cmake-presets
zephyr-cmake-presets:
	sed < $(TOP)/zephyr/common/CMakeUserPresets.json \
		> $(DISTDIR)/CMakeUserPresets.json \
		-e 's,@BOARD@,$(BOARD),g' \
		-e 's,@CMAKE_GENERATOR@,$(CMAKE_GENERATOR),g' \
		-e 's,@ZEPHYR_BASE@,$(call cmake-expand-env,$(ZEPHYR_BASE)),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call cmake-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g' \
		-e 's,@PATH@,$(call build-path,$(call cmake-expand-env,$(ZEPHYR_VENV)) $$penv{PATH}),g'

.PHONY: zephyr-boilerplate
zephyr-boilerplate:
	mkdir -p $(DISTDIR)
	cp $(TOP)/zephyr/common/CMakeLists.txt $(DISTDIR)
	cp $(TOP)/zephyr/common/main.c $(DISTDIR)
	cp $(TOP)/zephyr/common/prj.conf $(DISTDIR)

include $(TOP)/config.mk

include $(TOP)/mk/utils.mk
include $(TOP)/mk/cmake.mk
