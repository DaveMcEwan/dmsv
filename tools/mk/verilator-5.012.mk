
TOOL := verilator
VERSION := 5.012

# Verilator converts (System)Verilog to a cycle-accurate behavioral model in
# C++ or SystemC. The generated models are cycle-accurate and 2-state; as a
# consequence, the models typically offer higher performance than the more
# widely used event-driven simulators, which can model behavior within the
# clock cycle.

include ${THIS}/tools/mk/common.mk

TAR := v${VERSION}.tar.gz
SRCDIR := ${OUT}/${TOOL}-${VERSION}

SOURCE := https://github.com/verilator/${TOOL}/archive/refs/tags
${FETCH}:
	${RM_REDIRECT}
	curl -v -L --output ${IN}/${TOOL}-${TAR} ${SOURCE}/${TAR} \
		${REDIRECT}
	cd ${OUT} && tar -xvf ${IN}/${TOOL}-${TAR} \
		${REDIRECT}
	date > $@

undefine VERILATOR_ROOT

${BUILD}: ${FETCH}
${BUILD}:
	${RM_REDIRECT}
	#cd ${SRCDIR} && autoconf \
	#	${REDIRECT}
	#cd ${SRCDIR} && ./configure --prefix=${PREFIX} \
	#	${REDIRECT}
	cd ${SRCDIR} && make \
		${REDIRECT}
	date > $@

# <https://modules.readthedocs.io/en/latest/modulefile.html>
define MODULE
#%Module
module-whatis "(System)Verilog to cycle-accurate 2-state C++ compiler."
unsetenv VERILATOR_ROOT
prepend-path PATH "${PREFIX}/bin"
prepend-path MANPATH "${PREFIX}/man"
prepend-path PKG_CONFIG_PATH "${PREFIX}/share/pkgconfig"
endef

${INSTALL}: ${BUILD} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	${RM_REDIRECT}
	cd ${SRCDIR} && make install \
		${REDIRECT}
	chmod a-w -R ${PREFIX}/*
	${WRITE_MODULE}
	date > $@

