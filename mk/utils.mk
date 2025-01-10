#
# utils.mk -- miscellaneous utilities
#

# TODO: add separator between windows and linux.

define build-path
$(subst $(eval ) ,;,$1)
endef

define tasks-expand-env
$(shell echo '$1' | sed -E -e 's,\$$\{([^}]+)\},$${env:\1},g')
endef
