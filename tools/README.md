
Installing Tools
----------------

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


Environment Modules
-------------------

Once the tools are installed, make them accessible by adding something like
this to your shell configuration, e.g. `~/.bashrc`:

```sh
module use --append $THIS/tools/modulefiles
module load dmsv
```


Notes
-----

- Prefer pre-built tools where available, otherwise build from source.
- Recipies in all Makefiles should be POSIX-compliant, even though the
  Makefiles themselves may depend on non-POSIX features of GNU Make.
- Tested using curl 7.81.0 on Linux Mint 21.1 (2023).
  - gcc 11.3.0 (present in base system)
  - `sudo apt install g++`
  - `sudo apt install libreadline-dev`
  - `sudo apt install zlib1g-dev`
  - `sudo apt install autoconf`
  - `sudo apt install libfl-dev`
  - `sudo apt install perl-doc`
- Everything in `tools/build/in` is downloaded from elsewhere, unmodified.
  Results of any processing or modifications go to `tools/build/out`.
- Installed binary goes to `tools/local/<tool>-<version>` and the corresponding
  modulefile goes to `tools/modulefiles/<tool>-<version>`.
- Meta-module files are hand-crafted, not written by Makefiles.

