{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.py-setup-venv;

  py-setup-venv = pkgs.writeShellApplication
    {
      name = "py-setup-venv";
      runtimeInputs = [ pkgs.python3 ];

      text = builtins.readFile ../../bin/bash/python/python-venv-setup.sh;
    };

  py-nix-sh = pkgs.writeNixApplication
    {
      name = "py-nix-sh";
      runtimeInputs = [ pkgs.python3 ];

      text = builtins.readFile ../../bin/nix/python/shell.nix;
    };
in
{
  options.modules.sh.py-setup-venv = { enable = mkEnableOption "py-setup-venv"; };

  config = mkIf cfg.enable {
    home.packages = [
      py-setup-venv
      py-nix-sh
    ];
  };
}
