
Usage
-----

Before using any Makefiles in this directory, set and export `$THIS` to the
root of this repository:

    cd dmsv/
    export THIS="$PWD"
    cd tools/
    ... Now ready to begin installing tools.

To install the whole recommended set of tools:

    make install

To install a specific tool, use the specific Makefile, e.g:

    make -f mk/help2man-1.49.3.mk install

To completely remove all installed tools:

    make clean

For anything else, read the Makefiles.
Each tool's Makefile should contain notes about the tool's purpose.


Notes
-----

- Recipies in all Makefiles should be POSIX-compliant, even though the
  Makefiles themselves may depend on non-POSIX features of GNU Make.
- Tested using curl 7.81.0 on Linux Mint 21.1 (2023).
- Everything in `tools/build/in` is downloaded from elsewhere, unmodified.
  Results of any processing or modifications go to `tools/build/out`.
- Installed binary goes to `tools/local/<tool>-<version>` and the corresponding
  modulefile goes to `tools/modulefiles/<tool>-<version>`.
- Meta-module files are hand-crafted, not written by Makefiles.

