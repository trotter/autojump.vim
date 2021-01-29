autojump.vim
============

Integrates [autojump](https://github.com/joelthelion/autojump) with
[vim](http://www.vim.org/), allowing you to open and edit files with ease.

If anyone out there is a hardcore vim hacker, please help me by forking this
project and improving it. See the list of necessary enhancements in `./TODO`.

Usage
-----

`:J` replaces `:e` for most (maybe all) cases. When opening a file that has
previously been opened `:J file_path_fragment` will open the most frequently
used file that matches `file_path_fragment`. `:J` maintains two lists of
possible matches. First, it will look for files in the current working
directory and its subdirs. If nothing is found there, then it will search
through a global jump list for a match. If that too fails, it will fall back to
working like the normal `:e` command.

Autojump.vim supports completion as well, so feel free to hit tab after `:J` to
see what possibilities exist.

You can also view your jumpstats with the `:JumpStat` command.

If you're on the command line and not yet in vim, I've included a `jvim` bash
function that you can incorporate into your .profile or .bashrc (or whatever
you use). Use it in the same way you use `:J`, though it currently only
supports global matches.

If you're using NERDTree you can set `g:autojump_open_command` to `NERDTree` to
toggle NERDTree on autojump target.

Requirements
------------

You *must* have [autojump](https://github.com/joelthelion/autojump) installed
and on your path. If it's not there, this plugin won't work.

Installation
------------

Download `./plugin/autojump.vim` and place it in `~/.vim/plugin/autojump.vim`.

Alternately, you can pull down the contents of this repo and run
`./bin/install.sh`. It won't actually _do_ anything, but it will guide you
through the process.

At some point, I (or someone else) will show you how to use tpope's pathogen.
It's better than dropping things in ~/.vim/plugin.

Author
------

Trotter Cashion <cashion@gmail.com>

Thanks To
---------

Joel Schaerer for writing autojump in the first place. If you're not using it
instead of `cd`, you're an idiot.

License
-------

Currently under MIT, but will move to GPL if I decided to incorporate autojump
directly into the project.
