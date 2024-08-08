{ pkgs, config, ... }:

{
  imports = [
    ./curl
    ./fd
    ./xclip
    ./nix
    ./home-manager
    ./wget
  ];
}
