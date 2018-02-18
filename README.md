# psspmake

It plugin allows to compile c/cpp one file if in current working directory does not exist any Makefile. If exists then that Makefile is used to start compilation.

To compile c/cpp source file opened in VIM, press F4.
To run compiled file, press F3.

Default standard for C is c11. Default standard for C++ is c++11. To change standard ie. to c89, call:
```
let g:pssp_std="c89"
```
To add libraries for linking, ie. librt and libm, call:
```
let g:pssp_libs="-lrt -lm"
```
