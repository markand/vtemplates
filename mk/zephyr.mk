#
# zephyr.mk -- Zephyr template for any board
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
# Zephyr template
# ===============
#
# Board inputs
# ------------
#
# ### ZEPHYR_BOARD (required)
#
# Board name that should match the directory.
#
# ### ZEPHYR_VENDOR (required)
#
# Vendor name which is usually equal to the grouping parent directory.
#
# ### ZEPHYR_TASKS_EXTRA (optional)
#
# Path to a JSON fragment containing tasks to be appended to the default
# Zephyr based tasks.json file. The fragment should be indented by 8 spaces with
# objects ending in a final comma.
#
# Example:
#
# ```
#         {
#             "command": "echo yes",
#             "label": "foo bar baz"
#             "type": "shell"
#         },
# ```
#
# Predefined variables
# --------------------
#
# ### ZEPHYR_DIR
#
# Set to the location of Zephyr template files.
#
# Predefined targets
# ------------------
#
# ### zephyr-all
#
# Depends on all other targets.
#
# ### zephyr-boilerplate
#
# Copy some boilerplate files for a minimal buildable project.
#
# Includes:
#   - CMakeLists.txt
#   - main.c
#   - prj.conf
#
# ### zephyr-cmake-presets
#
# Generate a CMakeUserPresets.json file with predefined configuration presets.
#
# ### zephyr-tasks
#
# Generate a .vscode/tasks.json suitable for most Zephyr targets.
#

.ONESHELL:

ifndef TOP
$(error TOP not set)
endif

ifndef ZEPHYR_BOARD
$(error ZEPHYR_BOARD not set)
endif

ifndef ZEPHYR_VENDOR
$(error ZEPHYR_VENDOR not set)
endif

include $(TOP)/config.mk

DISTDIR    = $(TOP)/dist/zephyr/$(ZEPHYR_VENDOR)/$(ZEPHYR_BOARD)
ZEPHYR_DIR = $(TOP)/zephyr

#
# Substitute TASKS_EXTRA from a file if ZEPHYR_TASKS_EXTRA is defined, otherwise
# delete the line.
#
ifneq ($(ZEPHYR_TASKS_EXTRA),)
define SED_TASKS_EXTRA
-e '/^@TASKS_EXTRA@/ {
	r $(ZEPHYR_TASKS_EXTRA)
	d
}'
endef
else
define SED_TASKS_EXTRA
-e '/^@TASKS_EXTRA@/d'
endef
endif

.PHONY: zephyr-all
zephyr-all: zephyr-boilerplate zephyr-cmake-presets zephyr-tasks

.PHONY: zephyr-boilerplate
zephyr-boilerplate:
	mkdir -p $(DISTDIR)
	sed < $(ZEPHYR_DIR)/CMakeLists.txt > $(DISTDIR)/CMakeLists.txt \
		-e 's,@CMAKE_MINIMUM_MAJOR@,$(CMAKE_MINIMUM_MAJOR),g' \
		-e 's,@CMAKE_MINIMUM_MINOR@,$(CMAKE_MINIMUM_MINOR),g' \
		-e 's,@CMAKE_MINIMUM_PATCH@,$(CMAKE_MINIMUM_PATCH),g'
	cp $(ZEPHYR_DIR)/main.c $(DISTDIR)
	cp $(ZEPHYR_DIR)/prj.conf $(DISTDIR)

.PHONY: zephyr-cmake-presets
zephyr-cmake-presets:
	mkdir -p $(DISTDIR)
	sed < $(ZEPHYR_DIR)/CMakeUserPresets.json > $(DISTDIR)/CMakeUserPresets.json \
		-e 's,@BOARD@,$(ZEPHYR_BOARD),g' \
		-e 's,@CMAKE_GENERATOR@,$(CMAKE_GENERATOR),g' \
		-e 's,@CMAKE_MINIMUM_MAJOR@,$(CMAKE_MINIMUM_MAJOR),g' \
		-e 's,@CMAKE_MINIMUM_MINOR@,$(CMAKE_MINIMUM_MINOR),g' \
		-e 's,@CMAKE_MINIMUM_PATCH@,$(CMAKE_MINIMUM_PATCH),g' \
		-e 's,@ZEPHYR_BASE@,$(call cmake-expand-env,$(ZEPHYR_BASE)),g' \
		-e 's,@ZEPHYR_PATH@,$(call cmake-concat-path,$(ZEPHYR_PATH)),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call cmake-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'

.PHONY: zephyr-tasks
zephyr-tasks:
	mkdir -p $(DISTDIR)/.vscode
	sed < $(ZEPHYR_DIR)/tasks.json > $(DISTDIR)/.vscode/tasks.json \
		-e 's,@ZEPHYR_PATH@,$(call vt-vscode-concat-path,$(ZEPHYR_PATH)),g' \
		-e 's,@ZEPHYR_BASE@,$(call vt-vscode-expand-env,$(ZEPHYR_BASE)),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call vt-vscode-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g' \
		$(SED_TASKS_EXTRA)

include $(TOP)/mk/cmake.mk
