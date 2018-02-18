if exists("g:loaded_psspmake_plugin")
	finish
endif
let g:loaded_psspmake_plugin = 1
set makeprg=~/.vim/plugged/psspmake/make.sh\ %\ $*
nnoremap <F4> :make!<cr>
nnoremap <F3> :make! run<cr>

