#!/usr/bin/env bash

sinopencode="sinopencode"
sink9s="sink9s"

# 1. Rofi calls the script without arguments on startup to list options
if [ -z "$@" ]; then
    echo "${sinopencode}"
    echo "${sink9s}"
    exit 0
fi

# 2. Rofi calls the script with the selected text as an argument
case "$1" in
    "${sinopencode}")
        # Run your custom command for Option A
        alacritty --hold -e bash -c "sinopencode"
        ;;
    "${sink9s}")
        # Run your custom command for Option B
        gedit
        ;;
esac
