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
# ### SEP
#
# Directory separator, set to ';' if WIN32 make variable is set, ':' otherwise.
#
# Callable variables
# ------------------
#
# ### concat-path(...)
#
# Create a colon/semi-colon variable with all entries specified as argument
# separated by newlines.
#
# ### vscode-expand-env(string)
#
# Transform `string` such as every occurence of ${FOO} is replaced with a VSCode
# syntax ${env:FOO}. This only works if the variable is surrounded by {}.
#
# Note: because make also interpret ${} as variables, user must pass a double
# dollar sign in order to set an environment variable.
#

ifdef WIN32
SEP = ;
else
SEP = :
endif

.ONESHELL:
concat-path = $(shell printf '$1' | sed '/^$$/d' | tr '\n' '$(SEP)' | sed 's,$(SEP)$$,,')

.ONESHELL:
vscode-expand-env = $(shell printf '$1' | sed -e 's,\$${,$${env:,g')

.ONESHELL:
vscode-concat-path = $(call vscode-expand-env,$(call concat-path,$1))
