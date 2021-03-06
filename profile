#!/bin/sh
#
# ~/.profile
#
# Remember that .profile is a POSIX bourne shell file.  No bash or zsh
# extensions shall ever make its way in here.

# be non-permissive by default
umask 022

# our own scripts, and scripts used by scripting languages
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

# termcap and manpath should not be used, terminfo and mandb are better
unset TERMCAP
unset MANPATH

# we may have some sensitive environment to set
if test -r "$HOME/rc/rc/profile_personal.sh"
then
    source "$HOME/rc/rc/profile_personal.sh"
fi

# some ncurses programs have problems with this (e.g. mutt)
if test 'rxvt-unicode-256color' = "$TERM"
then
    export TERM=rxvt-unicode
fi

# use dir_colors for ls
if test -r "$HOME/.dir_colors"
then
    eval `dircolors --bourne-shell "$HOME/.dir_colors"`
fi

# typical program config
export EDITOR=vim
export LESS='-iMSx4 -FXR'

# useful things
alias 'ls=ls --color=auto'
# removes the python 3 caches
alias 'rmpy=find . -depth -type d -name __pycache__ -exec rm -rf {} \;'
# greps for non-ascii
alias "gnascii=grep -aP '[^\x00-\x7F]'"

# runs a python module from the directory below it, uses __main__.py
runpymod () { (bname=$(basename $(pwd)); cd ..; python -m "$bname" "$@"); };

# Centos, Fedora and RedHat mess up the Vim installation
centos=/etc/centos-release
fedora=/etc/fedora-release
redhat=/etc/redhat-release
if test -r "$centos" -o -r "$redhat" -o -r "$fedora"
then
    alias 'vim=gvim -v'
    export EDITOR='gvim -v'
fi
unset centos
unset fedora
unset redhat

# metasploit (favourite place for the db config)
export MSF_DATABASE_CONFIG=/opt/metasploit/config/database.yml

conda_start () {
    export PATH="/home/grochmal/anaconda3/bin:$PATH"
}

