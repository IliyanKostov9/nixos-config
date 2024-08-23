{ pkgs, config, ... }:

{
  imports = [
    ./curl
    ./nix
    ./home-manager
    ./wget
  ];
}
