#
# esp32.mk -- common definitions and rules for Espressif devices
#

#
# Global user configuration.
#
# ESP32_OPENOCD
# -------------
#
# Path to the custom espressif openocd fork, we will assume that it is build
# with a prefix 'esp32-' to avoid conflict with upstream openocd.
#

ESP32_OPENOCD           ::= esp32-openocd

#
# Per board macros.
#
# ESP32_TRIPLE (required)
# -----------------------
#
# Toolchain triple to use (e.g. riscv64-zephyr-elf).
#
# ESP32_ADAPTER_SPEED
# -------------------
#
# Adapter speed in kHz as provided to OpenOCD.
#
ESP32_ADAPTER_SPEED      ?= 400

#
# Internal macros.
#
COMMON_ESP32_DIR        ::= $(TOP)/zephyr/common/esp32
DISTDIR                 ::= $(TOP)/dist/zephyr/$(BOARD)

.PHONY: all
all: zephyr-boilerplate zephyr-cmake-presets esp32-tasks
	mkdir -p $(DISTDIR)/.vscode
	mkdir -p $(DISTDIR)/svd
	sed < $(COMMON_ESP32_DIR)/.vscode/launch.json > $(DISTDIR)/.vscode/launch.json \
		-e "s,@ESP32_ADAPTER_SPEED@,$(ESP32_ADAPTER_SPEED),g" \
		-e "s,@ESP32_APPIMAGE_OFFSET@,$(ESP32_APPIMAGE_OFFSET),g" \
		-e "s,@ESP32_CHIP@,$(ESP32_CHIP),g" \
		-e "s,@ESP32_FLASH_END@,$(ESP32_FLASH_END),g" \
		-e "s,@ESP32_FLASH_START@,$(ESP32_FLASH_START),g" \
		-e "s,@ESP32_OPENOCD@,$(ESP32_OPENOCD),g" \
		-e "s,@ESP32_SRAM_END@,$(ESP32_SRAM_END),g" \
		-e "s,@ESP32_SRAM_START@,$(ESP32_SRAM_START),g" \
		-e "s,@ESP32_TRIPLE@,$(ESP32_TRIPLE),g"
	cp svd/$(ESP32_CHIP).svd $(DISTDIR)/svd

esp32-tasks-pre: zephyr-tasks-pre
	cat $(COMMON_ESP32_DIR)/.vscode/tasks.extra.json >> $(DISTDIR)/.vscode/tasks.json

esp32-tasks-post: esp32-tasks-pre zephyr-tasks-post

esp32-tasks: esp32-tasks-post

include $(TOP)/mk/zephyr.mk
