
TOOL := graphviz
VERSION := 8.0.5

# The Graphviz layout programs take descriptions of graphs in a simple text
# language, and make diagrams in several useful formats such as images and SVG
# for web pages, Postscript for inclusion in PDF or other documents; or display
# in an interactive graph browser.

include ${THIS}/tools/mk/common.mk

TAR := ${TOOL}-${VERSION}.tar.gz
SRCDIR := ${OUT}/${TOOL}-${VERSION}

SOURCE := https://gitlab.com/api/v4/projects/4207231/packages/generic/${TOOL}-releases/${VERSION}
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
module-whatis "Graph visualization."
prepend-path CPATH "${PREFIX}/include"
prepend-path LIBRARY_PATH "${PREFIX}/lib"
prepend-path LD_LIBRARY_PATH "${PREFIX}/lib"
endef

${INSTALL}: ${BUILD} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	${RM_REDIRECT}
	cd ${SRCDIR} && make install \
		${REDIRECT}
	chmod a-w -R ${PREFIX}/*
	${WRITE_MODULE}
	date > $@

