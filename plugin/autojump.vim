" autojump.vim - Easy file navigation
" Maintainer: Trotter Cashion <cashion@gmail.com>
" Version:    0.3.2

" Install in ~/.vim/autoload

if exists("g:loaded_autojump") || &cp
  finish
endif
let g:loaded_autojump = 1

let has_autojump=system("which autojump")
if has_autojump == ""
  echo "It seems you're missing autojump (https://github.com/joelthelion/autojump)"
  echo "autojump.vim won't work without it"
  echo "Sad Panda"
  finish
end

" The root directory in which we will store all autojump files
let s:data_dir=expand("~/.autojump.vim")
let s:global_dir=expand(s:data_dir.'/global')
let s:project_dir=expand(s:data_dir.'/projects/'.getcwd())

" Stores an opened buffer in autojumps history
function! autojump#store_file(path)
  silent! exec '!'.autojump#autojump_cmd(s:project_dir, '-a "'.a:path.'"')
  silent! exec '!'.autojump#autojump_cmd(s:global_dir, '-a "'.a:path.'"')
endfunction

" Show the current jumpstats
" Currently only shows global stats
function! autojump#jumpstat()
  exec '!'.autojump#autojump_cmd(s:global_dir, '--stat')
endfunction

function! autojump#completion_for(dir, ArgLead, CmdLine, CursorPos)
  let paths = system(autojump#autojump_cmd(a:dir, '--completion "'.a:ArgLead.'"'))
  return split(paths, "\n")
endfunction

function! autojump#completion(ArgLead, CmdLine, CursorPos)
  " Any ideas for cleaning up this duplication?
  " Project completion
  let paths = autojump#completion_for(s:project_dir, a:ArgLead, a:CmdLine, a:CursorPos)
  if paths != []
    return paths
  endif

  " Global completion
  let paths = autojump#completion_for(s:global_dir, a:ArgLead, a:CmdLine, a:CursorPos)
  if paths != []
    return paths
  endif

  " Fallback to normal file completion
  return autojump#fallback_completion_for(a:ArgLead, a:CmdLine, a:CursorPos)
endfunction

function! autojump#fallback_completion_for(ArgLead, CmdLine, CursorPos)
  let matches = split(globpath(",", a:ArgLead."*"), "\n")
  return map(matches, 'isdirectory(v:val) ? v:val."/" : v:val')
endfunction

function! autojump#complete(fragment)
  let path = system(autojump#autojump_cmd(s:project_dir, '"'.a:fragment.'"'))
  if path != ""
    return path
  end

  let path = system(autojump#autojump_cmd(s:global_dir, '"'.a:fragment.'"'))
  if path != ""
    return path
  end

  return a:fragment
endfunction

function! autojump#jump(fragment, type)
  let path = autojump#complete(a:fragment)
  if a:type == 'h'
    exec 'sp '.path
  elseif a:type == 'v'
    exec 'vs '.path
  else
    exec 'edit '.path
  endif
endfunction

function! autojump#create_dir(dir)
  let existing_dir = finddir(a:dir)
  if existing_dir == ""
    silent! exec '!mkdir -p "'.a:dir.'"'
  endif
endfunction

function! autojump#create_data_dir()
  call autojump#create_dir(s:global_dir)
  call autojump#create_dir(s:project_dir)
endfunction

function! autojump#autojump_cmd(data_dir, cmd)
  return 'AUTOJUMP_DATA_DIR="'.a:data_dir.'" autojump '.a:cmd
endfunction

augroup autojump
  autocmd!
  autocmd BufNewFile,BufRead,BufWritePost * call autojump#store_file('<amatch>')
augroup END

" JumpStat will list which files are the most used
" usage: JumpStat
command! JumpStat :call autojump#jumpstat()

" J jumps you to a file
" usage: J vi  " would possibly open ~/.vimrc
command! -nargs=1 -complete=customlist,autojump#completion J :call autojump#jump(<f-args>, 'J')
command! -nargs=1 -complete=customlist,autojump#completion Jh :call autojump#jump(<f-args>, 'h')
command! -nargs=1 -complete=customlist,autojump#completion Jv :call autojump#jump(<f-args>, 'v')

" Go ahead and create the data directory
call autojump#create_data_dir()
