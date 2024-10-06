{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.alias;

  lst = pkgs.writeShellApplication
    {
      name = "lst";
      text = builtins.readFile ../../bin/bash/eza/tree-icons.sh;
    };
  etcher-bin = pkgs.writeShellApplication
    {
      name = "etcher";
      text = builtins.readFile ../../../../disk-image/etcher/result/bin/etcher;
    };

in
{
  options.modules.sh.alias = { enable = mkEnableOption "alias"; };

  config = mkIf cfg.enable {
    home.packages = [
      lst
      (if config.modules.etcher then etcher-bin else { })
    ];
  };
}
