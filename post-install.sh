#!/bin/bash
((EUID != 0)) && echo "Script needs root privileges to run" && exec sudo -- "$0" "$@"

pacman-key --init
pacman-key --populate

systemctl list-unit-files | grep enabled | cut -d ' ' -f1 | xargs sudo systemctl disable