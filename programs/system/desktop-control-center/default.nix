{ pkgs, config, ... }:

{
  imports = [
    ./audio
    ./red-light
    ./app-search
    ./network
  ];
}
