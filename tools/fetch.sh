#!/bin/sh -
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

set -e

do_fetch() {
	WGET=/usr/bin/wget
	WGET_ARGS="--no-check-certificate -c -O"

	$WGET $WGET_ARGS ${WS_DISTFILES}/$COMPONENT_ARCHIVE $COMPONENT_ARCHIVE_URL
}

do_compare() {
	ALGO=$(echo $COMPONENT_ARCHIVE_HASH | cut -d':' -f1)
	ESUM=$(echo $COMPONENT_ARCHIVE_HASH | cut -d':' -f2)

	case "$ALGO" in
		'md5') CMD=$MD5SUM;;
		'sha256') CMD=$SHA256;;
		*) echo 'Unkwown hash.'; exit 2;;
	esac
	SUM=`$CMD ${WS_DISTFILES}/$COMPONENT_ARCHIVE | cut -d' ' -f1`
	test "$ESUM" = "$SUM" && return 0
	echo "${COMPONENT_ARCHIVE}: bad $ALGO sum."
        $RM ${WS_DISTFILES}/$COMPONENT_ARCHIVE
	return 1
}

COMPONENT_ARCHIVE=$1
COMPONENT_ARCHIVE_URL=$2
COMPONENT_ARCHIVE_HASH=$3

test -d $WS_DISTFILES || $MKDIR $WS_DISTFILES
if test -e ${WS_DISTFILES}/$COMPONENT_ARCHIVE; then
	do_compare && exit
fi

TRY=5
while test "$TRY" -gt 0; do
	do_fetch
	do_compare && exit 0
	TRY=$(($TRY - 1))
done
exit 1
