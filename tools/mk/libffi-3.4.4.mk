
TOOL := libffi
VERSION := 3.4.4

# The libffi library provides a portable, high level programming interface to
# various calling conventions.
# This allows a programmer to call any function specified by a call interface
# description at run time.
# It is included in this repo because it's a build and runtime dependency of
# Yosys (when built with `ENABLE_PLUGINS=1`, the default).
# The installation consists of C headers, a pkg-config file, an archive for
# static linking `lib64/libffi.a`, and shared objects for dynamic linking
# `lib64/libffi.so*`.

include ${THIS}/tools/mk/common.mk

TAR := ${TOOL}-${VERSION}.tar.gz
SRCDIR := ${OUT}/${TOOL}-${VERSION}

SOURCE := https://github.com/${TOOL}/${TOOL}/releases/download/v${VERSION}
${FETCH}:
	${RM_REDIRECT}
	curl -v -L --output ${IN}/${TAR} ${SOURCE}/${TAR} \
		${REDIRECT}
	cd ${OUT} && tar -xvf ${IN}/${TAR} \
		${REDIRECT}
	date > $@

${BUILD}: ${FETCH}
${BUILD}:
	${RM_REDIRECT}
	cd ${SRCDIR} && ./configure --prefix=${PREFIX} \
		${REDIRECT}
	cd ${SRCDIR} && make \
		${REDIRECT}
	date > $@

# <https://modules.readthedocs.io/en/latest/modulefile.html>
define MODULE
#%Module
module-whatis "Foreign Function Interface library."
prepend-path CPATH "${PREFIX}/include"
prepend-path LIBRARY_PATH "${PREFIX}/lib64"
prepend-path LD_LIBRARY_PATH "${PREFIX}/lib64"
endef

${INSTALL}: ${BUILD} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	${RM_REDIRECT}
	cd ${SRCDIR} && make install \
		${REDIRECT}
	${WRITE_MODULE}
	date > $@

