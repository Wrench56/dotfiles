#!/bin/bash

# Script to symlink every dotfile where it needs to be

# Wrapper

RED="\e[31m"
GREEN="\e[32m"
BOLD="\033[1m"
ENDCOLOR="\e[0m"

wrapper() {
    "${@:2}"
    ret=$?
    if [[ $ret -eq 0 ]]
    then
        printf "${BOLD}[${GREEN} Ok ${ENDCOLOR}${BOLD}] $1${ENDCOLOR}\n"
    else
        printf "${BOLD}[${RED}Fail${ENDCOLOR}${BOLD}] $1${ENDCOLOR}\nError: $ret\n"
        exit $ret
    fi
}


cd ..

wrapper "Make .xinitrc an executable" chmod +x .xinitrc
wrapper "Move .xinitrc to HOME directory" ln -s .xinitrc ~/.xinitrc

cd scripts