#!/bin/bash

# based on this post:
# https://cloudcone.com/docs/article/install-desktop-vnc-ubuntu-16-04/
apt-get update && sudo apt-get upgrade -y
apt-get install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal
apt-get tightvncserver