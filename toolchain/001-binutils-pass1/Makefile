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

include 	../../make-rules/shared-macros.mk

COMPONENT_NAME=		binutils
COMPONENT_VERSION=	2.23.2
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2

include		$(WS_MAKE_RULES)/prep.mk

patch::
	$(SED) -i -e 's/@colophon/@@colophon/' \
		  -e 's/doc@cygnus.com/doc@@cygnus.com/' $(SOURCEDIR)/bfd/doc/bfd.texinfo

include		$(WS_MAKE_RULES)/configure.mk

BUILDDIR=		$(SOURCEDIR)/../build
CONFIGURE_PREFIX=	/tools
CONFIGURE_OPTIONS+=	--with-sysroot=$(LFS)
CONFIGURE_OPTIONS+=	--with-lib-path=/tools/lib
CONFIGURE_OPTIONS+=	--target=$(LFS_TGT)
CONFIGURE_OPTIONS+=	--disable-nls
CONFIGURE_OPTIONS+=	--disable-werror

build:		$(CONFIGURE_BUILD)

ifeq ($(shell uname -m), x86_64)
COMPONENT_INSTALL_PRE=	$(MKDIR) /tools/lib && $(SYMLINK) lib /tools/lib64
endif

install:	$(CONFIGURE_INSTALL)
