{ pkgs, config, ... }:

{
  imports = [
    ./downloader
    ./db-engine
    ./gnu
    ./lib
    ./security
    ./shell
    ./utils
  ];
}
