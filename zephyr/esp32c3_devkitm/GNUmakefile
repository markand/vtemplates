#
# GNUmakefile -- Zephyr esp32c3_devkitm
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

TOP                     = ../..
BOARD                   = esp32c3_devkitm

ESP32_CHIP              = esp32c3
ESP32_TRIPLE            = riscv64-zephyr-elf
ESP32_APPIMAGE_OFFSET   = 0x42000000
ESP32_FLASH_START       = 0x00000000
ESP32_FLASH_END         = 0x00400000
ESP32_SRAM_START        = 0x3fc80000
ESP32_SRAM_END          = 0x3fce0000

include $(TOP)/mk/template-esp32.mk
