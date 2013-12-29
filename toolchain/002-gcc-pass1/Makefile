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
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.bz2

include		$(WS_MAKE_RULES)/prep.mk

patch::
	for file in \
		$$(find $(SOURCEDIR)/gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h); do \
		$(CP) -u $$file $${file}.orig ; \
		$(SED)  -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
			-e 's@/usr@/tools@g' $${file}.orig > $$file ; \
		echo ' \
#undef STANDARD_STARTFILE_PREFIX_1 \
#undef STANDARD_STARTFILE_PREFIX_2 \
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/" \
#define STANDARD_STARTFILE_PREFIX_2 "" \
' >> $$file ; \
		$(TOUCH) $${file}.orig ; \
	done
	$(SED) -i '/k prot/agcc_cv_libc_provides_ssp=yes' $(SOURCEDIR)/gcc/configure

include		$(WS_MAKE_RULES)/configure.mk

BUILDDIR=		$(SOURCEDIR)/../build
CONFIGURE_PREFIX=	/tools
CONFIGURE_OPTIONS+=	--target=$(LFS_TGT)
CONFIGURE_OPTIONS+=	--with-sysroot=$(LFS)
CONFIGURE_OPTIONS+=	--with-newlib
CONFIGURE_OPTIONS+=	--without-headers
CONFIGURE_OPTIONS+=	--with-local-prefix=/tools
CONFIGURE_OPTIONS+=	--with-native-system-header-dir=/tools/include
CONFIGURE_OPTIONS+=	--disable-nls
CONFIGURE_OPTIONS+=	--disable-shared
CONFIGURE_OPTIONS+=	--disable-multilib
CONFIGURE_OPTIONS+=	--disable-decimal-float
CONFIGURE_OPTIONS+=	--disable-threads
CONFIGURE_OPTIONS+=	--disable-libatomic
CONFIGURE_OPTIONS+=	--disable-libgomp
CONFIGURE_OPTIONS+=	--disable-libitm
CONFIGURE_OPTIONS+=	--disable-libmudflap
CONFIGURE_OPTIONS+=	--disable-libquadmath
CONFIGURE_OPTIONS+=	--disable-libsanitizer
CONFIGURE_OPTIONS+=	--disable-libssp
CONFIGURE_OPTIONS+=	--disable-libstdc++-v3
CONFIGURE_OPTIONS+=	--enable-languages=c,c++
CONFIGURE_OPTIONS+=	--with-mpfr-include=$(SOURCEDIR)/mpfr/src
CONFIGURE_OPTIONS+=	--with-mpfr-lib=$(BUILDDIR)/mpfr/src/.libs

build:		$(CONFIGURE_BUILD)

COMPONENT_INSTALL_POST=	$(SYMLINK) libgcc.a `$(LFS_TGT)-gcc -print-libgcc-file-name | sed 's/libgcc/&_eh/'`

install:	$(CONFIGURE_INSTALL)
