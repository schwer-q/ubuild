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

CONFIGURE_BUILD=	_build
CONFIGURE_INSTALL=	_install
CONFIGURE_SHELL=	$(SH)
CONFIGURE_SCRIPT=	$(SOURCEDIR)/configure
CONFIGURE_PREFIX=	/usr
CONFIGURE_OPTIONS+=	--prefix=$(CONFIGURE_PREFIX)

COMPONENT_INSTALL_ARGS+=	DESTDIR=$(DESTDIR)
COMPONENT_INSTALL_TARGETS+=	install

configure:		prep $(WORKDIR)/configured
$(WORKDIR)/configured:	
	$(MKDIR) $(BUILDDIR)
	(cd $(BUILDDIR); $(ENV) $(CONFIGURE_ENV) $(CONFIGURE_SHELL) \
		$(CONFIGURE_SCRIPT) $(CONFIGURE_OPTIONS))
	@$(TOUCH) $@

_build:			configure $(WORKDIR)/built
$(WORKDIR)/built:		
	$(COMPONENT_BUILD_PRE)
	(cd $(BUILDDIR); $(ENV) $(COMPONENT_BUILD_ENV) \
		$(MAKE) $(COMPONENT_BUILD_ARGS) $(COMPONENT_BUILD_TARGETS))
	$(COMPONENT_BUILD_POST)
	@$(TOUCH) $@

_install:		_build $(WORKDIR)/installed
$(WORKDIR)/installed:	
	$(COMPONENT_INSTALL_PRE)
	(cd $(BUILDDIR); $(ENV) $(COMPONENT_INSTALL_ENV) \
		$(MAKE) $(COMPONENT_INSTALL_ARGS) $(COMPONENT_INSTALL_TARGETS))
	$(COMPONENT_INSTALL_POST)
	@$(TOUCH) $@

clean::
	@$(RMDIR) $(BUILDDIR)
