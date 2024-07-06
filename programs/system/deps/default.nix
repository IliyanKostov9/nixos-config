{ pkgs, config, ... }:

{
  imports = [
    ./command-line
    ./db-engine
    ./gnu
    ./lib
    ./security
    ./shell
    ./utils
  ];
}
