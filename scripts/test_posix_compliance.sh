#!/bin/sh

# Test whether scripts are POSIX compliant

# Parameters:
#   $1 - File's path
#
# Notice:
# Current severity: INFO
check_posix_compliance() {
    SHEBANG="$(head -1 "$1" | grep -P "^#!.* || 0")"
    if [ "$SHEBANG" = "0" ]
    then
        # No shebang - skip
        return
    else
        # Shebang found
        printf "\033[1mTesting %s... \e[0m\n" "$1"
        if ! checkbashisms -p -n "$1"; then return $?; fi
        if ! shellcheck -o all -W 0 --severity=info "$1"; then return $?; fi
    fi
}

# Parameters:
#   $1 - Path
#
# Notice:
# This function fails immediately on error code
recursive_search() {
    for file in "$1"/*
    do
        if [ -d "$file" ]
        then
            # Directory
            recursive_search "$file"
        else
            # Just to make sure (empty dirs can behave interestingly)
            if [ -f "$file" ]
            then
                # Scripts with .sh extension
                if [ "$(echo "$file" | tail -c 3)" = ".sh" ]
                then 
                    if ! check_posix_compliance "$file"; then exit $?; fi
                fi

                # Files without extension
                if [ "$(echo "$file" | grep -P -o "(?!\/)(?:.(?!\/))+\$" | grep -c "\.")" -eq 0 ]
                then
                    if ! check_posix_compliance "$file"; then exit $?; fi
                fi
            fi
        fi
    done
}

# Search the current directory
recursive_search "."
