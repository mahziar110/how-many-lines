#!/bin/bash

# Function to get lines changed based on time interval
get_lines_changed() {
    local since_param=""
    case "$1" in
        -d) since_param="midnight";;
        -w) since_param="last week";;
        -m) since_param="last month";;
        -y) since_param="last year";;
        *) echo "Invalid argument. Please use -d, -w, -m, or -y."; exit 1;;
    esac

    readarray -t lines_changed < <(git log --since="$since_param" --numstat --pretty=tformat: | awk '{if ($1 > 0 || $2 > 0) added+=$1; deleted+=$2} END {print added, deleted, added+deleted}')

    insertions=${lines_changed[0]}
    deletions=${lines_changed[1]}
    total_lines_changed=${lines_changed[2]}

    echo "Total insertions: $insertions"
    echo "Total deletions: $deletions"
    echo "Total lines changed: $total_lines_changed"
}

# Check for command-line argument
if [ $# -eq 0 ]; then
    echo "Please provide an argument: -d, -w, -m, or -y."
else
    get_lines_changed $1
fi

