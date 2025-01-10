#
# cmake.mk -- cmake routines
#

#
# Global options
#
# CMAKE_GENERATOR
# ---------------
#
# Preferred generator to use.
#
# Defaults: Ninja.
#

CMAKE_GENERATOR ?= Ninja

#
# Function-like macros
#
# cmake-expand-env(variable)
# --------------------------
#
# Expand a shell like variable into the CMake syntax. Example: if variable
# contains ${HOME}/foo/bar it is converted to $env{HOME}/foo/bar.
#

define cmake-expand-env
$(shell echo '$1' | sed -E -e 's,\$$\{([^}]+)\},$$env{\1},g')
endef
