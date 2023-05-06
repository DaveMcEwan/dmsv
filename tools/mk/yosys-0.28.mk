
TOOL := yosys
VERSION := 0.28

# Yosys is a program that synthesizes RTL to gate-level logic.
# Currently supports a subset of SystemVerilog, but is missing support for
# notable language features such as multi-dimensional arrays.

include ${THIS}/tools/mk/common.mk

TAR := ${TOOL}-${VERSION}.tar.gz
SRCDIR := ${OUT}/${TOOL}-${TOOL}-${VERSION}

SOURCE := https://github.com/YosysHQ/${TOOL}/archive/refs/tags
${FETCH}:
	${RM_REDIRECT}
	curl -v -L --output ${IN}/${TAR} ${SOURCE}/${TAR} \
		${REDIRECT}
	cd ${OUT} && tar -xvf ${IN}/${TAR} \
		${REDIRECT}
	date > $@

LIBFFI := libffi-3.4.4
TCL := tcl-8.6.13

CPATH := ${THIS}/tools/local/${TCL}/include:${CPATH}
CPATH := ${THIS}/tools/local/${LIBFFI}/include:${CPATH}
export CPATH
LIBRARY_PATH := ${THIS}/tools/local/${TCL}/lib:${LIBRARY_PATH}
LIBRARY_PATH := ${THIS}/tools/local/${LIBFFI}/lib:${LIBRARY_PATH}
export LIBRARY_PATH
LD_LIBRARY_PATH := ${THIS}/tools/local/${TCL}/lib:${LD_LIBRARY_PATH}
LD_LIBRARY_PATH := ${THIS}/tools/local/${LIBFFI}/lib:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH

BUILD_FLAGS := PREFIX=${PREFIX}
BUILD_FLAGS += TCL_INCLUDE=${THIS}/tools/local/${TCL}/include

${BUILD}: ${FETCH}
${BUILD}: ${THIS}/tools/build/out/install_${LIBFFI}
${BUILD}: ${THIS}/tools/build/out/install_${TCL}
${BUILD}:
	${RM_REDIRECT}
	echo $$CPATH
	echo $$LIBRARY_PATH
	echo $$LD_LIBRARY_PATH
	cd ${SRCDIR} && make config-gcc \
		${REDIRECT}
	cd ${SRCDIR} && make ${BUILD_FLAGS} \
		${REDIRECT}
	date > $@

# <https://modules.readthedocs.io/en/latest/modulefile.html>
define MODULE
#%Module
module-whatis "RTL synthesizer and formal prover."
prepend-path PATH "${PREFIX}/bin"
endef

${INSTALL}: ${BUILD} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	${RM_REDIRECT}
	cd ${SRCDIR} && make install ${BUILD_FLAGS} \
		${REDIRECT}
	chmod a-w -R ${PREFIX}/*
	${WRITE_MODULE}
	date > $@

