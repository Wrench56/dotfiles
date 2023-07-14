#!/bin/sh

# Test whether scripts are POSIX compliant

# Parameters:
#   $1 - File's path
check_for_bashisms() {
    SHEBANG="$(head -1 "$1" | grep -P "^#!.* || 0")"
    if [ "$SHEBANG" -eq 0 ]
    then
        # No shebang - skip
        return
    else
        # Shebang found
        if [ "$SHEBANG" = "#!/bin/sh" ]
        then
            printf "\033[1mTesting %s... \e[0m" "$1"
            checkbashisms -p -f -n "$1"
            checkshell -o all "$1"
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
                if [ "$(echo "$file" | tail -c 3)" = ".sh" ]
                then
                    check_posix_compliance "$file"
                fi
                if [ "$(echo "$file" | grep -P -o "(?!\/)(?:.(?!\/))+\$" | grep -c "\.")" -eq 0 ]
                then
                    check_posix_compliance "$file"
                fi
            fi
        fi
    done
}

recursive_search "."
