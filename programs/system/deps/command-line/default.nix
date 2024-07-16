{ pkgs, config, ... }:

{
  imports = [
    ./curl
    ./xclip
    ./home-manager
    ./wget
  ];
}
