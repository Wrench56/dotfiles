#
# ~/.bashrc
#

# Default
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

# Custom
alias reboot='sudo chvt 1 && sudo reboot'
alias shutdown='sudo chvt 1 && sudo shutdown -a now'

# Add gitl command (returns how many lines of code you have in a git repository)
alias gitl='git ls-files | xargs wc -l'

alias ls='exa --icons'
alias ll='ls -ll'
alias la='ll -a'
alias l='ls -D'