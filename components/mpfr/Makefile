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

COMPONENT_NAME=		mpfr
COMPONENT_VERSION=	3.1.2
COMPONENT_PROJECT_URL=	http://www.mpfr.org
COMPONENT_SRC=		$(COMPONENT_NAME)-$(COMPONENT_VERSION)
COMPONENT_ARCHIVE=	$(COMPONENT_SRC).tar.xz
COMPONENT_ARCHIVE_URL=	http://www.mpfr.org/$(COMPONENT_SRC)/$(COMPONENT_ARCHIVE)
COMPONENT_ARCHIVE_HASH=	md5:e3d203d188b8fe60bb6578dd3152e05c
COMPONENT_DEPENDS+=	glibc
COMPONENT_DEPENDS+=	gmp

include		$(WS_MAKE_RULES)/download.mk
include		$(WS_MAKE_RULES)/extract.mk
include		$(WS_MAKE_RULES)/configure.mk

CONFIGURE_OPTIONS=	--enable-thread-safe
CONFIGURE_OPTIONS=	--docdir=/usr/share/doc/$(COMPONENT_SRC)
COMPONENT_BUILD_TARGETS=	all html

build:		$(CONFIGURE_BUILD)

COMPONENT_INSTALL_TARGETS= install install-html

install:	$(CONFIGURE_INSTALL)
