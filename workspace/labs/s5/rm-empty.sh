#!/bin/bash

if [ -z "$1" ]; then
    echo "Error: please provide the project name."
    echo "Usage: ./rm-empty.sh <project_name>"
    echo "Or use: ./rm-empty.sh --all"
    exit 1
fi

if [ "$1" = "--all" ]; then
    find prj -type f \( -name "empty" -o -name ".empty" \) -delete
    echo "All placeholder files removed from prj/"
    exit 0
fi

PRJ_NAME="$1"
BASE_DIR="prj/$PRJ_NAME"

if [ ! -d "$BASE_DIR" ]; then
    echo "Error: project '$PRJ_NAME' does not exist."
    exit 1
fi

find "$BASE_DIR" -type f \( -name "empty" -o -name ".empty" \) -delete
echo "Placeholder files removed from project '$PRJ_NAME'"
