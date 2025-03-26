#!/usr/bin/env bash

if ! [ -z $MODEL ]; then
    echo "Building $MODEL system...";

    sudo -v && sudo nixos-rebuild switch --flake .#$MODEL --show-trace --impure |& nom;
else
    echo -e """
    MODEL env variable is not set!
    =============================================================
    | Choose on what system to build for the following options: |
    |###########################################################|
    | 1.MSI-A320M-PRO                                           |
    | 2.Lenovo-Thinkpad-p53                                     |
    | 3.Lenovo-IdeaPad-Pro5                                     |
    =============================================================
    """

    read -p "Choice: " choice;

    if [ "$choice" = "1" ]; then
        model="MSI-A320M-PRO";

    elif [ "$choice" = "2" ]; then
        model="Lenovo-Thinkpad-p53";

    elif [ "$choice" = "3" ]; then
        model="Lenovo-IdeaPad-Pro5";

    else
        echo "Error: wrong choice!";
        exit 1;
    fi;

    echo "Building $model system...";
    sudo -v && sudo nixos-rebuild switch --flake .#$model --show-trace --impure |& nom;
fi
