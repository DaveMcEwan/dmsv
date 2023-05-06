
TOOL := help2man
VERSION := 1.49.3

# help2man is a GNU utility for producing simple manpages from the output of
# other utilities given the --help and --version flags.
# It is included in this repo because it's a build dependency of Verilator.
# The installed executable is a single Perl script.

include ${THIS}/tools/mk/common.mk

TAR := ${TOOL}-${VERSION}.tar.xz
SRCDIR := ${OUT}/${TOOL}-${VERSION}

${FETCH}: ${GNU_KEYRING}
${FETCH}:
	${RM_REDIRECT}
	curl -v -L --output ${IN}/${TAR}.sig ${GNU_SOURCE}/${TOOL}/${TAR}.sig \
		${REDIRECT}
	curl -v -L --output ${IN}/${TAR}     ${GNU_SOURCE}/${TOOL}/${TAR} \
		${REDIRECT}
	gpg --verify --keyring ${GNU_KEYRING} ${IN}/${TAR}.sig \
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
module-whatis "Produce manpages from the output of --help and --version."
prepend-path PATH "${PREFIX}/bin"
endef

${INSTALL}: ${BUILD} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	${RM_REDIRECT}
	cd ${SRCDIR} && make install \
		${REDIRECT}
	chmod a-w -R ${PREFIX}/*
	${WRITE_MODULE}
	date > $@

