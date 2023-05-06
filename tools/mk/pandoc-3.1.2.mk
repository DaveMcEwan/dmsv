
TOOL := pandoc
VERSION := 3.1.2

# Pandoc is a Haskell library for converting from one markup format to another,
# and a command-line tool that uses this library.
# Pandoc can convert between numerous markup and word processing formats,
# including, but not limited to, various flavors of Markdown, HTML, LaTeX and
# Word docx.

include ${THIS}/tools/mk/common.mk

TAR := ${TOOL}-${VERSION}-linux-amd64.tar.gz
SRCDIR := ${OUT}/${TOOL}-${VERSION}

SOURCE := https://github.com/jgm/${TOOL}/releases/download/${VERSION}
${FETCH}:
	${RM_REDIRECT}
	curl -v -L --output ${IN}/${TAR} ${SOURCE}/${TAR} \
		${REDIRECT}
	cd ${OUT} && tar -xvf ${IN}/${TAR} \
		${REDIRECT}
	date > $@

# <https://modules.readthedocs.io/en/latest/modulefile.html>
define MODULE
#%Module
module-whatis "A universal document converter."
prepend-path PATH "${PREFIX}/bin"
endef

${INSTALL}: ${FETCH} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	cp -r ${SRCDIR} ${PREFIX}
	${WRITE_MODULE}
	date > $@

