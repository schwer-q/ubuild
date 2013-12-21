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
COMPONENT_PROJECT_URL=	http://www.gnu.org/software/libc
COMPONENT_SRC=		${COMPONENT_NAME}-${COMPONENT_VERSION}
COMPONENT_ARCHIVE=	${COMPONENT_SRC}.tar.xz
COMPONENT_ARCHIVE_URL=	http://ftp.gnu.org/gnu/${COMPONENT_NAME}/${COMPONENT_ARCHIVE}
COMPONENT_ARCHIVE_HASH=	md5:88fbbceafee809e82efd52efa1e3c58f

include		$(WS_MAKE_RULES)/download.mk
include		$(WS_MAKE_RULES)/extract.mk

patch::
	$(SED) -i -e 's/static __m128i/inline &/' $(SOURCEDIR)/sysdeps/x86_64/multiarch/strstr.c

include		$(WS_MAKE_RULES)/configure.mk

BUILDDIR=		$(SOURCEDIR)/../build
CONFIGURE_PREFIX=	/usr
CONFIGURE_OPTIONS+=	--disable-profile
CONFIGURE_OPTIONS+=	--enable-kernel=2.6.32
CONFIGURE_OPTIONS+=	--libexecdir=/usr/lib/glibc

build:		$(CONFIGURE_BUILD)

COMPONENT_INSTALL_ARGS+=	install_root=$(INSTALLDIR)
COMPONENT_INSTALL_TARGETS=	localedata/install-locales
COMPONENT_INSTALL_PRE+=		$(MKDIR) $(INSTALLDIR)/etc;
COMPONENT_INSTALL_PRE+=		$(TOUCH) $(INSTALLDIR)/etc/ld.so.conf;
COMPONENT_INSTALL_PRE+=		$(CP) ../$(COMPONENT_SRC)/sunrpc/rpc/*.h \
					$(INSTALLDIR)/usr/include/rpc;
COMPONENT_INSTALL_PRE+=		$(CP) ../$(COMPONENT_SRC)/sunrpc/rpcsvc/*.h \
					$(INSTALLDIR)/usr/include/rpcsvc;
COMPONENT_INSTALL_PRE+=		$(CP) ../$(COMPONENT_SRC)/nis/rpcsvc/*.h \
					$(INSTALLDIR)/usr/include/rpcsvc;
COMPONENT_INSTALL_PRE+=		$(MKDIR) $(DESTDIR)/usr/lib/locale;
COMPONENT_INSTALL_POST+=	$(CP) $(COMPONENT_FILES)/etc.nsswitch.conf \
					$(INSTALLDIR)/etc/nsswitch.conf;
COMPONENT_INSTALL_POST+=	$(CP) $(COMPONENT_FILES)/etc.ld.so.conf \
					$(INSTALLDIR)/etc/ld.so.conf;
COMPONENT_INSTALL_POST+=	$(MKDIR) ${DESTDIR}/etc/ld.so.conf.d;

install:	$(CONFIGURE_INSTALL)
