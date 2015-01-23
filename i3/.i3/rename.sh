#!/bin/bash
# Rename current workspace

# deafult name and imput
name=$(echo -e "workspace" | dmenu)

ruby $HOME/.i3/workspace.rb "$name"
