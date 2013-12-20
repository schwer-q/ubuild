#
# Copyright (c) 2013, Quentin Schwerkolt
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice, this
#   list of conditions and the following disclaimer in the documentation and/or
#   other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

WS_ROOT:=	$(shell git rev-parse --show-toplevel)
WS_COMPONENTS=	$(WS_ROOT)/components
WS_DISTFILES=	$(WS_ROOT)/distfiles
WS_MAKE_RULES=	$(WS_ROOT)/make-rules
WS_REPO=	$(WS_ROOT)/repo
WS_TOOLS=	$(WS_ROOT)/tools

export WS_ROOT
export WS_COMPONENTS
export WS_DISTFILES
export WS_MAKE_RULES
export WS_REPO
export WS_TOOLS

COMPONENTS_MK=	$(WS_TOOLS)/components_mk

BUILDDIR=	$(COMPONENT_DIR)/$(COMPONENT_SRC)
COMPONENT_DIR=	$(shell pwd)
INSTALLDIR=	$(COMPONENT_DIR)/install
PROGRESSDIR=	$(COMPONENT_DIR)/progress
SOURCEDIR=	$(COMPONENT_DIR)/$(COMPONENT_SRC)

ENV=		/usr/bin/env
EXTRACT=	$(WS_TOOLS)/extract.sh
FETCH=		$(WS_TOOLS)/fetch.sh
FIND=		/usr/bin/find
GMAKE=		/usr/bin/gmake
MD5SUM=		/usr/bin/md5sum
MKDIR=		/bin/mkdir -p
RM=		/bin/rm -f
SH=		/bin/sh
SHA256SUM=	/usr/bin/sha256sum
SYMLINK=	/bin/ln -s
TAR=		/bin/tar
TOUCH=		/usr/bin/touch

export ENV
export EXTRACT
export FETCH
export FIND
export GMAKE
export MD5SUM
export MKDIR
export RM
export SH
export SHA256SUM
export SYMLINK
export TAR
export TOUCH
