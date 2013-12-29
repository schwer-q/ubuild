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

COMPONENT_NAME=		glibc
COMPONENT_VERSION=	2.18
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz

include		$(WS_MAKE_RULES)/prep.mk

patch::
	if test -r /usr/include/rpc/types.h; then \
		$(MKDIR) /usr/include/rpc ; \
		$(CP) sunrpc/rpc/*.h /usr/include/rpc ; \
	fi
	$(SED) -e -e 's/static __m128i/inline &/' $(SOURCEDIR)/sysdeps/x86_64/multiarch/strstr.c

include		$(WS_MAKE_RULES)/configure.mk

BUILDDIR=		$(SOURCEDIR)/../build
CONFIGURE_PREFIX=	/tools
CONFIGURE_OPTIONS+=	--host=$(LFS_TGT)
CONFIGURE_OPTIONS+=	--build=$$($(SOURCEDIR)/scripts/config.guess)
CONFIGURE_OPTIONS+=	--disable-profile
CONFIGURE_OPTIONS+=	--enable-kernel=2.6.32
CONFIGURE_OPTIONS+=	--with-headers=/tools/include
CONFIGURE_OPTIONS+=	libc_cv_forced_unwind=yes
CONFIGURE_OPTIONS+=	libc_cv_ctor_header=yes
CONFIGURE_OPTIONS+=	libc_cv_c_cleanup=yes

build:		$(CONFIGURE_BUILD)

install:	$(CONFIGURE_INSTALL)
