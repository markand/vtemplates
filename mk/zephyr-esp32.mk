#
# zephyr-esp32.mk -- Zephyr template for Espressif devices
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
# Zephyr ESP32 template
# =====================
#
# This template is based on zephyr.mk, check its documentation for variables to
# be set.
#
# This template check for a SVD file named $(ESP32_CHIP).svd in the board
# directory and is installed in the dist directory if found.
#
# Board inputs
# ------------
#
# ### ESP32_CHIP (required)
#
# Canonical ESP32 target name (e.g. esp32c6)
#
# ### ESP32_APPIMAGE_OFFSET (required)
#
# Application image offset located in flash as hexadecimal value.
#
# ### ESP32_FLASH_START (optional)
#
# Flash start address.
#
# Hexadecimal value.
#
# Defaults: 0x00000000
#
# ### ESP32_FLASH_END (required)
#
# End of flash address that determines its size.
#
# Hexadecimal value.
#
# ### ESP32_SRAM_START (required)
#
# Absolute address where RAM starts.
#
# Hexadecimal value.
#
# ### ESP32_SRAM_END (required)
#
# Absolute address where RAM ends.
#
# Hexadecimal value.
#
# ### ESP32_TRIPLE (optional)
#
# Toolchain triple to use.
#
# Defaults: riscv64-zephyr-elf.
#
# ### ESP32_ADAPTER_SPEED (optional)
#
# Adapter speed in kHz as provided to OpenOCD.
#
# Defaults: 400.
#
# Predefined variables
# --------------------
#
# ### ESP32_DIR
#
# Set to the location of ESP32 specific template files.
#

.ONESHELL:

ifndef ESP32_APPIMAGE_OFFSET
$(error ESP32_APPIMAGE_OFFSET not set)
endif

ifndef ESP32_CHIP
$(error ESP32_CHIP not set)
endif

ifndef ESP32_FLASH_END
$(error ESP32_FLASH_END not set)
endif

ifndef ESP32_FLASH_END
$(error ESP32_FLASH_END not set)
endif

ifndef ESP32_SRAM_END
$(error ESP32_SRAM_END not set)
endif

ifndef ESP32_SRAM_START
$(error ESP32_SRAM_START not set)
endif

ESP32_DIR            = $(TOP)/zephyr/espressif

ESP32_TRIPLE        ?= riscv64-zephyr-elf
ESP32_ADAPTER_SPEED ?= 400
ESP32_FLASH_START   ?= 0x00000000

ZEPHYR_TASKS_EXTRA  = $(TOP)/zephyr/espressif/tasks.extra.json

.PHONY: all
all: zephyr-all
	sed < $(ESP32_DIR)/launch.json > $(DISTDIR)/.vscode/launch.json \
		-e 's,@ESP32_ADAPTER_SPEED@,$(ESP32_ADAPTER_SPEED),g' \
		-e 's,@ESP32_APPIMAGE_OFFSET@,$(ESP32_APPIMAGE_OFFSET),g' \
		-e 's,@ESP32_CHIP@,$(ESP32_CHIP),g' \
		-e 's,@ESP32_FLASH_END@,$(ESP32_FLASH_END),g' \
		-e 's,@ESP32_FLASH_START@,$(ESP32_FLASH_START),g' \
		-e 's,@ESP32_OPENOCD@,$(ESP32_OPENOCD),g' \
		-e 's,@ESP32_SRAM_END@,$(ESP32_SRAM_END),g' \
		-e 's,@ESP32_SRAM_START@,$(ESP32_SRAM_START),g' \
		-e 's,@ESP32_TRIPLE@,$(ESP32_TRIPLE),g' \
		-e 's,@ZEPHYR_SDK_INSTALL_DIR@,$(call vt-vscode-expand-env,$(ZEPHYR_SDK_INSTALL_DIR)),g'
	if [ -f $(ESP32_CHIP).svd ]; then \
		mkdir -p $(DISTDIR)/svd; \
		cp $(ESP32_CHIP).svd $(DISTDIR)/svd; \
	fi

include $(TOP)/mk/zephyr.mk
