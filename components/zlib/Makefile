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

COMPONENT_NAME=		zlib
COMPONENT_VERSION=	1.2.8
COMPONENT_PROJECT_URL=	http://www.zlib.net
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_URL=	http://www.zlib.net/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	md5:28f1205d8dd2001f26fec1e8c2cebe37
COMPONENT_DEPENDS+=	glibc

include		$(WS_MAKE_RULES)/download.mk
include		$(WS_MAKE_RULES)/extract.mk
include		$(WS_MAKE_RULES)/configure.mk

build:		$(CONFIGURE_BUILD)

COMPONENT_INSTALL_POST+=	$(MKDIR) $(INSTALLDIR)/lib;
COMPONENT_INSTALL_POST+=	$(MV) $(INSTALLDIR)/usr/lib/libz.so.* $(INSTALLDIR)/lib;
COMPONENT_INSTALL_POST+=	$(SYMLINK) ../../lib/libz.so.$(COMPONENT_VERSION) \
					$(INSTALLDIR)/usr/lib/libz.so;

install:	$(CONFIGURE_INSTALL)
