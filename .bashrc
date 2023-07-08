#
# ~/.bashrc
#

# Default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

source ~/.local/aliases
