#
# utils.mk -- miscellaneous utilities
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
# Utilities
# =========
#
# Variables
# ---------
#
# ### VT_SEP
#
# Directory separator, set to ';' if WIN32 make variable is set, ':' otherwise.
#
# Callable variables
# ------------------
#
# ### vt-concat-path(nl-list)
#
# Create a colon/semi-colon variable with all entries specified as argument
# separated by newlines.
#
# ### vt-vscode-expand-env(string)
#
# Transform `string` such as every occurence of ${FOO} is replaced with a VSCode
# syntax ${env:FOO}. This only works if the variable is surrounded by {}.
#
# Note: because make also interpret ${} as variables, user must pass a double
# dollar sign in order to set an environment variable.
#
# ### vt-vscode-concat-path(nl-list)
#
# Concatenate the NL separated list of directories and expand their environment
# variables. Also append PATH to the end.
#
# Example:
#
# $${HOME}/bin becomes ${env:HOME}/bin;${env:PATH} (or : on Unix)
#

.ONESHELL:

include $(TOP)/config.mk

ifdef WIN32
VT_SEP := ;
else
VT_SEP := :
endif

define vt-concat-path =
$(shell printf '$1' | sed '/^$$/d' | tr '\n' '$(VT_SEP)' | sed 's,$(VT_SEP)$$,,')
endef

define vt-vscode-expand-env =
$(shell printf '$1' | sed -e 's,\$${,$${env:,g')
endef

define vt-vscode-concat-path =
$(call vt-vscode-expand-env,$(call vt-concat-path,$1))$(VT_SEP)$${env:PATH}
endef
