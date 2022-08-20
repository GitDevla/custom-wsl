#!/bin/bash
pacman-key --init
pacman-key --populate

systemctl list-unit-files | grep enabled | cut -d ' ' -f1 | xargs sudo systemctl disable