autojump.vim
============

Integrates [autojump](https://github.com/joelthelion/autojump) with
[vim](http://www.vim.org/), allowing you to open and edit files with ease.

If anyone out there is a hardcore vim hacker, please help me by forking this project and improving it. See the list of necessary enhancements in `./TODO`.

Usage
-----

In Vim, open files as normal. Then when you want to re-open a previously opened
file, just type `:J file_path_fragment`. This will match `file_path_fragment`
against previously opened files, and open the most heavily access match.

Autojump.vim supports completion as well, so feel free to hit tab after `:J` to
see what possibilities exist.

You can also view your jumpstats with the `:JumpStat` command.

Requirements
------------

You *must* have [autojump](https://github.com/joelthelion/autojump) installed
and on your path. If it's not there, this plugin won't work.

Installation
------------

Download `./plugin/autojump.vim` and place it in `~/.vim/plugin/autojump.vim`

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
