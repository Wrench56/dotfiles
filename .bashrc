#
# ~/.bashrc
#

# Default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Set history file & size
export HISTFILE=~/.cache/bash/history
HISTSIZE=10000

source ~/.local/aliases
