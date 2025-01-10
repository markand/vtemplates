#
# zephyr.mk -- common definitions and rules for Zephyr development
#

#
# Predefined targets
#
# zephyr-all
# ----------
#
# Copy some boilerplate files for a minimal buildable project.
#
# Includes:
#   - CMakeLists.txt
#   - main.c
#   - prj.conf
#

.PHONY: zephyr-all
zephyr-all:
	mkdir -p $(DISTDIR)
	cp $(TOP)/zephyr/common/CMakeLists.txt $(DISTDIR)
	cp $(TOP)/zephyr/common/main.c $(DISTDIR)
	cp $(TOP)/zephyr/common/prj.conf $(DISTDIR)
	sed < $(TOP)/zephyr/common/CMakeUserPresets.json \
		> $(DISTDIR)/CMakeUserPresets.json \
		-e "s,@BOARD@,$(BOARD),g"
