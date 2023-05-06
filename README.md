
dmsv
====

WIP

Structure
---------

```
$THIS/
  tools/              Infrastructure for FOSS dependencies.
    *build/           Working area for building FOSS tools.
      in/             Fetched repos/packages.
      out/            Compiled repos/packages.
    *local/           Installation prefix for built tools.
    *modulefiles/     Modulefiles for setting up tools and env.
      dmsv            Meta-module including all recommended FOSS tools.
      pandoc          Meta-module including single recommended FOSS tool.
      pandoc-3.1.2    Module for specific version of FOSS tool.
      ...
    mk/               Individual makefiles for each version of each FOSS tool.
      ...
    Makefile          All tools installed with this, from this directory.

*: Not under version control
```


Notes
-----

- `export THIS="$PWD"`
- Scripts should be POSIX compliant, except Makefiles which may depend on
  non-standard features of GNU Make.
