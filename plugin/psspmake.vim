if exists("g:loaded_psspmake_plugin")
	finish
endif
let g:loaded_psspmake_plugin = 1

let g:pssp_std = ""
let g:pssp_libs = ""

function! psspmake#SetMakePrg()
	set makeprg=~/.vim/plugged/psspmake/make.sh\ %\ $*
endfunction

function psspmake#GetMakeCmd()
	return 'make! STD=' . g:pssp_std . " LDLIBS+=\"" . g:pssp_libs . "\""
endfunction

function! psspmake#MakePrg()
	call psspmake#SetMakePrg()
	let l:exec_cmd = psspmake#GetMakeCmd()
	exec l:exec_cmd
endfunction

function psspmake#RunPrg()
	call psspmake#SetMakePrg()
	let l:exec_cmd = psspmake#GetMakeCmd() . ' run'
	exec l:exec_cmd
endfunction

nnoremap <F4> :w<cr>:call psspmake#MakePrg()<cr>
nnoremap <F3> :w<cr>:call psspmake#RunPrg()<cr>

