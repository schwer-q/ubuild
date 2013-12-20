#!/bin/sh -
# -*- sh-basic-offset 8  -*-

set -e

COMPONENT_NAME="glibc"
COMPONENT_VERSION="2.18"
COMPONENT_PROJECT_URL="http://www.gnu.org/software/libc"
COMPONENT_SRC="${COMPONENT_NAME}-${COMPONENT_VERSION}"
COMPONENT_ARCHIVE="${COMPONENT_SRC}.tar.xz"
COMPONENT_ARCHIVE_URL="http://ftp.gnu.org/gnu/${COMPONENT_NAME}/${COMPONENT_ARCHIVE}"
COMPONENT_ARCHIVE_HASH="md5:c3ab5df043bc95de69f73cb71a3c7bb6"

USE_CONFIGURE="yes"
CONFIGURE_BUILD="${COMPONENT_SRC}/../${COMPONENT_NAME}-build"

prep() {
	sed -i -e 's/static __m128i/inline &/' sysdeps/x86_64/multiarch/strstr.c
}

build() {
	CONFIGURE_PATH="../${COMPONENT_SRC}/configure"
	CONFIGURE_PREFIX="/usr"
	CONFIGURE_OPTIONS="--disable-profile"
	CONFIGURE_OPTIONS="${CONFIGURE_OPTIONS} --enable-kernel=2.6.32"
	CONFIGURE_OPTIONS="${CONFIGURE_OPTIONS} --libexecdir=${CONFIGURE_PREFIX}/lib/glibc"

	make
}

install() {
	touch ${DESTDIR}/etc/ls.so.conf
	make install install_root="${DESTDIR}"
	cp -v ../${COMPONENT_SRC}/sunrpc/rpc/*.h ${DESTDIR}/usr/include/rpc
	cp -v ../${COMPONENT_SRC}/sunrpc/rpcsvc/*.h ${DESTDIR}/usr/include/rpcsvc
	cp -v ../${COMPONENT_SRC}/nis/rpcsvc/*.h ${DESTDIR}/usr/include/rpcsvc
	mkdir -p ${DESTDIR}/usr/lib/locale
	make localedata/install-locales install_root="${DESTDIR}"

	cat > ${DESTDIR}/nsswitch.conf << "EOF"
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

	cat > ${DESTDIR}/etc/ld.so.conf << "EOF"
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

include /etc/ld.so.conf.d/*.conf


EOF
	mkdir -p ${DESTDIR}/etc/ld.so.conf.d
}
