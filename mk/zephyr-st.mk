#
# template-st.mk -- common definitions and rules for Espressif devices
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
# Per board macros.
#
# ### ST_SVD (optional)
#
# Path to SVD file.
#
# ### ST_FLASHER (optional)
#
# Which flasher to use, can be either
#
#   - openocd
#   - stlink
#
# Defaults: openocd
#
# ### ST_OPENOCD_CONFIG (required*)
#
# The configuration file to use with OpenOCD only if ST_FLASHER is set to
# openocd.
#
# ### ST_TRIPLE (optional)
#
# Toolchain triple to use.
#
# Defaults: arm-zephyr-eabi.
#

.ONESHELL:

ifndef ST_CHIP
$(error ST_CHIP not set)
endif

ST_DIR      = $(TOP)/zephyr/st

ST_TRIPLE  ?= arm-zephyr-eabi
ST_FLASHER ?= openocd

ifeq ($(ST_FLASHER),openocd)
ifndef ST_OPENOCD_CONFIG
$(error ST_OPENOCD_CONFIG must be set if ST_FLASHER is openocd)
endif
LAUNCH = $(ST_DIR)/launch.openocd.json
else
LAUNCH = $(ST_DIR)/launch.stlink.json
endif

.PHONY: all
all: zephyr-all
	sed < $(LAUNCH) > $(DISTDIR)/.vscode/launch.json \
		-e 's,@OPENOCD@,$(call vt-vscode-expand-env,$(OPENOCD)),g' \
		-e 's,@ST_CHIP@,$(ST_CHIP),g' \
		-e 's,@ST_OPENOCD_CONFIG@,$(ST_OPENOCD_CONFIG),g' \
		-e 's,@ST_SVD@,$(ST_SVD),g' \
		-e 's,@ST_TRIPLE@,$(ST_TRIPLE),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call vt-vscode-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'
ifdef ST_SVD
	mkdir -p $(DISTDIR)/svd;
	cp $(ST_SVD) $(DISTDIR)/svd
endif

include $(TOP)/mk/zephyr.mk
