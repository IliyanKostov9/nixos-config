#!/usr/bin/env bash

path=$(fd "Viber-fhs" /nix/store/ -t d)

eval "$path/opt/viber/Viber"
