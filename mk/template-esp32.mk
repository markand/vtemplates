#
# esp32.mk -- common definitions and rules for Espressif devices
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
# ### ESP32_TRIPLE (required)
#
# Toolchain triple to use (e.g. riscv64-zephyr-elf).
#
# ### ESP32_ADAPTER_SPEED
#
# Adapter speed in kHz as provided to OpenOCD.
#

ESP32_ADAPTER_SPEED      ?= 400

#
# Internal macros.
#
COMMON_ESP32_DIR        = $(TOP)/zephyr/common/esp32
DISTDIR                 = $(TOP)/dist/zephyr/$(BOARD)

.PHONY: all
all: zephyr-boilerplate zephyr-cmake-presets esp32-tasks
	mkdir -p $(DISTDIR)/.vscode
	mkdir -p $(DISTDIR)/svd
	sed < $(COMMON_ESP32_DIR)/.vscode/launch.json > $(DISTDIR)/.vscode/launch.json \
		-e 's,@ESP32_ADAPTER_SPEED@,$(ESP32_ADAPTER_SPEED),g' \
		-e 's,@ESP32_APPIMAGE_OFFSET@,$(ESP32_APPIMAGE_OFFSET),g' \
		-e 's,@ESP32_CHIP@,$(ESP32_CHIP),g' \
		-e 's,@ESP32_FLASH_END@,$(ESP32_FLASH_END),g' \
		-e 's,@ESP32_FLASH_START@,$(ESP32_FLASH_START),g' \
		-e 's,@ESP32_OPENOCD@,$(ESP32_OPENOCD),g' \
		-e 's,@ESP32_SRAM_END@,$(ESP32_SRAM_END),g' \
		-e 's,@ESP32_SRAM_START@,$(ESP32_SRAM_START),g' \
		-e 's,@ESP32_TRIPLE@,$(ESP32_TRIPLE),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call tasks-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'
	cp svd/$(ESP32_CHIP).svd $(DISTDIR)/svd

.PHONY: esp32-tasks-pre
esp32-tasks-pre: zephyr-tasks-pre
	cat $(COMMON_ESP32_DIR)/.vscode/tasks.extra.json >> $(DISTDIR)/.vscode/tasks.json

.PHONY: esp32-tasks-post
esp32-tasks-post: esp32-tasks-pre zephyr-tasks-post

.PHONY: esp32-tasks
esp32-tasks: esp32-tasks-post

include $(TOP)/mk/template-zephyr.mk
