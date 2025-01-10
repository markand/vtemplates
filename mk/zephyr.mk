#
# zephyr.mk -- common definitions and rules for Zephyr development
#

ZEPHYR_BASE ?= $${HOME}/zephyrproject/zephyr
ZEPHYR_SDK_INSTALL_DIR ?= $${HOME}/zephyr-sdk
ZEPHYR_VENV ?= $${HOME}/zephyrproject/.venv/bin

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
		-e 's,@PATH@,$(call build-path,$(call tasks-expand-env,$(ZEPHYR_VENV) $${env:PATH})),g'
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
		-e 's,@PATH@,$(call build-path,$(call cmake-expand-env,$(ZEPHYR_VENV) $$penv{PATH})),g'

.PHONY: zephyr-boilerplate
zephyr-boilerplate:
	cp $(TOP)/zephyr/common/CMakeLists.txt $(DISTDIR)
	cp $(TOP)/zephyr/common/main.c $(DISTDIR)
	cp $(TOP)/zephyr/common/prj.conf $(DISTDIR)

include $(TOP)/mk/utils.mk
include $(TOP)/mk/cmake.mk
