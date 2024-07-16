{ pkgs, config, ... }:

{
  imports = [
    ./curl
    ./fd
    ./xclip
    ./home-manager
    ./wget
  ];
}
