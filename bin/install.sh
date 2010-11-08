#!/bin/bash

##
## Author: Trotter Cashion
## Installs autojump.vim on your system.
##
## Usage: ./bin/install.sh
##

echo 'This install file does nothing automatically, yet'
echo 'So follow these instructions...'
echo ''
echo 'First copy ./autoload/autojump.vim to ~/.vim/autoload/autojump.vim'
echo ''
echo 'If you want support for the jvim terminal command,'
echo 'add the following line to your bash profile:'
echo '  function jvim { file="$(AUTOJUMP_DATA_DIR=~/.vim autojump $@)"; if [ -n "$file" ]; then vim "$file"; fi }'
echo ''
echo 'Yay! You're done'
