{ pkgs, config, ... }:

{
  imports = [
    ./fzf
    ./tree
    ./zip
    ./monitor
  ];
}
