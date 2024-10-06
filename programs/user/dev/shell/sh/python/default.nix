{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.modules.sh.python;

  py-setup-venv = pkgs.writeShellApplication
    {
      name = "py-setup-venv";
      runtimeInputs = [ pkgs.python3 ];

      text = builtins.readFile ../bin/bash/python/python-venv-setup.sh;
    };

  py-nix-sh = pkgs.writeShellApplication
    {
      name = "py-nix-sh";
      runtimeInputs = [ pkgs.python3 ];

      text = ''
        nix-shell ${../bin/nix/python/shell.nix}
      '';
    };
in
{
  options.modules.sh.python = { enable = mkEnableOption "python"; };

  config = mkIf cfg.enable {
    home.packages = [
      py-setup-venv
      py-nix-sh
    ];
  };
}
