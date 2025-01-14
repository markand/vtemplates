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

ifndef TOP
$(error TOP not set)
endif

ifndef ZEPHYR_BOARD
$(error ZEPHYR_BOARD not set)
endif

ifndef ZEPHYR_VENDOR
$(error ZEPHYR_VENDOR not set)
endif

DISTDIR = $(TOP)/dist/zephyr/$(ZEPHYR_VENDOR)/$(ZEPHYR_BOARD)
ZEPHYR_DIR = $(TOP)/zephyr

#
# Sed arguments for tasks.json
#
SED_TASKS_PATH = -e 's,@PATH@,$(call build-path,$(call vscode-expand-env,$(ZEPHYR_VENV)) $${env:PATH}),g'
SED_TASKS_ZEPHYR_BASE = -e 's,@ZEPHYR_BASE@,$(call vscode-expand-env,$(ZEPHYR_BASE)),g'
SED_TASKS_ZEPHYR_SDK_INSTALL_DIR = -e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call vscode-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'

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

#
# Sed arguments for CMakeUserPresets.json
#
SED_PRESETS_CMAKE_GENERATOR = -e 's,@CMAKE_GENERATOR@,$(CMAKE_GENERATOR),g'
SED_PRESETS_BOARD = -e 's,@BOARD@,$(ZEPHYR_BOARD),g'
SED_PRESETS_ZEPHYR_BASE = -e 's,@ZEPHYR_BASE@,$(call cmake-expand-env,$(ZEPHYR_BASE)),g'
SED_PRESETS_ZEPHYR_SDK_INSTALL_DIR = -e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call cmake-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'
SED_PRESETS_PATH = -e 's,@PATH@,$(call build-path,$(call cmake-expand-env,$(ZEPHYR_VENV)) $$penv{PATH}),g'

.PHONY: zephyr-all
zephyr-all: zephyr-boilerplate zephyr-cmake-presets zephyr-tasks

.PHONY: zephyr-boilerplate
zephyr-boilerplate:
	mkdir -p $(DISTDIR)
	cp $(ZEPHYR_DIR)/CMakeLists.txt $(DISTDIR)
	cp $(ZEPHYR_DIR)/main.c $(DISTDIR)
	cp $(ZEPHYR_DIR)/prj.conf $(DISTDIR)

.PHONY: zephyr-cmake-presets
zephyr-cmake-presets:
	sed < $(ZEPHYR_DIR)/CMakeUserPresets.json > $(DISTDIR)/CMakeUserPresets.json \
		$(SED_PRESETS_BOARD) \
		$(SED_PRESETS_CMAKE_GENERATOR) \
		$(SED_PRESETS_PATH) \
		$(SED_PRESETS_ZEPHYR_BASE) \
		$(SED_PRESETS_ZEPHYR_SDK_INSTALL_DIR)

.ONESHELL:
.PHONY: zephyr-tasks
zephyr-tasks:
	mkdir -p $(DISTDIR)/.vscode
	sed < $(ZEPHYR_DIR)/tasks.json > $(DISTDIR)/.vscode/tasks.json \
		$(SED_TASKS_EXTRA) \
		$(SED_TASKS_PATH) \
		$(SED_TASKS_ZEPHYR_BASE) \
		$(SED_TASKS_ZEPHYR_SDK_INSTALL_DIR)

include $(TOP)/config.mk

include $(TOP)/mk/utils.mk
include $(TOP)/mk/cmake.mk
