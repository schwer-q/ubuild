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

FETCH=		$(WS_TOOLS)/download.py
UNPACK=		$(WS_TOOLS)/extract.py
PATCHER=	$(WS_TOOLS)/patch.py

prep::		download unpack patch

download::	$(PROGRESSDIR)/$(COMPONENT_ARCHIVE).downloaded
$(PROGRESSDIR)/$(COMPONENT_ARCHIVE).downloaded:
	@$(FETCH) --dest $(WS_DISTFILES)/$(COMPONENT_ARCHIVE) \
		--url $(COMPONENT_ARCHIVE_URL) \
		--hash $(COMPONENT_ARCHIVE_HASH) \
		$(VERBOSE)
	@$(TOUCH) $@

unpack::	$(PROGRESSDIR)/$(COMPONENT_ARCHIVE).unpacked
$(PROGRESSDIR)/$(COMPONENT_ARCHIVE).unpacked:
	@$(UNPACK) --archive $(WS_DISTFILES)/$(COMPONENT_ARCHIVE) \
		--workdir $(COMPONENT_DIR) \
		$(VERBOSE)
	@$(TOUCH) $@

patch::		$(PROGRESSDIR)/patched
	@$(PATCHER) --patch-dir $(COMPONENT_DIR)/patch \
		--srcdir $(SOURCEDIR) \
		$(VERBOSE)

clean::
	@echo "Cleanning..."
	@$(RMDIR) $(DESTDIR)
	@$(RMDIR) $(PROGRESSDIR)
	@$(RMDIR) $(SOURCEDIR)
