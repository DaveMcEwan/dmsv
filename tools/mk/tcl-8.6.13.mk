
TOOL := tcl
VERSION := 8.6.13

# Tcl (Tool Command Language) is a very powerful but easy to learn dynamic
# programming language, suitable for a very wide range of uses, including web
# and desktop applications, networking, administration, testing and many more.
# It is included in this repo because it's a build and runtime dependency of
# Yosys (when built with `ENABLE_TCL=1`, the default).
# The installation consists of an interpreter shell `bin/tclsh8.6`, C headers,
# and shared object for dynamic linking `lib/libtcl8.6.so`.

include ${THIS}/tools/mk/common.mk

TAR := ${TOOL}${VERSION}-src.tar.gz
SRCDIR := ${OUT}/${TOOL}${VERSION}/unix

SOURCE := http://prdownloads.sourceforge.net/${TOOL}
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
module-whatis "Tool Command Language shell and libraries."
prepend-path PATH "${PREFIX}/bin"
prepend-path CPATH "${PREFIX}/include"
prepend-path LIBRARY_PATH "${PREFIX}/lib"
prepend-path LD_LIBRARY_PATH "${PREFIX}/lib"
endef

${INSTALL}: ${BUILD} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	${RM_REDIRECT}
	cd ${SRCDIR} && make install \
		${REDIRECT}
	${WRITE_MODULE}
	date > $@

