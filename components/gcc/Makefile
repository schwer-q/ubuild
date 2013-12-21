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

COMPONENT_NAME=		gcc
COMPONENT_VERSION=	4.8.1
COMPONENT_PROJECT_URL=	http://gcc.gnu.org
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2
COMPONENT_ARCHIVE_URL=	http://ftp.gnu.org/gnu/$(COMPONENT_NAME)/$(COMPONENT_SRC)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	md5:3b2386c114cd74185aa3754b58a79304

include		$(WS_MAKE_RULES)/download.mk
include		$(WS_MAKE_RULES)/extract.mk

patch::
	@case `uname -m` in \
		i?86) $(SED) -i 's/^T_CFLAGS =$/& -fomit-frame-pointer/' $(SOURCEDIR)/gcc/Makefile.in;; \
	esac
	$(SED) -i 's/install_to_\$(INSTALL_DEST) //' $(SOURCEDIR)/libiberty/Makefile.in
	$(SED) -i -e '/autogen/d' -e '/check.sh/d' $(SOURCEDIR)/fixinclude/Makefile.in
	$(MV) $(SOURCEDIR)/libmudflap/testsuite/lib/mudflap.c++/pass41-frag.cxx \
		$(SOURCEDIR)/libmudflap/testsuite/lib/mudflap.c++/pass41-frag.cxx.disable

include		$(WS_MAKE_RULES)/configure.mk

BUILDDIR=		$(SOURCEDIR)/../build
CONFIGURE_OPTIONS+=	--libexecdir=/usr/lib
CONFIGURE_OPTIONS+=	--enable-shared
CONFIGURE_OPTIONS+=	--enable-threads=posix
CONFIGURE_OPTIONS+=	--enable-__cxa_atexit
CONFIGURE_OPTIONS+=	--enable-clocale=gnu
CONFIGURE_OPTIONS+=	--enable-languages=c,c++
CONFIGURE_OPTIONS+=	--disable-multilib
CONFIGURE_OPTIONS+=	--disable-bootstrap
CONFIGURE_OPTIONS+=	--disable-install-libiberty
CONFIGURE_OPTIONS+=	--with-system-zlib

build:		$(CONFIGURE_BUILD)

COMPONENT_INSTALL_POST+=	$(SYMLINK) ../usr/bin/cpp $(INSTALLDIR)/lib
COMPONENT_INSTALL_POST+=	$(SYMLINK) gcc $(INSTALLDIR)/usr/bin/cc
#COMPONENT_INSTALL_POST+=	ln -s g++ $(INSTALLDIR)/usr/bin/c++
COMPONENT_INSTALL_POST+=	$(MKDIR) $(INSTALLDIR)/usr/share/gdb/auto-load/usr/lib
COMPONENT_INSTALL_POST+=	$(MV) $(INSTALLDIR)/usr/lib/*gdb.py \
					$(INSTALLDIR)/usr/share/gdb/auto-load/usr/lib

install:	$(CONFIGURE_INSTALL)
