#!/usr/bin/env bash

if ! [ -z $DEVICE ]; then 
 echo "Building $DEVICE system..."; 

 sudo -v && sudo nixos-rebuild switch --flake .#$DEVICE --show-trace --impure |& nom; 
else 
  echo -e """
    DEVICE env variable is not set! 
    =============================================================
    | Choose on what system to build for the following options: |
    |###########################################################|
    | 1.personal-desktop                                        |
    | 2.work-laptop                                             |
    =============================================================
    """

read -p "Choice: " choice; 

if [ "$choice" = "1" ]; then 
        device="hosts-personal-desktop"; 

elif [ "$choice" = "2" ]; then 
  device="hosts-work-laptop"; 

else 
  echo "Error: wrong choice!"; 
  exit 1; 
fi; 

echo "Building $device system..."; 
sudo -v && sudo nixos-rebuild switch --flake .#$device --show-trace --impure |& nom; 
fi
