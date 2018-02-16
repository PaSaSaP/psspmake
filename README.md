# psspmake

For example, You can put something like this into Your *.vimrc*:
```
set makeprg=/home/pasasap/psspmake/make.sh\ %\ $*
nnoremap <F4> :make!<cr>
```
For now, You should be able to compile single files from VIM using F4 if Makefile does not exist in current working directory. If it exists (ie. project directory) then this Makefile will be used for make.
