#
# GNUmakefile -- subdirectory for STM32 Zephyr templates
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

SUBDIRS = nucleo_c031c6 \
          nucleo_f030r8 \
          nucleo_f031k6 \
          nucleo_f042k6 \
          nucleo_f070rb \
          nucleo_f091rc \
          nucleo_f103rb \
          nucleo_f207zg \
          nucleo_f302r8 \
          nucleo_f303k8 \
          nucleo_f303re \
          nucleo_f334r8 \
          nucleo_f401re \
          nucleo_f410rb \
          nucleo_f411re \
          nucleo_f412zg \
          nucleo_f413zh \
          nucleo_f429zi \
          nucleo_f446re \
          nucleo_f446ze \
          nucleo_f722ze \
          nucleo_f746zg \
          nucleo_f756zg \
          nucleo_f767zi \
          nucleo_g031k8 \
          nucleo_g070rb \
          nucleo_g071rb \
          nucleo_g0b1re \
          nucleo_g431kb \
          nucleo_g431rb \
          nucleo_g474re \
          nucleo_h503rb \
          nucleo_h533re \
          nucleo_h563zi \
          nucleo_h723zg \
          nucleo_h743zi \
          nucleo_h745zi_q \
          nucleo_h753zi \
          nucleo_h755zi_q \
          nucleo_h7a3zi_q \
          nucleo_l011k4 \
          nucleo_l031k6 \
          nucleo_l053r8 \
          nucleo_l073rz \
          nucleo_l152re \
          nucleo_l412rb_p \
          nucleo_l432kc \
          nucleo_l433rc_p \
          nucleo_l452re \
          nucleo_l476rg \
          nucleo_l496zg \
          nucleo_l4a6zg \
          nucleo_l4r5zi \
          nucleo_l552ze_q \
          nucleo_u031r8 \
          nucleo_u083rc \
          nucleo_u575zi_q \
          nucleo_u5a5zj_q \
          nucleo_wb05kz \
          nucleo_wb09ke \
          nucleo_wb55rg \
          nucleo_wba52cg \
          nucleo_wba55cg \
          nucleo_wl55jc

.PHONY: all
all:
	for s in $(SUBDIRS); do $(MAKE) -C $$s || exit 1; done
