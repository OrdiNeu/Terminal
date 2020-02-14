#!/bin/bash
# Bash aliases

# General use
alias ll='ls -alh --color'                  # Preferred 'ls'
alias l='ls -ah --color'                    # non-list version of the above
alias halp='top -b | head -n 10'            # halp:     What's throttling this machine?
alias rcp='rsync -avP'                      # Rsync cp
alias ..="cd .."                            # Go up one directory
alias ...="cd ../../"                       # Go up two directories
alias .2="cd ../../"                        # Alternate go up two directories
alias .3="cd ../../../"                     # Go up three directories
alias .4="cd ../../../../"                  # Go up four directories
alias -- -="cd -"                           # Go to the previous directory
alias tmux='TERM=xterm-256color tmux'       # Preferred 'tmux' implementation
alias emacs='emacs -nw'                     # Preferred 'emacs' implementation
alias pmine="top -b -n 1 | grep fnguyen"    # pmine:    What's the CPU/MEM/Status of all of my processes on this machine?
alias pt="${HOME}/.local/bin/pytest"        # pt:       Run pytest
alias cln="echo *.e* *.o* \"Y/N\"; read is_ok; if [ $is_ok -eq \"Y\" ]; then rm *.e* *.o*; fi"  # rm *.e* *.o* with confirmation
alias qfind="find . -name "                 # qfind:    Quickly search for file
alias gst="git status"                      # gst: Get git status

# Easy saving/reloading directories
DIR_TMP_FILE=${HOME}/.tmp_dir_chng.txt
alias sv="pwd >${DIR_TMP_FILE}"
alias rl="while read i ; do echo \$i ; cd \$i ; done <${DIR_TMP_FILE}"
