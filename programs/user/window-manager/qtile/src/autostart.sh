#!/usr/bin/env bash

dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=wlroots
systemctl --user stop xdg-desktop-portal xdg-desktop-portal-wlr
systemctl --user start pipewire-media-session

nm-applet &
blueman-applet &
copyq &
