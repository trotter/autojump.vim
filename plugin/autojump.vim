" autojump.vim - Easy file navigation
" Maintainer: Trotter Cashion <cashion@gmail.com>
" Version:    0.2

" Install in ~/.vim/autoload

if exists("g:loaded_autojump") || &cp
  finish
endif
let g:loaded_autojump = 1

" Stores an opened buffer in autojumps history
function! autojump#store_file(path)
  silent! exec '!AUTOJUMP_DATA_DIR=~/.vim autojump -a '.a:path
endfunction

" Show the current jumpstats
function! autojump#jumpstat()
  exec '!AUTOJUMP_DATA_DIR=~/.vim autojump --stat'
endfunction

function! autojump#completion(ArgLead, CmdLine, CurorPos)
  let paths = system('AUTOJUMP_DATA_DIR=~/.vim autojump --completion '.a:ArgLead)
  if paths == ""
    return split(globpath(&path, a:ArgLead."*"), "\n")
  endif
  return split(paths, "\n")
endfunction

function! autojump#complete(fragment)
  return system('AUTOJUMP_DATA_DIR=~/.vim autojump '.a:fragment)
endfunction

function! autojump#jump(fragment)
  let path = autojump#complete(a:fragment)
  exec 'edit '.path
endfunction

augroup autojump
  autocmd!
  autocmd BufNewFile,BufRead,BufWrite * call autojump#store_file('<amatch>')
augroup END

command! JumpStat :call autojump#jumpstat()
command! -nargs=1 -complete=customlist,autojump#completion J :call autojump#jump(<f-args>)
