
.PHONY: default
default:

.PHONY: install
install:
	make -f mk/help2man-1.49.3.mk
	make -f mk/libffi-3.4.4.mk
	make -f mk/tcl-8.6.13.mk

.PHONY: clean
clean:
	rm -rf build/
	rm -rf modulefiles/
	rm -rf local/
