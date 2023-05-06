
# Include this after TOOL and VERSION are defined.

default:
.PHONY: default

IN := ${THIS}/tools/build/in
${IN}:
	mkdir -p ${IN}

OUT := ${THIS}/tools/build/out
${OUT}:
	mkdir -p ${OUT}

LOCAL := ${THIS}/tools/local
${LOCAL}:
	mkdir -p ${LOCAL}
PREFIX := ${LOCAL}/${TOOL}-${VERSION}

MODULEFILES := ${THIS}/tools/modulefiles
${MODULEFILES}:
	mkdir -p ${MODULEFILES}
MODULEFILE := ${MODULEFILES}/${TOOL}-${VERSION}

RM_REDIRECT = @rm -f $@.stdout $@.stderr
REDIRECT = >> $@.stdout 2>> $@.stderr

FETCH := ${OUT}/fetch_${TOOL}-${VERSION}
${FETCH}: | ${IN} ${OUT}
fetch: ${FETCH}
.PHONY: fetch

BUILD := ${OUT}/build_${TOOL}-${VERSION}
build: ${BUILD}
.PHONY: build

INSTALL := ${OUT}/install_${TOOL}-${VERSION}
install: ${INSTALL}
.PHONY: install

GNU_SOURCE := https://ftp.gnu.org/gnu
GNU_KEYRING := ${IN}/gnu-keyring.gpg
${GNU_KEYRING}:
	curl -v -L --output ${GNU_KEYRING} ${GNU_SOURCE}/gnu-keyring.gpg

# Convenience variable, used to get newline characters out of the Makefile.
define newline


endef
# NOTE: 2 empty lines above this comment, before `define newline`.

WRITE_MODULE = echo "$(subst ",\",$(subst ${newline},\n,${MODULE}))" > ${MODULEFILE}

