#!/bin/bash

# Script to symlink every dotfile where it needs to be

# Wrapper

RED="\e[31m"
GREEN="\e[32m"
BOLD="\033[1m"
ENDCOLOR="\e[0m"

wrapper() {
    output=$(${@:2} 2>&1)
    if [[ $? -eq 0 ]]
    then
        printf "${BOLD}[${GREEN} Ok ${ENDCOLOR}${BOLD}] $1${ENDCOLOR}\n"
    else
        printf "${BOLD}[${RED}Fail${ENDCOLOR}${BOLD}] $1${ENDCOLOR}\n       ${BOLD}${RED}Error${ENDCOLOR} $ret\n"
    fi
}


cd ..

wrapper "Make .xinitrc an executable" chmod +x .xinitrc
wrapper "Move .xinitrc to HOME directory" ln -s .xinitrc ~/.xinitrc

cd scripts