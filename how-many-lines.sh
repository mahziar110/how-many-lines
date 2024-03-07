#!/bin/bash

# Get the total number of insertions, deletions, and total lines changed today in the project using Git
readarray -t lines_changed < <(git log --since="midnight" --numstat --pretty=tformat: | awk '{if ($1 > 0 || $2 > 0) added+=$1; deleted+=$2} END {print added, deleted, added+deleted}')

insertions=${lines_changed[0]}
deletions=${lines_changed[1]}
total_lines_changed=${lines_changed[2]}

echo "Total insertions today: $insertions"
echo "Total deletions today: $deletions"
echo "Total lines changed today: $total_lines_changed"
