
TOOL := svlint
VERSION := 0.7.2

# Svlint is a SystemVerilog (IEEE Std 1800-2017) linter, written in Rust.
# Svlint is also integrated text editors via Svls.

include ${THIS}/tools/mk/common.mk

# Executable and PDF come from pre-built ZIP, but configuration files (TOML)
# and wrapper scripts come from source-code TAR.
ZIP := ${TOOL}-v${VERSION}-x86_64-lnx.zip
TAR := v${VERSION}.tar.gz
SRCDIR := ${OUT}/${TOOL}-${VERSION}

ZIP_SOURCE := https://github.com/dalance/${TOOL}/releases/download/v${VERSION}
TAR_SOURCE := https://github.com/dalance/svlint/archive/refs/tags
${FETCH}:
	${RM_REDIRECT}
	curl -v -L --output ${IN}/${ZIP} ${ZIP_SOURCE}/${ZIP} \
		${REDIRECT}
	unzip -u ${IN}/${ZIP} -d ${SRCDIR} \
		${REDIRECT}
	curl -v -L --output ${IN}/${TOOL}-${TAR} ${TAR_SOURCE}/${TAR} \
		${REDIRECT}
	cd ${OUT} && tar -xvf ${IN}/${TOOL}-${TAR} \
		${REDIRECT}
	date > $@

# <https://modules.readthedocs.io/en/latest/modulefile.html>
define MODULE
#%Module
module-whatis "SystemVerilog linter compliant with IEEE Std 1800-2017."
prepend-path PATH "${PREFIX}/bin"
endef

${INSTALL}: ${FETCH} | ${LOCAL} ${MODULEFILES}
${INSTALL}:
	mkdir -p ${PREFIX}/bin
	mkdir -p ${PREFIX}/doc
	cp ${SRCDIR}/rulesets/*.toml ${PREFIX}/bin/
	find ${SRCDIR}/rulesets/ -type f -perm -u=x -exec \
		cp {} ${PREFIX}/bin \;
	cp ${SRCDIR}/${TOOL} ${PREFIX}/bin/
	cp ${SRCDIR}/${TOOL}_MANUAL_v${VERSION}.pdf ${PREFIX}/doc
	${WRITE_MODULE}
	date > $@

