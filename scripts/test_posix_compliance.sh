#!/bin/sh

# Test whether scripts are POSIX compliant

# Parameters:
#   $1 - File's path
check_posix_compliance() {
    SHEBANG="$(head -1 "$1" | grep -P "^#!.* || 0")"
    if [ "$SHEBANG" = "0" ]
    then
        # No shebang - skip
        return
    else
        # Shebang found
        if [ "$SHEBANG" = "#!/bin/sh" ]
        then
            printf "\033[1mTesting %s... \e[0m\n" "$1"
            checkbashisms -p -f -n "$1"
            shellcheck -o all -W 0 "$1"
        fi
    fi
}

# Parameters:
#   $1 - Path
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
                    check_posix_compliance "$file"
                fi

                # Files without extension
                if [ "$(echo "$file" | grep -P -o "(?!\/)(?:.(?!\/))+\$" | grep -c "\.")" -eq 0 ]
                then
                    check_posix_compliance "$file"
                fi
            fi
        fi
    done
}

# Search the current directory
recursive_search "."
